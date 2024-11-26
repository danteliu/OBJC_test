//
//  NSString+WQAddModel.m
//  OBJC_test
//
//  Created by maggie.qiu on 2024/11/26.
//

#import "NSString+WQAddModel.h"
#import <objc/runtime.h>

@implementation NSString (WQAddModel)
#pragma mark -
#pragma mark 添加测试属性
- (NSString *)me {
    return objc_getAssociatedObject(self, @selector(me));
}

- (void)setMe:(NSString *)me {
    objc_setAssociatedObject(self, @selector(me), me, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark -
#pragma mark 添加模型
- (void (^)(id))addModel {
    return objc_getAssociatedObject(self, @selector(addModel));
}


- (void)setAddModel:(void (^)(id))addModel {
    objc_setAssociatedObject(self, @selector(addModel), addModel, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
