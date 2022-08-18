//
//  WQCyclePMDViewController.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/16.
//

#import "WQCyclePMDViewController.h"
#import <WMZBanner/WMZBannerView.h>
@interface WQCyclePMDViewController ()

@end

@implementation WQCyclePMDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(@"white");
    self.hbd_barTintColor = Color(@"white,1");
    self.title = @"循环跑马灯";
    
    CyclePMDView *dd = ({
        CyclePMDView *obj = [[CyclePMDView alloc] init];
        obj.data = @[
            @"1",
            @"2",
            @"3",
//            @"4",
//            @"5",
        ];
        obj.addTo(self.view);
        obj;
    });
    [dd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.right.offset(0); //紧贴上部
        make.height.mas_equalTo(200);
    }];
    
    
/**
 // 使用SDCycleScrollView 实现轮播
 SDCycleScrollView *cycleView=({
     SDCycleScrollView *obj=[SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:Img(@"red")];
     obj.imageURLStringsGroup=@[
         @"https://images.unsplash.com/photo-1657800589311-f1187a3697ce?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDYzOTM4Nw&ixlib=rb-1.2.1&q=80&w=1080",
         @"https://images.unsplash.com/photo-1658180129345-5b37d73409aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDYzOTM5OQ&ixlib=rb-1.2.1&q=80&w=1080",
         @"https://images.unsplash.com/photo-1660549074494-68d507ae0790?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDYzOTQxMg&ixlib=rb-1.2.1&q=80&w=1080",
         @"https://images.unsplash.com/photo-1659482023691-04d925fb35fa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDYzOTQzMg&ixlib=rb-1.2.1&q=80&w=1080",
     ];
     obj.autoScroll=NO;
     obj.showPageControl=NO;
     obj.addTo(self.view);
     obj;
 });
 [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.right.offset(0);
     make.height.mas_equalTo(200);
     make.top.equalTo(dd.mas_bottom).offset(10);
 }];
 */
    
    WMZBannerParam *param =  BannerParam()
        .wFrameSet(CGRectMake(0, 230, Screen.width, 200))
        //传入数据
        .wDataSet(@[
            @"https://images.unsplash.com/photo-1657800589311-f1187a3697ce?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDYzOTM4Nw&ixlib=rb-1.2.1&q=80&w=1080",
            @"https://images.unsplash.com/photo-1658180129345-5b37d73409aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDYzOTM5OQ&ixlib=rb-1.2.1&q=80&w=1080",
            @"https://images.unsplash.com/photo-1660549074494-68d507ae0790?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDYzOTQxMg&ixlib=rb-1.2.1&q=80&w=1080",
            @"https://images.unsplash.com/photo-1659482023691-04d925fb35fa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDYzOTQzMg&ixlib=rb-1.2.1&q=80&w=1080",
        ])
        .wRepeatSet(YES)//开启循环滚动
//        .wAutoScrollSet(YES)//开启自动滚动
        .wMarqueeSet(YES)//开启跑马灯
        .wItemSizeSet(CGSizeMake(Screen.width/2.0, 200))
        .wAutoScrollSecondSet(2);//自动滚动时间
    WMZBannerView *view = [[WMZBannerView alloc]initConfigureWithModel:param withView:self.view];
}


@end

@implementation CyclePMDView{
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
    return 200;
}

#pragma mark -
#pragma mark CollectionViewDelegate&DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"XLCycleCell";
    XLCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
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
    CGFloat w = [self getViewWidth];//item的宽度
    CGFloat offsetX = self.collectionView.contentOffset.x;//当前的偏移量
    NSInteger page = offsetX / w;//当前的页面

    if (page == 0) {//滚动到左边
        self.collectionView.contentOffset = CGPointMake(w * (self.titles.count - 2), 0);
    } else if (page == self.titles.count - 1) {//滚动到右边
        self.collectionView.contentOffset = CGPointMake(w, 0);
    }
}

#pragma mark -
#pragma mark 定时器操作

- (void)startTime {/**<  开启定时器 */
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(showNext) userInfo:nil repeats:YES];
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
    
    [self cycleScroll];
    CGFloat offset = 0.5;
    CGFloat targetX = self.collectionView.contentOffset.x + offset;
    [self.collectionView setContentOffset:CGPointMake(targetX, 0) animated:NO];
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
            //            obj.pagingEnabled = true;
            obj.backgroundColor = [UIColor clearColor];
            [obj registerClass:[XLCycleCell class] forCellWithReuseIdentifier:@"XLCycleCell"];
            obj.showsHorizontalScrollIndicator = false;
            obj;
        });
    }
    
    return _collectionView;
}

@end


@interface XLCycleCell ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation XLCycleCell

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
