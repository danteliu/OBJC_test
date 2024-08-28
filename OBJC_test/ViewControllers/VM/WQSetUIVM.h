//
//  WQSetUIVM.h
//  OBJC_test
//
//  Created by maggie.qiu on 2024/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQSetUIVM : NSObject
/// 当前控制器
@property (nonatomic, strong) UIViewController *currentViewContoller;
/// 初始化格子视图
- (void)cellUI;
/// demo Main ui set up
- (void)setupUI;
@end

NS_ASSUME_NONNULL_END
