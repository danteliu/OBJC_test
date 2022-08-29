//
//  WQBzyiGradientView.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ScrollDirection) {
    ScrollDirectionRight,/**<  向右 */
    ScrollDirectionLeft,/**<  向左 */
};
@class PageManager;
@interface WQBzyiGradientView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *titles;

- (void)loadData:(NSMutableArray *)datas;/**<  加载数据 */
@property (nonatomic, copy) void (^ scaleBlock)(PageManager *pageM);/**<  监听滚动比例  */


@end
@interface WQBzyiGradientViewCell : UICollectionViewCell
@property (nonatomic, copy) NSString *title;
@end

@interface PageManager : NSObject

@property (nonatomic, assign) CGFloat scale;/**<  页面滚动比例 */
@property (nonatomic, assign) ScrollDirection direction;/**<  滚动方向 */

@property (nonatomic, assign) NSInteger pageBefore;/**<  前一页 */
@property (nonatomic, assign) NSInteger pageCurrent;/**<  当前页 */
@property (nonatomic, assign) NSInteger pageLast;/**<  下一页 */

@property (nonatomic, strong) NSString *colorBefore; /**<  前一页颜色 */
@property (nonatomic, strong) NSString *colorCurrent; /**<  当前页 颜色 */
@property (nonatomic, strong) NSString *colorLast; /**<  下一页 颜色*/

@end


NS_ASSUME_NONNULL_END
