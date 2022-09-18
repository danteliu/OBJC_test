//
//  ViewController.h
//  OBJC_test
//
//  Created by liu dante on 2021/7/27.
//

#import <UIKit/UIKit.h>
#import "RandomColorVC.h"
#import "WQGridViewController.h"
#import "WQView.h"

typedef NS_ENUM(NSInteger, ViewType) {
    ViewTypePMD,/**<  跑马灯弹幕 */
    ViewTypeCyclePMD,/**<  循环跑马灯 */
    ViewTypeCycleBYPMD,/**<  (北移)循环跑马灯 */
    ViewTypeGrid,/**<  格子视图 */
    ViewTypeCradientPmd,/**<  渐变轮播图 */
    ViewTypeTimeDependent,/**<  时间相关 */
    ViewTypeTimeAutoLayoutVertical,/**<  自动竖布局 */
    ViewTypeTimeAutoLayoutHorizontal,/**<  自动横布局 */
    ViewTypeCodeSnippets,/**<  添加代码段 */
    ViewTypeRuntime,/**<  Runtime */
};

@class WQCycleModel;
@interface ViewController : UIViewController<SDCycleScrollViewDelegate>
@property (nonatomic, strong) BaseVScrollview *vScroll;/**<  <#属性注释#> */
@property (nonatomic, strong) UIView *itemsBgView; /**<  <#属性注释#> */
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView; /**<  <#属性注释#> */
@property (nonatomic, strong) NSMutableArray <WQCycleModel *> *cycleDatas;/**<  <#属性注释#> */
@end

@interface WQCycleCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *textLabel; /**<  <#属性注释#> */
@property (nonatomic, strong) UIImageView *image; /**<  <#属性注释#> */
@end

@interface WQCycleModel : NSObject
@property (nonatomic, strong) NSString *imgUrl; /**<  图片地址 */
@property (nonatomic, strong) NSString *name; /**<  名字 */
@property (nonatomic, assign) ViewType type;/**<  视图类型 */

@end
