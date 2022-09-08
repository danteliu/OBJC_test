//
//  WQLeftAndRightLabelView.h
//  OBJC_test
//
//  Created by liu dante on 2022/9/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQLeftAndRightLabelView : UIView
@property (nonatomic, strong) UILabel *labelDes; /**<  <#属性注释#> */
@property (nonatomic, strong) UILabel *labelDesTest; /**<  <#属性注释#> */
@property (nonatomic, strong) UIView *viewLeft;/**<  <#属性注释#> */

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
