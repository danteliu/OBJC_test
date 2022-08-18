//
//  ViewController.h
//  OBJC_test
//
//  Created by liu dante on 2021/7/27.
//

#import <UIKit/UIKit.h>
#import "RandomColorVC.h"
#import "WQView.h"
#import "WQGridViewController.h"

typedef NS_ENUM(NSInteger, ViewType) {
    ViewTypePMD,/**<  跑马灯 */
    ViewTypeCyclePMD,/**<  循环跑马灯 */
    ViewTypeCycleBYPMD,/**<  (北移)循环跑马灯 */
    ViewTypeGrid,/**<  格子视图 */
};
@interface ViewController : UIViewController<SDCycleScrollViewDelegate>
@property (nonatomic, strong) BaseVScrollview *vScroll;/**<  <#属性注释#> */
@property (nonatomic, strong) UIView * itemsBgView;/**<  <#属性注释#> */
@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;/**<  <#属性注释#> */
@property (nonatomic, strong) NSMutableArray * cycleDatas;/**<  <#属性注释#> */
@property (nonatomic, strong) NSMutableArray * cycleTitleDatas;/**<  <#属性注释#> */
@end

@interface WQCycleCell : UICollectionViewCell
@property (nonatomic, strong) UILabel * textLabel;/**<  <#属性注释#> */
@property (nonatomic, strong) UIImageView * image;/**<  <#属性注释#> */
@end



