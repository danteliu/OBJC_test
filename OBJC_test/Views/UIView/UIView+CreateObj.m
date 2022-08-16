//
//  UIView+CreateObj.m
//  OBJC_test
//
//  Created by liu dante on 2021/9/2.
//

#import "UIView+CreateObj.h"

@implementation UIView (CreateObj)
+(id)getView:(void(^)(UIView *obj))rBlock{
    UIView *obj=[[self alloc]init];
    rBlock(obj);
    return obj;
}
-(UIView *(^)(BOOL isShow))isAnimationShwo{
    return ^(BOOL isShow){
        CGFloat animationTime=0.4;
        [UIView animateWithDuration:animationTime animations:^{
            self.alpha=isShow==YES?1:0;
        }];
        return self;
    };
}
@end
