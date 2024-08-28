//
//  WQTestVM.h
//  OBJC_test
//
//  Created by maggie.qiu on 2024/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQTestVM : NSObject
/// 当前控制器
@property (nonatomic, strong) UIViewController *currentViewContoller;
/// 运行测试
- (void)run;
@end

NS_ASSUME_NONNULL_END
