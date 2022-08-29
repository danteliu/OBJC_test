//
//  WQBzyiGPMDView.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/28.
//

#import <UIKit/UIKit.h>
#import "WQBzyiGradientView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WQBzyiGPMDView : UIView
-(instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;/**<  渐变图层 */
@property (nonatomic, strong) WQBzyiGradientView * cc;/**<  <#属性注释#> */
@end

NS_ASSUME_NONNULL_END
