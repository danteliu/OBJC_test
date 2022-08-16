//
//  AAQYAlertView.h
//  OBJC_test
//
//  Created by liu dante on 2021/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAQYAlertView : UIView
@property (nonatomic,strong)NSArray *titles;/**<  选项数组 */
@property (nonatomic, strong) void (^onclickBtn)(AAQYAlertView *view,NSInteger buttonIndex);/**<  点击block */

-(instancetype)initWithFrame:(CGRect)frame;
-(UILabel *)titleLB;
-(UILabel* )messageLB;
- (void)show;/**<  显示 */
- (void)close;/**<  隐藏 */
@end

NS_ASSUME_NONNULL_END
