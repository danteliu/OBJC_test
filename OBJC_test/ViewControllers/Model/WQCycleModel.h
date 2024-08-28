//
//  WQCycleModel.h
//  OBJC_test
//
//  Created by maggie.qiu on 2024/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ViewType) {
    ViewTypePMD,/**<  跑马灯弹幕 */
    ViewTypeCyclePMD,/**<  循环跑马灯 */
    ViewTypeCycleBYPMD,/**<  (北移)循环跑马灯 */
    ViewTypeGrid,/**<  格子视图 */
    ViewTypeCradientPmd,/**<  渐变轮播图 */
    ViewTypeTimeDependent,/**<  时间相关 */
    ViewTypeTimeAutoLayoutVertical,/**<  自动竖布局 */
    ViewTypeTimeAutoLayoutHorizontal,/**<  自动横布局 */
    ViewTypeCodeSnippets,/**<  添加代码段 */
    ViewTypeRuntime,/**<  Runtime */
};
@interface WQCycleModel : NSObject
@property (nonatomic, strong) NSString *imgUrl; /**<  图片地址 */
@property (nonatomic, strong) NSString *name; /**<  名字 */
@property (nonatomic, assign) ViewType type;/**<  视图类型 */
@end

NS_ASSUME_NONNULL_END
