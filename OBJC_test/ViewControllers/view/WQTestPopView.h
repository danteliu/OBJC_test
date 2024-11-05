//
//  WQPopView.h
//  OBJC_test
//
//  Created by maggie.qiu on 2024/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQTestPopView : UIView
/// 背景视图
@property (nonatomic, strong) UIView *bgView;

/// 第一个色块视图
@property (nonatomic, strong) UIView *colorBlock1;

/// 第二个色块视图
@property (nonatomic, strong) UIView *colorBlock2;

/// 第三个色块视图
@property (nonatomic, strong) UIView *colorBlock3;
@end

NS_ASSUME_NONNULL_END
