//
//  WQBzyiGradientView.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/26.
//

#import "WQBzyiGradientView.h"

@interface WQBzyiGradientView ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *tags;/**<  记录下标数组 */
@property (nonatomic, strong) PageManager *pageManager; /**<  页面管理类 */
@end

@implementation WQBzyiGradientView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.collectionView.addTo(self);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)layoutSubviews {
    if (self.bounds.size.width == 0) {
        return;
    }
    
    self.pageManager.recordWidth = self.bounds.size.width;
    
    self.layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

- (void)getTagsIndexDatas {/**<  获取 tags 的 Index 数据 */
    [self.tags removeAllObjects];
    
    if (self.dataSource.count >= [self solutenNumbers]) {
        for (int i = 0; i < [self groupCount]; i++) {
            for (int j = 0; j < self.dataSource.count; j++) {
                [self.tags addObject:[NSNumber numberWithInt:j]];
            }
        }
    } else {
        for (int j = 0; j < self.dataSource.count; j++) {
            [self.tags addObject:[NSNumber numberWithInt:j]];
        }
    }
}

- (void)loadData:(NSMutableArray *)datas {
    self.dataSource = datas;
    
    [self getTagsIndexDatas];
    [self.collectionView reloadData];
    
    if (self.dataSource.count >= [self solutenNumbers]) {
        [self changePageManager:[self groupCount] / 2 direction:ScrollDirectionLeft];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 定位到中间那组
            NSIndexPath *tempIndexPath = [NSIndexPath indexPathForItem:[self groupCount] / 2 * self.dataSource.count inSection:0];
            [self.collectionView scrollToItemAtIndexPath:tempIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            self.pageManager.centerOffsetX = self.collectionView.contentOffset.x;
            [self startTime];
        });
    }
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
    return self.tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"WQBzyiGradientViewCell";
    WQBzyiGradientViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSNumber *index = self.tags[indexPath.item];
    cell.addModel(self.dataSource[[index intValue]]);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Log(indexPath.item);
}

#pragma mark -
#pragma mark scrollView deletate
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
    
    CGFloat collectionW = self.pageManager.recordWidth;
    
    if (self.pageManager.lastContentOffset > scrollX) {
        direction = ScrollDirectionRight;
    } else if (self.pageManager.lastContentOffset < scrollX) {
        direction = ScrollDirectionLeft;
    }
    
    self.pageManager.lastContentOffset = scrollX;
    [self changePageManager:ceilf(scrollX / collectionW) direction:direction];//向上取整
    
    
    NSInteger radio = ((NSInteger)scrollX) % ((NSInteger)collectionW);
    CGFloat percent = radio / collectionW;
    percent = percent == 0 ? 1 : percent;
    self.pageManager.scale = percent;
    self.pageManager.direction = direction;
    
    if (self.scaleBlock && percent != 1) {
        self.scaleBlock(self.pageManager);
    }
}

- (void)changePageManager:(NSInteger)currentPage direction:(ScrollDirection)direction {/**<  设置前后页面 */
    if (currentPage + 1 >= self.tags.count || currentPage - 2 < 0) { //防止数组越界
        return;
    }
    
    self.pageManager.pageCurrent = currentPage;
    self.pageManager.pageBefore = currentPage - 1;
    self.pageManager.pageLast = currentPage + 1;
    
    if (direction == ScrollDirectionRight) {
        self.pageManager.colorCurrent = Str(self.tags[currentPage - 1]);
        self.pageManager.colorBefore = Str(self.tags[currentPage - 2]);
        self.pageManager.colorLast = Str(self.tags[currentPage]);
    } else if (direction == ScrollDirectionLeft) {
        self.pageManager.colorCurrent = Str(self.tags[currentPage ]);
        self.pageManager.colorBefore = Str(self.tags[currentPage - 1]);
        self.pageManager.colorLast = Str(self.tags[currentPage + 1]);
    }
}

- (void)cycleScroll {/**<  滚动计算位置 */
    CGFloat offsetX = self.collectionView.contentOffset.x;//当前的偏移量
    CGPoint pointInView = [self convertPoint:CGPointMake(0, 0) toView:self.collectionView];
    NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pointInView];
    NSInteger centerIndex = ([self groupCount] - 2) * self.dataSource.count;
    
    //    [self changePageManager:indexPathNow.item];
    //    Log(self.tags[indexPathNow.item]);
    if (indexPathNow.item >= centerIndex + self.dataSource.count || indexPathNow.item <= self.dataSource.count) {
        offsetX = self.pageManager.centerOffsetX;
        [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
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

- (void)willMoveToSuperview:(UIView *)newSuperview {/**<  关闭定时器  */
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

- (id)tags {
    if (!_tags) {
        _tags = ({
            NSMutableArray *obj = [[NSMutableArray alloc] init];
            obj;
        });
    }
    
    return _tags;
}

- (id)dataSource {
    if (!_dataSource) {
        _dataSource = ({
            NSMutableArray *obj = [[NSMutableArray alloc] init];
            obj;
        });
    }
    
    return _dataSource;
}

@end

@implementation PageManager
- (instancetype)init {
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
