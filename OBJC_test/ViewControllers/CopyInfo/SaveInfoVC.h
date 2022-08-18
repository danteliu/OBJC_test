//
//  SaveInfoVC.h
//  OBJC_test
//
//  Created by liu dante on 2021/11/17.
//

#import <UIKit/UIKit.h>
#import "SaveInfoCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface SaveInfoVC : UIViewController

@end

@interface AddInfoView : UIView
@property (nonatomic, copy) void (^clickCommit)(SaveInfoModel *model);/**<  点击确定按钮 */
-(instancetype)initWithFrame:(CGRect)frame;
-(void)setPasteString;/**<  设置剪贴板内容 */
@end


NS_ASSUME_NONNULL_END
