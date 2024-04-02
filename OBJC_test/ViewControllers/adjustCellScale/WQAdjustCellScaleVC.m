//
//  WQAdjustCellScaleVC.m
//  OBJC_test
//
//  Created by maggie.qiu on 2024/4/1.
//

#import "WQAdjustCellScaleLayout.h"
#import "WQAdjustCellScaleOneCell.h"
#import "WQAdjustCellScaleVC.h"

@interface WQAdjustCellScaleVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) WQAdjustCellScaleLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation WQAdjustCellScaleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initData];
    [self initView];
}

/// 初始化导航栏
- (void)initNavigation {
    self.hbd_barTintColor = Color(@"white,1");
    self.hbd_barShadowHidden = YES;
    self.title = @"cell缩放";
}

/// 初始化数据
- (void)initData {
}

/// 初始化视图
- (void)initView {
    self.view.bgColor(@"white");

    // 如果需要，将collectionView添加到视图层次结构中
    [self.view addSubview:self.collectionView];
    // 使用Masonry进行布局
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-60);
    }];
    // 添加滑块到视图
    [self.view addSubview:self.slider];

    // 设置滑块布局
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.equalTo(self.collectionView.mas_bottom).offset(0);
        make.bottom.offset(0);
    }];
}

// 重新加载collectionView的数据
- (void)reloadCollectionViewData {
    [self.collectionView reloadData];
}

// 重新加载collectionView中特定项的数据
- (void)reloadItemsAtIndexes:(NSArray<NSIndexPath *> *)indexPaths {
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
}

// 滑块值改变事件处理
- (void)sliderValueChanged:(UISlider *)slider {
//    NSLog(@"Slider value changed: %f", slider.value);
    self.layout.itemScale = slider.value;
}

#pragma mark -
#pragma mark UICollectionView delegate & dataSouce
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {/**<  分区数 */
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {/**<  返回个数 */
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {/**<  cell实现 */
    NSString *cellId = NSStringFromClass([WQAdjustCellScaleOneCell class]);
    WQAdjustCellScaleOneCell *cell = (WQAdjustCellScaleOneCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    cell.textLabel.text = Str(indexPath.row);
    cell.textLabel.bgColor(@"random");
    cell.name = @"乱七八糟";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {/**<  点击方法 */
}

#pragma mark -
#pragma mark 懒加载
- (WQAdjustCellScaleLayout *)layout {
    if (!_layout) {
        _layout = [[WQAdjustCellScaleLayout alloc] init];
        _layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }

    return _layout;
}

// 懒加载collectionView属性
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = Color(@"random");
        [_collectionView registerClass:[WQAdjustCellScaleOneCell class]
            forCellWithReuseIdentifier:NSStringFromClass([WQAdjustCellScaleOneCell class])];
    }

    return _collectionView;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 0;
        _slider.maximumValue = 1;
        _slider.value = 1; // 初始值
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }

    return _slider;
}

@end
