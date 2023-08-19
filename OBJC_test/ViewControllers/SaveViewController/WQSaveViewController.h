//
//  WQSaveViewController.h
//  OBJC_test
//
//  Created by maggie.qiu on 2023/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WQQQSavePicture;
@class WQQQSavePicModel;
@interface WQSaveViewController : UIViewController

@end


@interface WQQQSavePicture : UIView
- (instancetype)initWithFrame:(CGRect)frame;

/// 图片
@property (nonatomic, strong) UIImageView *imageViewBg;

/// 标题(星期几)
@property (nonatomic, strong) UILabel *labelTitle;

/// 描述
@property (nonatomic, strong) UILabel *labelDes;

/// 描述背景
@property (nonatomic, strong) UIView *labelDesBg;

/// 标题背景
@property (nonatomic, strong) UIView *labelTitleBg;

/// 设置配置cell
/// - Parameters:
///   - dict: 配置字典
- (void)setSaveSettingsForDict:(NSDictionary *)dict;

@end

@interface WQQQSavePicModel : NSObject
@property (nonatomic, copy) NSString * weekday;/**< 星期 */
@property (nonatomic, copy) NSString * url;/**< URL */
@property (nonatomic, copy) NSString * des;/**< 描述 */
@end



NS_ASSUME_NONNULL_END
