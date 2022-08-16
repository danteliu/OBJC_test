//
//  UIView+CreateObj.h
//  OBJC_test
//
//  Created by liu dante on 2021/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CreateObj)
+(id)getView:(void(^)(UIView *obj))rBlock;/**<  快捷创建 视图 */
-(UIView *(^)(BOOL isShow))isAnimationShwo;/**<  动画显示视图 */
@end

NS_ASSUME_NONNULL_END
