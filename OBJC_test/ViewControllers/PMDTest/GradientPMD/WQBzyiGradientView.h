//
//  WQBzyiGradientView.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/26.
//

#import <UIKit/UIKit.h>
#import "WQBzyiGradientViewCell.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ScrollDirection) {
    ScrollDirectionRight,/**<  向右 */
    ScrollDirectionLeft,/**<  向左 */
};
@class PageManager;
@interface WQBzyiGradientView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;/**<  collection layout */
@property (nonatomic, strong) UICollectionView *collectionView;/**<  collection View */
@property (nonatomic, strong) NSMutableArray *dataSource;

- (void)loadData:(NSMutableArray *)datas;/**<  加载数据 */
@property (nonatomic, copy) void (^ scaleBlock)(PageManager *pageM);/**<  监听滚动比例  */
@end

@interface PageManager : NSObject

@property (nonatomic, assign) CGFloat scale;/**<  页面滚动比例 */
@property (nonatomic, assign) ScrollDirection direction;/**<  滚动方向 */

@property (nonatomic, assign) NSInteger lastContentOffset;/**<  记录滚动的offset (用于判断滚动方向) */
@property (nonatomic, assign) CGFloat recordWidth;/**<  collectionVIew 宽度 */
@property (nonatomic, assign) CGFloat centerOffsetX;/**<  cells中间cell的偏移量 */

@property (nonatomic, assign) NSInteger pageBefore;/**<  前一页 */
@property (nonatomic, assign) NSInteger pageCurrent;/**<  当前页 */
@property (nonatomic, assign) NSInteger pageLast;/**<  下一页 */

@property (nonatomic, strong) NSString *colorBefore; /**<  前一页颜色 */
@property (nonatomic, strong) NSString *colorCurrent; /**<  当前页 颜色 */
@property (nonatomic, strong) NSString *colorLast; /**<  下一页 颜色*/

@end


NS_ASSUME_NONNULL_END
