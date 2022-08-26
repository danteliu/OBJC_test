//
//  WQCradientPmdView.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/26.
//

#import "WQCradientPmdView.h"

@implementation WQCradientPmdView{
    NSTimer *timer;
}
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
    [self startTime];
}

- (void)layoutSubviews {
    self.layout.itemSize = CGSizeMake([self getViewWidth], self.bounds.size.height);
    self.collectionView.frame = self.bounds;
    [self.collectionView setContentOffset:CGPointMake([self getViewWidth], 0)];
}

#pragma mark -
#pragma mark const
- (CGFloat)getViewWidth {
    return Screen.width;
}

#pragma mark -
#pragma mark CollectionViewDelegate&DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"GradientCycleCell";
    GradientCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.title = self.titles[indexPath.row];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {/**<  手动拖拽结束 */
    [self cycleScroll];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {/**<  自动轮播结束 */
    [self cycleScroll];
}

- (void)cycleScroll {/**<  滚动 offset */
    NSInteger page = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    
    if (page == 0) {  //滚动到左边
        self.collectionView.contentOffset = CGPointMake(self.collectionView.bounds.size.width * (self.titles.count - 2), 0);
    } else if (page == self.titles.count - 1) {//滚动到右边
        self.collectionView.contentOffset = CGPointMake(self.collectionView.bounds.size.width, 0);
    } else {
    }
}

#pragma mark -
#pragma mark 定时器操作

- (void)startTime {/**<  开启定时器 */
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showNext) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)stopTime {/**<  关闭定时器 */
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)showNext {/**<  自动显示下一个 */
    if (self.collectionView.isDragging) {/**<  手指拖拽是禁止自动轮播 */
        return;
    }
    
    CGFloat targetX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:CGPointMake(targetX, 0) animated:true];
}

#pragma mark -
#pragma mark Setter

- (void)setData:(NSArray<NSString *> *)data {/**<  设置数据时在第一个之前和最后一个之后分别插入数据 */
    self.titles = [NSMutableArray arrayWithArray:data];
    [self.titles addObject:data.firstObject];
    [self.titles insertObject:data.lastObject atIndex:0];
    
    //    self.pageControl.numberOfPages = data.count;
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
            obj.pagingEnabled = YES;
            obj.backgroundColor = [UIColor clearColor];
            [obj registerClass:[GradientCycleCell class] forCellWithReuseIdentifier:@"GradientCycleCell"];
            obj.showsHorizontalScrollIndicator = false;
            obj;
        });
    }
    
    return _collectionView;
}

@end

@interface GradientCycleCell ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation GradientCycleCell

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

