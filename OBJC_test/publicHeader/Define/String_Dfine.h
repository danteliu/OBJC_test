//
//  String_Dfine.h
//  OBJC_test
//
//  Created by liu dante on 2021/11/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define DDLog(...) printf("%s %s 第%d行: %s\n",__TIME__, __PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
@interface String_Dfine : NSObject
extern NSString * const infoKey;
@end

NS_ASSUME_NONNULL_END
