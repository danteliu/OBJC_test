//
//  WQGridViewController.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/18.
//

#import "WQGridViewController.h"

@interface WQGridViewController ()

@end

@implementation WQGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(@"white");
    self.hbd_barTintColor = Color(@"white,1");
    self.hbd_barShadowHidden = YES;
    self.title = @"格子视图";
    
    
    self.grid.addTo(self.view);
    [self.grid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.right.offset(0);//紧贴上部
        make.height.mas_equalTo(240);
    }];
}

- (id)grid {
    if (!_grid) {
        _grid = ({
            WQGridView *obj = [[WQGridView alloc] init];
            obj.rowMargin = 10;
            obj.columnMargin = 10;
            obj.rowShow = 3;
            obj.columnShow = 5;
            obj.padding = UIEdgeInsetsMake(10, 10, 10, 10);
            obj.onClickItem = ^(id _Nonnull model) {
                Log(model);
            };
            obj;
        });
    }
    
    return _grid;
}

@end

@implementation WQGridView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.bgColor(@"random");
        
        self.rowMargin = 10;
        self.columnMargin = 10;
        self.rowShow = 3;
        self.columnShow = 6;
        self.padding = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.collectionView.addTo(self);
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    //左右边距
    CGFloat leftRightMargin = self.padding.left + self.padding.right;
    //前后边距
    CGFloat topBottomMargin = self.padding.top + self.padding.bottom;
    
    CGFloat w = (self.w - self.columnMargin * (self.columnShow - 1) - leftRightMargin) / self.columnShow;
    CGFloat h = (self.h - self.rowMargin * (self.rowShow - 1) - topBottomMargin) / self.rowShow;
    
    self.layout.itemSize = CGSizeMake(w, h);
}
-(void)registClassName:(UICollectionView *)view{/**<  注册类名 */
    NSArray <Class>*classArr=@[
        [WQGridViewCell class],
    ];
    [classArr enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [view registerClass:obj forCellWithReuseIdentifier:NSStringFromClass(obj)];
    }];
}

#pragma mark -
#pragma mark delegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {/**<  每个分区的内边距（上左下右） */
    return self.padding;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {/**<  分区内cell之间的最小行间距*/
    return self.rowMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {/**<  分区内cell之间的最小列间距  */
    return self.columnMargin;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {/**<  返回个数 */
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {/**<  cell实现 */
    static NSString *cellId = @"WQGridViewCell";
    WQGridViewCell *cell = (WQGridViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.bgColor(@"random");
    cell.textLabel.str(self.datas[indexPath.row]);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {/**<  点击方法 */
    if (self.onClickItem) {
        self.onClickItem(self.datas[indexPath.row]);
    }
}

#pragma mark -
#pragma mark WQGridView 懒加载
- (id)layout {
    if (!_layout) {
        _layout = ({
            UICollectionViewFlowLayout *obj = [[UICollectionViewFlowLayout alloc] init];
            obj.scrollDirection = UICollectionViewScrollDirectionVertical;
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
            obj.backgroundColor = [UIColor clearColor];
            [self registClassName:obj];
            obj.showsHorizontalScrollIndicator = false;
            obj;
        });
    }
    
    return _collectionView;
}

- (id)datas {
    if (!_datas) {
        _datas = ({
            NSMutableArray *obj = [[NSMutableArray alloc] init];
            
            for (NSInteger i = 0; i < 100; i++) {
                [obj addObject:Str(i + 1)];
            }
            
            obj;
        });
    }
    
    return _datas;
}

@end
@implementation WQGridViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.textLabel.addTo(self);
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark -
#pragma mark 懒加载
- (id)textLabel {
    if (!_textLabel) {
        _textLabel = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.textAlignment = NSTextAlignmentCenter;
            obj.font = [UIFont fontWithName:@"AmericanTypewriter" size:30];
            obj.color(@"white");
            obj;
        });
    }
    
    return _textLabel;
}

//- (NSDictionary *)dd {
//    return @{
//        @"1": @"red",
//        @"2": @"yellow",
//        @"3": @"blue",
//        @"4": @"green",
//        @"5": @"purple",
//    };
//}
@end
