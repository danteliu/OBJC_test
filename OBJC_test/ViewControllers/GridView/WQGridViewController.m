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
    self.title = @"格子视图";

    WQGridView *grid = ({
        WQGridView *obj = [[WQGridView alloc] init];
        obj.showRow = 3;
        obj.showColumn = 5;
        obj.padding = UIEdgeInsetsMake(10, 10, 10, 10);
        obj.onClickItem = ^(id  _Nonnull model) {
            Log(model);
        };
        obj.addTo(self.view);
        obj;
    });
    [grid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.right.offset(0);//紧贴上部
        make.height.mas_equalTo(240);
    }];
}

@end

@implementation WQGridView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        self.bgColor(@"random");

        self.showRow = 3;
        self.showColumn = 6;
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

    CGFloat w = (self.w - [self column] * (self.showColumn - 1) - leftRightMargin) / self.showColumn;
    CGFloat h = (self.h - [self row] * (self.showRow - 1) - topBottomMargin) / self.showRow;

    self.layout.itemSize = CGSizeMake(w, h);
}

#pragma mark -
#pragma mark const

- (CGFloat)row {/**<  行间距 */
    return 10;
}

- (CGFloat)column {/**<  列间距 */
    return 10;
}



#pragma mark -
#pragma mark delegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {/**<  每个分区的内边距（上左下右） */
    return self.padding;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {/**<  分区内cell之间的最小行间距*/
    return [self row];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {/**<  分区内cell之间的最小列间距  */
    return [self column];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"WQGridViewCell";
    WQGridViewCell *cell = (WQGridViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    cell.bgColor(@"random");
    cell.textLabel.str(self.datas[indexPath.row]);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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
            obj.minimumLineSpacing = 0;
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
            [obj registerClass:[WQGridViewCell class] forCellWithReuseIdentifier:@"WQGridViewCell"];
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
                [obj addObject:Str(i+1)];
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
