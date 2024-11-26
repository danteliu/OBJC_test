//
//  NSString+WQAddModel.h
//  OBJC_test
//
//  Created by maggie.qiu on 2024/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (WQAddModel)
/// 创建一个自定义属性
@property (nonatomic, copy) NSString *me;

/// 添加参数 (链式调用)
@property (nonatomic, copy) void (^ addModel)(id datas);
@end

NS_ASSUME_NONNULL_END
