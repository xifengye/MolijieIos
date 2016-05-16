//
//  HttpTool.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/26.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "BinaryData.h"
#import "AppDataMemory.h"
#import "AESCrypt.h"

#define AFManager [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://112.124.61.35:9999/int/android_api/"]]
#define AES_PASSWORD @"c028a24f2c6a5c39"

@implementation HttpTool

+(NSDictionary *)aesParams:(NSDictionary *)params{
    NSMutableDictionary* aesParams = [NSMutableDictionary dictionary];
    NSArray* keys = [params allKeys];
    for (int i = 0; i < keys.count; i++)
    {
        NSString* key = [keys objectAtIndex: i];
        id value = [params objectForKey: key];
        [aesParams setObject:[AESCrypt encrypt:value password:AES_PASSWORD] forKey:key];
    }
    return aesParams;
}

+(NSDictionary*)getHeaderParams:(BOOL)appToken hasUserToken:(BOOL)userToken{
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionary];
    if(appToken){
        [headerParams setObject:[AESCrypt encrypt:[AppDataMemory instance].appToken.token password:AES_PASSWORD] forKey:@"CLIENT_HEADER_1"];
    }
    if(userToken){
        [headerParams setObject:[AESCrypt encrypt:[AppDataMemory instance].userToken.token password:AES_PASSWORD] forKey:@"CLIENT_HEADER_2"];
    }
    return headerParams;
}

+(void)addHeaderParams:(AFHTTPRequestOperationManager*) manager headerParams:(NSDictionary*)params{
    NSArray* keys = [params allKeys];
    for (int i = 0; i < keys.count; i++)
    {
        NSString* key = [keys objectAtIndex: i];
        id value = [params objectForKey: key];
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
}

+(void)GET:(NSString *)url params:(id)params headerParams:(id)headerParams success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPRequestOperationManager* manager = AFManager;
    [HttpTool addHeaderParams:manager headerParams:headerParams];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure){
            failure(error);
        }
    }];

}

+(void)POST:(NSString *)url params:(id)params headerParams:(id)headerParams success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSLog(@"POST  URL:%@  Params:%@",url,params);
    AFHTTPRequestOperationManager* manager = AFManager;
    [HttpTool addHeaderParams:manager headerParams:headerParams];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        if(failure){
            failure(error);
        }
    }];

}

+(void)POST:(NSString *)url textParams:(id)textParams headerParams:(id)headerParams binaryParams:(id)binaryParams success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPRequestOperationManager* manager = AFManager;
    [HttpTool addHeaderParams:manager headerParams:headerParams];
    [manager POST:url parameters:textParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //constructingBodyWithBlock这个block在发送请求之前会自动调用
        for(BinaryData* data in binaryParams){
            [formData appendPartWithFileData:data.data name:data.paramName fileName:data.serverFileName mimeType:data.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure){
            failure(error);
        }
    }];

}

+(void)MLJGET:(NSString *)url params:(id)params hasAppToken:(BOOL)appToken hasUserToken:(BOOL)userToken hasAES:(BOOL)aes success:(void (^)(MLJResponse *))success failure:(void (^)(NSError *))failure{
    if(aes){
        params = [HttpTool aesParams:params];
    }
    [HttpTool GET:url params:params headerParams:[HttpTool getHeaderParams:appToken hasUserToken:userToken] success:^(id response) {
        MLJResponse* r = [MLJResponse objectWithKeyValues:response];
        success(r);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+(void)MLJPOST:(NSString *)url params:(id)params hasAppToken:(BOOL)appToken hasUserToken:(BOOL)userToken hasAES:(BOOL)aes success:(void (^)(MLJResponse *))success failure:(void (^)(NSError *))failure{
    if(aes){
        params = [HttpTool aesParams:params];
    }
    [HttpTool POST:url params:params headerParams:[HttpTool getHeaderParams:appToken hasUserToken:userToken] success:^(id response) {
        MLJResponse* r = [MLJResponse objectWithKeyValues:response];
        if(success){
            success(r);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
