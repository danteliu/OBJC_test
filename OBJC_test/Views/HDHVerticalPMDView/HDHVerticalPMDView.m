//  HDHVerticalPMDView.m


#import "HDHVerticalPMDView.h"

static CGFloat ScrollInterval = 3.0f;/**<  轮播间隔 */
@interface HDHVerticalPMDView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation HDHVerticalPMDView{
    dispatch_source_t timer;/**<  异步轮播定时器 */
    UICollectionViewFlowLayout *layout;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    layout = ({
        UICollectionViewFlowLayout *obj=[[UICollectionViewFlowLayout alloc] init];
        obj.minimumLineSpacing = 0;
        obj.scrollDirection = UICollectionViewScrollDirectionVertical;
        obj;
    });
    
    self.collection = ({
        UICollectionView *obj=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        obj.delegate = self;
        obj.dataSource = self;
        obj.pagingEnabled = YES;
        obj.backgroundColor = [UIColor clearColor];
        [obj registerClass:[testcell class] forCellWithReuseIdentifier:@"testcell"];
        obj.showsVerticalScrollIndicator = YES;
        [self addSubview:obj];
        obj;
    });
    _autoPage = NO;
}
-(void)layoutSubviews{
    layout.itemSize = self.bounds.size;
    self.collection.frame=self.bounds;
    [self.collection setContentOffset:CGPointMake(0, [self getH])];

}
#pragma mark -
#pragma mark 定时器操作
-(void)startTime{/**<  开启定时器 */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, ScrollInterval * NSEC_PER_SEC), ScrollInterval * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showNext];
        });
    });
    dispatch_resume(timer);
}

-(void)stopTime{/**<  关闭定时器 */
    if (timer!=nil) {
        dispatch_cancel(timer);
        timer = nil;
    }
}

#pragma mark -
#pragma mark CollectionViewDelegate&DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellId = @"testcell";
    testcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.title = self.datas[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectForObj) {
        self.selectForObj(self.datas[indexPath.row]);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {/**<  手动拖拽结束 */
    [self cycleScroll];
    if (_autoPage) {/**<  拖拽动作后间隔3s继续轮播 */
        [self startTime];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {/**<  自动轮播结束 */
    [self cycleScroll];
}

- (void)cycleScroll {/**<  循环显示 */
    NSInteger page = self.collection.contentOffset.y/[self getH];
    if (page == 0) {/**<  滚动到上边 */
        self.collection.contentOffset = CGPointMake(0,[self getH] * (self.datas.count - 2));
    }else if (page == self.datas.count - 1){//滚动到下边
        self.collection.contentOffset = CGPointMake(0, [self getH]);
    }
}


#pragma mark -
#pragma mark Setter
//设置数据时在第一个之前和最后一个之后分别插入数据
- (void)setData:(NSArray<NSString *> *)data {
    self.datas = [NSMutableArray arrayWithArray:data];
    [self.datas addObject:data.firstObject];
    [self.datas insertObject:data.lastObject atIndex:0];
    [self.collection reloadData];
}

- (void)setAutoPage:(BOOL)autoPage {
    _autoPage = autoPage;
    [self startTime];
}

#pragma mark -
#pragma mark 轮播方法
- (void)showNext {/**<  自动显示下一个 */
    if (self.collection.isDragging) {/**<  手指拖拽是禁止自动轮播 */ return;}
    CGFloat targetX=self.collection.contentOffset.y+[self getH];
    NSLog(@"%@ targetX:%.f",[self currentDateStr],targetX);
    [self.collection setContentOffset:CGPointMake(0, targetX) animated:YES];
}
-(CGFloat)getH{/**<  获取高度 */
    return self.collection.bounds.size.height;
}

- (void)dealloc {
    dispatch_cancel(timer);
}
//获取当前时间
- (NSString *)currentDateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    [dateFormatter setDateFormat:@"ss"];

    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
@end

@implementation testcell
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
}

@end
