//
//  ManagerNet.h
//  CMCCSmartPark
//
//  Created by liu dante on 2022/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class NetRequestModel;
@class NetResponseModel;
@interface ManagerNet : NSObject
+ (instancetype)share;
typedef void (^successRsp)(NetResponseModel * rsp);/**<  成功回调 */
typedef void (^errorRsp)(NSError *error);/**<  失败回调 */

-(void)login:(NetRequestModel *)model success:(successRsp)success error:(errorRsp)err;/**<  密码登录 */
+(void)getRandomColor:(NetRequestModel *)model success:(successRsp)success error:(errorRsp)err;/**<  密码登录 */
@end

@interface NetRequestModel : NSObject
@property(nonatomic,strong) NSMutableDictionary *par;/**<  请求参数 */
@property(nonatomic,strong) NSMutableDictionary *header;/**<  请求头 */

@end

@interface NetResponseModel : NSObject
@property (nonatomic, strong) NSArray * xxx;/**<  结果说明 */
@end


NS_ASSUME_NONNULL_END
