//
//  HomeVC.h
//  CMCCSmartPark
//
//  Created by liu dante on 2022/3/17.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface HomeVC : UITabBarController

@end
@interface TabarModel : NSObject
@property(nonatomic,strong) UIViewController *targetVC;/**<  目标VC */
@property(nonatomic,strong) NSString *title;/**<  标题 */

@property(nonatomic,strong) NSString *selImg;/**<  选中图片 */
@property(nonatomic,strong) NSString *noSelImg;/**<  未选中图片 */

@property(nonatomic,strong) UIColor *noSelectColor;/**<  未选中的颜色 */
@property(nonatomic,strong) UIColor *selectColor;/**<  选中的颜色 */

@property(nonatomic,assign) CGFloat picW;/**<  宽度 */
@property(nonatomic,assign) CGFloat fontSize;/**<  字体大小 */

@property(nonatomic,strong) UIImage *tabbarBg;/**<  tabbar 背景图 */
@property(nonatomic,strong) UIImage *navgationBarBg;/**<  navgationBar 背景图 */

@property(nonatomic,strong) UIImage *tabbarShadow;/**<  tabbar 阴影图 */
@property(nonatomic,strong) UIImage *navgationBarShadow;/**<  navgationBar 阴影图 */

@end


NS_ASSUME_NONNULL_END
