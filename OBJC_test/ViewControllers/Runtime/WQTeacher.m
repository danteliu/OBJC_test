//
//  WQTeacher.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/17.
//

#import <objc/message.h>
#import "WQTeacher.h"
@implementation WQTeacher
- (void)encodeWithCoder:(NSCoder *)coder {/**<  归档 */
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);//计算属性个数
    
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);//获得属性名字
        NSString *key = [NSString stringWithUTF8String:name];
        [coder encodeObject:[self valueForKey:key] forKey:key];//kvc获得对象
    }
    
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)coder {/**<  解档 */
    self = [super init];
    
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        
        for (NSInteger i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [coder decodeObjectForKey:key];//通过解档获得属性值
            [self setValue:value forKey:key];//设置到成员变量身上
        }
        
        free(ivars);
    }
    
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    id objCopy = [[[self class] allocWithZone:zone] init];
    
    unsigned int propertyCount = 0;
    objc_property_t *propertyArray = class_copyPropertyList([self class], &propertyCount);// 1.获取属性列表
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = propertyArray[i];
        const char *propertyName = property_getName(property);// 2.属性名字
        NSString *key = [NSString stringWithUTF8String:propertyName];
        id value = [self valueForKey:key];// 3.通过属性名拿到属性值(kvc)
        
        if ([value respondsToSelector:@selector(copyWithZone:)]) {// 4.判断 值对象是否响应copyWithZone
            [objCopy setValue:[value copy] forKey:key];//5. 设置属性值
        } else {
            [objCopy setValue:value forKey:key];
        }
    }
    
    free(propertyArray);//6.手动释放
    return objCopy;
}

@end
