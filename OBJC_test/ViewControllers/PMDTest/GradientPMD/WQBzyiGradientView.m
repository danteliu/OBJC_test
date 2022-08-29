//
//  WQBzyiGradientView.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/26.
//

#import "WQBzyiGradientView.h"

@interface WQBzyiGradientView ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger lastContentOffset;/**<  记录用于判断方向 */
@property (nonatomic, assign) CGFloat recordWidth;/**<  记录用于判断方向 */
@property (nonatomic, strong) PageManager *pageManager; /**<  <#属性注释#> */
@end

@implementation WQBzyiGradientView{
    NSMutableArray *tags;/**<  记录下标数组 */
    CGFloat centerCellX;/**<  记录中间的偏移量 */
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        tags = [[NSMutableArray alloc] init];
        centerCellX = 0;
        [self buildUI];
    }
    
    return self;
}

- (void)loadData:(NSMutableArray *)datas {
    [self stopTime];
    self.titles = datas;
    [tags removeAllObjects];
    
    if (self.titles.count >= [self solutenNumbers]) {
        for (int i = 0; i < [self groupCount]; i++) {
            for (int j = 0; j < self.titles.count; j++) {
                [tags addObject:[NSNumber numberWithInt:j]];
            }
        }
        
        [self.collectionView reloadData];
        [self changePageManager:[self groupCount] / 2 direction:ScrollDirectionLeft];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 定位到中间那组
            NSIndexPath *tempIndexPath = [NSIndexPath indexPathForItem:[self groupCount] / 2 * self.titles.count inSection:0];
            [self.collectionView scrollToItemAtIndexPath:tempIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            centerCellX = self.collectionView.contentOffset.x;
            [self startTime];
        });
    } else {
        for (int j = 0; j < self.titles.count; j++) {
            [tags addObject:[NSNumber numberWithInt:j]];
        }
        
        [self.collectionView reloadData];
    }
}

- (void)buildUI {
    self.collectionView.addTo(self);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    //    [self startTime];
}

- (void)layoutSubviews {
    if (self.bounds.size.width == 0) {
        return;
    }
    
    self.recordWidth = self.bounds.size.width;
    
    self.layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

#pragma mark -
#pragma mark cons 重写继承这些方法
- (NSInteger)groupCount {/**<  返回重复的组数 */
    return 50;
}

- (NSInteger)solutenNumbers {/**<  隔离数 */
    return 5;
}

#pragma mark -
#pragma mark CollectionViewDelegate&DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"WQBzyiGradientViewCell";
    WQBzyiGradientViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSNumber *index = tags[indexPath.item];
    NSInteger selectIndex = [index intValue];
    
    cell.title = self.titles[selectIndex];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Log(indexPath.item);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {/**<  开始拖动 关闭定时器 */
    [self stopTime];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {/**<  手动拖拽结束 */
    [self cycleScroll];
    
    [self startTime];
    //    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];//延时2秒开始执行定时器
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {/**<  自动轮播结束 */
    [self cycleScroll];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollX = scrollView.contentOffset.x;
    ScrollDirection direction = ScrollDirectionRight;
    
    if (self.lastContentOffset > scrollX) {
        direction = ScrollDirectionRight;
    } else if (self.lastContentOffset < scrollX) {
        direction = ScrollDirectionLeft;
    }
    
    [self changePageManager:ceilf(scrollX / self.recordWidth) direction:direction];//向上取整
    
    
    NSInteger radio = ((NSInteger)scrollX) % ((NSInteger)self.recordWidth);
    CGFloat percent = radio / self.recordWidth;
    percent = percent == 0 ? 1 : percent;
    self.pageManager.scale = percent;
    self.pageManager.direction = direction;
    
    if (self.scaleBlock && percent != 1) {
        self.scaleBlock(self.pageManager);
    }
    
    self.lastContentOffset = scrollX;
}

- (void)changePageManager:(NSInteger)currentPage direction:(ScrollDirection)direction {/**<  设置前后页面 */
    if (currentPage + 1 >= tags.count) {
        return;
    }
    self.pageManager.pageCurrent = currentPage;
    self.pageManager.pageBefore = currentPage - 1;
    self.pageManager.pageLast = currentPage + 1;

    if (direction == ScrollDirectionRight) {
        self.pageManager.colorCurrent = Str(tags[currentPage - 1]);
        self.pageManager.colorBefore = Str(tags[currentPage - 2]);
        self.pageManager.colorLast = Str(tags[currentPage]);
    } else if (direction == ScrollDirectionLeft) {
        self.pageManager.colorCurrent = Str(tags[currentPage ]);
        self.pageManager.colorBefore = Str(tags[currentPage - 1]);
        self.pageManager.colorLast = Str(tags[currentPage + 1]);
    }
}

- (void)cycleScroll {/**<  滚动计算位置 */
    CGFloat offsetX = self.collectionView.contentOffset.x;//当前的偏移量
    CGPoint pointInView = [self convertPoint:CGPointMake(0, 0) toView:self.collectionView];
    NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pointInView];
    NSInteger centerIndex = ([self groupCount] - 2) * self.titles.count;
    
    //    [self changePageManager:indexPathNow.item];
    
    if (indexPathNow.item >= centerIndex + self.titles.count) {
        offsetX = centerCellX;
        [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    } else {
        //        CGFloat offset = 0.25;
        //        CGFloat offsetX = self.collectionView.contentOffset.x + offset;
        //        [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    }
}

#pragma mark -
#pragma mark 定时器操作

- (void)startTime {/**<  开启定时器 */
    [self stopTime];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showNext) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTime {/**<  关闭定时器 */
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)showNext {/**<  自动显示下一个 */
    CGFloat targetX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width;
    
    [self.collectionView setContentOffset:CGPointMake(targetX, 0) animated:true];
}

- (void)dealloc {
    [self stopTime];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {/**<  关闭定时器 */
    [super willMoveToSuperview:newSuperview];
    
    if (!newSuperview && self.timer) {
        [self stopTime];
    }
}

#pragma mark -
#pragma mark 懒加载
- (id)layout {
    if (!_layout) {
        _layout = ({
            UICollectionViewFlowLayout *obj = [[UICollectionViewFlowLayout alloc] init];
            obj.minimumLineSpacing = 0;
            obj.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            obj;
        });
    }
    
    return _layout;
}

- (id)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            UICollectionView *obj = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
            obj.delegate = self;
            obj.dataSource = self;
            obj.pagingEnabled = true;
            obj.backgroundColor = [UIColor clearColor];
            [obj registerClass:[WQBzyiGradientViewCell class] forCellWithReuseIdentifier:@"WQBzyiGradientViewCell"];
            obj.showsHorizontalScrollIndicator = false;
            obj;
        });
    }
    
    return _collectionView;
}

- (id)pageManager {
    if (!_pageManager) {
        _pageManager = ({
            PageManager *obj = [[PageManager alloc] init];
            
            obj;
        });
    }
    
    return _pageManager;
}

@end


@interface WQBzyiGradientViewCell ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation WQBzyiGradientViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:50];
    [self addSubview:self.textLabel];
}

- (void)setTitle:(NSString *)title {
    self.textLabel.text = title;
    self.bgColor([self dd][title]);
    //    self.bgColor(@"random");
}

- (NSDictionary *)dd {
    return @{
        @"1": @"#002ea6",
        @"2": @"#ffe78f",
        @"3": @"#d7000f",
        @"4": @"#ff770f",
        @"5": @"#91b822",
    };
}

@end
@implementation PageManager
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.pageBefore = 0;
        self.pageCurrent = 0;
        self.pageLast = 0;
        
        self.colorBefore = @"";
        self.colorCurrent = @"";
        self.colorLast = @"";
    }
    
    return self;
}

@end
