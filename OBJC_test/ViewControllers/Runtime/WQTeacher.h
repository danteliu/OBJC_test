//
//  WQTeacher.h
//  OBJC_test
//
//  Created by liu dante on 2022/9/17.
//

#import <Foundation/Foundation.h>
#import "WQTeacherType.h"

NS_ASSUME_NONNULL_BEGIN
@interface WQTeacher : NSObject <NSCopying>
@property (nonatomic, copy) NSString *stringName; /**<  <#属性注释#> */
@property (nonatomic, copy) NSString *stringAge; /**<  <#属性注释#> */
@property (nonatomic, copy) NSString *stringAge1; /**<  <#属性注释#> */
@property (nonatomic, copy) NSString *stringAge2; /**<  <#属性注释#> */
@property (nonatomic, copy) NSString *stringAge3; /**<  <#属性注释#> */
@property (nonatomic, copy) WQTeacherType *type;

@end

NS_ASSUME_NONNULL_END
