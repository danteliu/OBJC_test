//
//  WQGridViewController.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQGridViewController : UIViewController

@end

@interface WQGridView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
-(instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray * datas;/**<  数据源 */
@property (nonatomic, assign) NSInteger showRow;/**<  显示的行数 默认为3*/
@property (nonatomic, assign) NSInteger showColumn;/**<  显示的列数 默认为6*/
@property (nonatomic, assign) UIEdgeInsets padding;/**<  外部边距 默认 UIEdgeInsetsMake(0, 0, 0, 0) */

@property (nonatomic, copy) void (^onClickItem)(id model);/**<  点击 Block */

@end

@interface WQGridViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel * textLabel;/**<  <#属性注释#> */

@end
NS_ASSUME_NONNULL_END
