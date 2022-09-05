//
//  WQTimeDependentVC.h
//  OBJC_test
//
//  Created by liu dante on 2022/9/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**  时间相关控制器 */
@interface WQTimeDependentVC : UIViewController

@end

typedef NS_ENUM(NSInteger, KBJCMCCTimeState) {
    KBJCMCCTimeState_Prepare = 0,        //活动准备开始
    KBJCMCCTimeState_Begin   = 1,        //活动已开始
    KBJCMCCTimeState_End     = 2,        //活动已结束
};
@interface WQTimeDependentCell : UIView
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, strong) UILabel *leftName; /**<  <#属性注释#> */
@property (nonatomic, strong) UILabel *rightName; /**<  <#属性注释#> */

@end

NS_ASSUME_NONNULL_END
