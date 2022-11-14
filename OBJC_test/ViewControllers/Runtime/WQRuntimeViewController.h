//
//  WQRuntimeViewController.h
//  OBJC_test
//
//  Created by liu dante on 2022/9/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQRuntimeViewController : UIViewController

@end

@interface ChainTestView : UIView
@property (nonatomic, strong) UILabel * stringTest;/**<  <#属性注释#> */
@property (nonatomic, readonly, copy) void (^addModel)(NSDictionary *res);/**<  <#参数说明#> */
- (instancetype)init;
@end

NS_ASSUME_NONNULL_END
