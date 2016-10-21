//
//  SendRequst.m
//  KeychainDemo
//
//  Created by 汪洋 on 15/7/29.
//  Copyright (c) 2015年 汪洋. All rights reserved.
//

#import "SendRequst.h"
#import "AFAppDotNetAPIClient.h"
#import "ConnectionAvailable.h"
#import "MD5.h"
#import "JSONKit.h"

@implementation SendRequst

+ (void) sendRequestWithUrlString : (NSString*) urlString
                           success:(void (^)(id responseDic)) success
                           failure:(void(^)(NSError *error)) failure
                           apiName:(NSString *)apiName
                         noNetWork:(void (^)())noNetWork{
    
    NSLog(@"urlString=========%@",urlString);
    
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *signStr = [NSString stringWithFormat:@"IOS|123456|%@",apiName];
    NSString *newUrlString = [NSString stringWithFormat:@"%@&_deviceid_=%@&_client_=IOS&_sign_=%@&_token_=%@",urlString,identifierForVendor,[MD5 md5HexDigestPost:signStr],[LoginSqlite getdata:@"token"]];
    
    NSString * encodedString = [newUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"urlStr = %@",encodedString);
    [[AFAppDotNetAPIClient sharedClient] GET:encodedString
                                  parameters:nil
                                     success:^(NSURLSessionDataTask *task, id responseObject) {
                                         [SendRequst dealSuccessWithreRponseObject:responseObject success:success failure:failure];
                                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         NSLog(@"error ===> %@",error);
                                         [SendRequst HudFailWithNetWorkErr:error failure:failure];
                                     }];
    
    
}

+(void)formRequstWithUrlString:(NSString *)urlString
                  postParamDic:(NSMutableDictionary *)postParamDic
                       success:(void (^)(id responseDic))success
                       failure:(void(^)(NSError *error))failure
                       apiName:(NSString *)apiName
                     noNetWork:(void (^)())noNetWork{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *signStr = [NSString stringWithFormat:@"IOS|123456|%@",apiName];
    NSLog(@"signStr====> %@",signStr);
    [postParamDic setObject:identifierForVendor forKey:@"_deviceid_"];
    [postParamDic setObject:@"IOS" forKey:@"_client_"];
    [postParamDic setObject:[MD5 md5HexDigestPost:signStr] forKey:@"_sign_"];
    [postParamDic setObject:[StringTool stringWithNull:[LoginSqlite getdata:@"token"]] forKey:@"_token_"];
    NSLog(@"postDic=========%@",postParamDic);
    NSLog(@"urlString=========%@",urlString);
    
    [[AFAppDotNetAPIClient sharedClient] POST:urlString
                                   parameters:postParamDic
                                      success:^(NSURLSessionDataTask *task, id responseObject) {
                                          [SendRequst dealSuccessWithreRponseObject:responseObject success:success failure:failure];
                                      }
                                      failure:^(NSURLSessionDataTask *task, NSError *error) {
                                          NSLog(@"error ===> %@",error);
                                          [SendRequst HudFailWithNetWorkErr:error failure:failure];
                                      }];
}

+(void)postImageRequstWithUrlString:(NSString *)urlString
                       postParamDic:(NSMutableDictionary *)postParamDic
                       imageDataArr:(NSMutableArray *)imageDataArr
                            success:(void (^)(id responseDic))success
                            failure:(void(^)(NSError *error))failure
                            apiName:(NSString *)apiName
                          noNetWork:(void (^)())noNetWork{
    NSLog(@"postDic=========%@",postParamDic);
    NSLog(@"urlString=========%@",urlString);
    
    
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *signStr = [NSString stringWithFormat:@"IOS|123456|%@",apiName];
    [postParamDic setObject:identifierForVendor forKey:@"_deviceid_"];
    [postParamDic setObject:@"IOS" forKey:@"_client_"];
    [postParamDic setObject:[MD5 md5HexDigestPost:signStr] forKey:@"_sign_"];
    [postParamDic setObject:[StringTool stringWithNull:[LoginSqlite getdata:@"token"]] forKey:@"_token_"];
    
    
    [[AFAppDotNetAPIClient sharedClient] POST:urlString
                                   parameters:postParamDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                       [imageDataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                           [formData appendPartWithFileData:obj name:[NSString stringWithFormat:@"file_%lu",(unsigned long)idx] fileName:[NSString stringWithFormat:@"image_%lu.jpg",(unsigned long)idx] mimeType:@"image/jpg"];
                                       }];
                                   }
                                      success:^(NSURLSessionDataTask *task, id responseObject) {
                                          [SendRequst dealSuccessWithreRponseObject:responseObject success:success failure:failure];
                                      }
                                      failure:^(NSURLSessionDataTask *task, NSError *error) {
                                          NSLog(@"error ===> %@",error);
                                          [SendRequst HudFailWithNetWorkErr:error failure:failure];
                                      }];
}


/**
 *  处理获取服务器返回成功的数据
 *
 *  @param responseObject json数据
 */
+ (void)dealSuccessWithreRponseObject:(id)responseObject
                              success:(void (^)(id responseDic)) success
                              failure:(void(^)(NSError *error)) failure{
    NSLog(@"responseObject=========%@",[responseObject[@"errorcode"] class]);
    NSLog(@"responseObject=========%@",responseObject);
    if ([responseObject[@"errorcode"] integerValue] == 0 && [responseObject[@"errorcode"] isKindOfClass:[NSNumber class]]) {
        if(success){
            success(responseObject);
        }
    }else{
        NSString *err=[NSString stringWithFormat:@"%@",responseObject[@"errormsg"]];
        NSString *errCode=[NSString stringWithFormat:@"%@",responseObject[@"errorcode"]];
        NSError *error=[NSError errorWithDomain:err code:[errCode integerValue] userInfo:@{@"errorCode":errCode}];
        [SendRequst HudFailWithErrMessage:error];
        if(failure){
            failure(error);
        }
    }
}


/**
 *  处理进入异常错误
 *
 *  @param error 自定义的NSError
 */
+(void)HudFailWithNetWorkErr:(NSError *)error failure:(void(^)(NSError *error)) failure{
    NSLog(@"userInfo-------%@",error.userInfo);
    NSLog(@"%@",error.userInfo[@"NSLocalizedDescription"]);
    NSLog(@"%ld",(long)error.code);
    [SendRequst AddAlertView:error.userInfo[@"NSLocalizedDescription"]];
    if(failure){
        failure(error);
    }
}

/**
 *  处理服务器返回的错误
 *
 *  @param error 服务器返回的NSError
 */
+(void)HudFailWithErrMessage:(NSError *)error{
    NSLog(@"===>%@",error.domain);
    NSLog(@"%ld",(long)error.code);
    NSLog(@"===>%@",error.userInfo);
    [SendRequst AddAlertView:error.domain];
    if([error.userInfo[@"errorCode"] isEqualToString:@"NOT_LOGIN"]){
        [LoginSqlite deleteAll];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginAgain" object:nil];
    }
}

+(void)AddAlertView:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
@end
