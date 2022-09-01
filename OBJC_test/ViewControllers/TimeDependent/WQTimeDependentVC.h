//
//  WQTimeDependentVC.h
//  OBJC_test
//
//  Created by liu dante on 2022/9/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQTimeDependentVC : UIViewController

@end

typedef NS_ENUM(NSInteger,ActiveStatus) {
    ActiveStatusStartNo,/**<  活动未开始 */
    ActiveStatusStart,/**<  活动开始 */
    ActiveStatusEnd,/**<  活动结束 */
};
@interface WQTimeDependentCell : UIView
-(instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, strong) UILabel * leftName;/**<  <#属性注释#> */
@property (nonatomic, strong) UILabel * rightName;/**<  <#属性注释#> */

@end

NS_ASSUME_NONNULL_END
