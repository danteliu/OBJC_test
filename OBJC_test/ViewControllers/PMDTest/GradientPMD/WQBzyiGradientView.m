//
//  WQBzyiGradientView.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/26.
//

#import "WQBzyiGradientView.h"

@interface WQBzyiGradientView ()
@property (nonatomic, strong) NSTimer *timer;
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
    self.layout.itemSize = CGSizeMake([self getViewWidth], self.bounds.size.height);
//    [self.collectionView setContentOffset:CGPointMake([self getViewWidth], 0)];
}

#pragma mark -
#pragma mark cons 重写继承这些方法
- (CGFloat)getViewWidth {/**<  宽度 */
    return Screen.width;
}

- (NSInteger)groupCount {/**<  返回重复的组数 */
    return 20;
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {/**<  手动拖拽结束 */
    [self cycleScroll];
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];//延时2秒开始执行定时器
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {/**<  自动轮播结束 */
    [self cycleScroll];
}

- (void)cycleScroll {/**<  滚动计算位置 */
    CGFloat offsetX = self.collectionView.contentOffset.x;//当前的偏移量
    CGPoint pointInView = [self convertPoint:CGPointMake(0, 0) toView:self.collectionView];
    NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pointInView];
    NSInteger centerIndex = ([self groupCount] - 2) * self.titles.count;

    NSLog(@"dddd indexPathNow.item:%ld", (long)indexPathNow.item);

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
    if (self.collectionView.isDragging) {/**<  手指拖拽是禁止自动轮播 */
        return;
    }

//    [self cycleScroll];
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
}

- (NSDictionary *)dd {
    return @{
        @"1": @"red",
        @"2": @"yellow",
        @"3": @"blue",
        @"4": @"green",
        @"5": @"purple",
    };
}

@end
