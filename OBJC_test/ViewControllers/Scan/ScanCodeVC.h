//
//  ScanCodeVC.h
//  CMCCSmartPark
//
//  Created by liu dante on 2022/4/18.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ScancodeModel;
@interface ScanCodeVC : UIViewController
@property (nonatomic, strong) ScancodeModel *inputModel; /**<  输入模型 */
@property (nonatomic, copy) void (^ scanComplete)(NSString *scanString);/**<  扫码完成回调 */

@end

@interface ScancodeModel : NSObject

@end
NS_ASSUME_NONNULL_END
