//
//  NetLogManager.h
//  OBJC_test
//
//  Created by liu dante on 2022/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetLogManager : NSObject
+ (instancetype)shareManager;
@property (nonatomic, strong) NSString * tag;/**<  网络类型的特殊标记 */
@property (nonatomic, strong) NSString * path;/**<  网络路径 */
@property (nonatomic, strong) NSDictionary *header;/**<  请求头 */
@property (nonatomic, strong) NSDictionary *parameter;/**<  参数 */
@property (nonatomic, strong) NSDictionary *returnResult;/**<  返回结果 */
@end

NS_ASSUME_NONNULL_END

