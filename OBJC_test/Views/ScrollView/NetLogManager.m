//
//  NetLogManager.m
//  OBJC_test
//
//  Created by liu dante on 2022/1/21.
//

#import "NetLogManager.h"

@implementation NetLogManager
static NetLogManager *manager = nil;
+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
@end
