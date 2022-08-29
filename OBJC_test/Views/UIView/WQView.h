//
//  WQView.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WQModel;
@interface WQView : UIView
@property (nonatomic, strong) UILabel *textLable; /**<  <#属性注释#> */
@property (nonatomic, strong) UIImageView *imageBg; /**<  <#属性注释#> */

@property (nonatomic, readonly, copy) void (^ addModel)(NSDictionary *res);/**<  <#参数说明#> */

@property (nonatomic, copy) void (^ clickView)(void);/**<  <#属性注释#> */
- (instancetype)initWithFrame:(CGRect)frame;
@end

@interface WQModel : NSObject
@property (nonatomic, strong) NSString * name;/**<  名字 */
@property (nonatomic, strong) NSString * imgBgUrl;/**<  图片背景url */
@end

NS_ASSUME_NONNULL_END
