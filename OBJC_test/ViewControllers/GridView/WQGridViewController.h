//
//  WQGridViewController.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WQGridView;
@interface WQGridViewController : UIViewController
@property (nonatomic, strong) WQGridView *grid;/**<  <#属性注释#> */
@end

@interface WQGridView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *datas; /**<  数据源 */
@property (nonatomic, assign) CGFloat rowMargin; /**<  行距 默认为10*/
@property (nonatomic, assign) CGFloat columnMargin;/**<  列距 默认为10*/

@property (nonatomic, assign) NSInteger rowShow;/**<  显示行数 默认为3*/
@property (nonatomic, assign) NSInteger columnShow;/**<  显示列数 默认为6*/

@property (nonatomic, assign) UIEdgeInsets padding;/**<  外部边距 默认 UIEdgeInsetsMake(0, 0, 0, 0) */

@property (nonatomic, copy) void (^ onClickItem)(id model);/**<  点击 Block */

@end

@interface WQGridViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *textLabel; /**<  <#属性注释#> */

@end
NS_ASSUME_NONNULL_END
