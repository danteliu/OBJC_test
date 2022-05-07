//
//  ManagerNet.m
//  CMCCSmartPark
//
//  Created by liu dante on 2022/4/13.
//

#import "ManagerNet.h"
static ManagerNet *manager = nil;
@implementation ManagerNet
+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
+ (AFHTTPSessionManager *)shareAFNManager{
    return ({
        AFHTTPSessionManager *obj = [AFHTTPSessionManager manager];
        obj.requestSerializer = [AFJSONRequestSerializer serializer];
        obj.requestSerializer.timeoutInterval = 30.0f;// 超时时间
        obj.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithArray:@[
            @"application/xml",
            @"text/xml",
            @"text/html",
            @"application/json",
            @"text/plain",
        ]];// 设置接收的Content-Type
        obj;
    });
}
+(void)beginPost:(NSString *)path model:(NetRequestModel *)res success:(void (^)(NetResponseModel * respose))success error:(void (^)(NSError *error))err{
    Log(path);
    Log(res.par);
    Log(res.header);
    [[self shareAFNManager] POST:path parameters:res.par headers:res.header progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Log([NetResponseModel mj_objectWithKeyValues:responseObject].mj_keyValues);
        NetResponseModel *res=[NetResponseModel mj_objectWithKeyValues:responseObject];
        success(res);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        err(error);
    }];
}

#pragma mark -
#pragma mark 网络接口
-(void)login:(NetRequestModel *)model success:(successRsp)success error:(errorRsp)err{
//    username rsa
//    password rsa
//    [self beginPost:ManagerAPI.share.login model:model success:^(NetResponseModel *respose) {
//        success(respose);
//    } error:^(NSError *error) {
//        err(error);
//    }];
}
+(void)getRandomColor:(NetRequestModel *)model success:(successRsp)success error:(nonnull errorRsp)err{
    NSString *path=@"https://www.fastmock.site/mock/81e82bca25efe9ef25af1fe9b1c36a0d/wjmfmiyk/getRandomXXX";
    [self beginPost:path model:model success:^(NetResponseModel *respose) {
        success(respose);
    } error:^(NSError *error) {
        err(error);
    }];
}

@end

@implementation NetRequestModel
-(id)par{
    if (!_par) {
        _par=({
            NSMutableDictionary *obj=[[NSMutableDictionary alloc] init];
            obj;
        });
    }
    return _par;
}
-(id)header{
    if (!_header) {
        _header=({
            NSMutableDictionary *obj=[[NSMutableDictionary alloc] init];
            obj;
        });
    }
    return _header;
}
@end

@implementation NetResponseModel

@end
