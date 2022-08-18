//
//  WQView.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQView : UIView
@property (nonatomic, strong) UILabel * textLable;/**<  <#属性注释#> */
@property (nonatomic, copy) void (^clickView)(void);/**<  <#属性注释#> */


-(instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
