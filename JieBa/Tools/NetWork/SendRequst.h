//
//  SendRequst.h
//  KeychainDemo
//
//  Created by 汪洋 on 15/7/29.
//  Copyright (c) 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络请求
 */
@interface SendRequst : NSObject
/**
 *  get请求
 *
 *  @param urlString 请求的url地址
 *  @param success   获取的数据的block
 *  @param failure   错误的block
 *  @param noNetWork 没有网络的block
 */
+(void)sendRequestWithUrlString:(NSString *)urlString
                        success:(void(^)(id responseDic))success
                        failure:(void(^)(NSError *error))failure
                        apiName:(NSString *)apiName
                      noNetWork:(void(^)())noNetWork;

/**
 *  post请求
 *
 *  @param urlString    请求的url地址
 *  @param postParamDic 上传给服务器的json
 *  @param success      获取的数据的block
 *  @param failure      错误的block
 *  @param noNetWork    没有网络的block
 */
+(void)formRequstWithUrlString:(NSString *)urlString
                  postParamDic:(NSMutableDictionary *)postParamDic
                       success:(void (^)(id responseDic))success
                       failure:(void(^)(NSError *error))failure
                       apiName:(NSString *)apiName
                     noNetWork:(void(^)())noNetWork;

/**
 *  上传图片
 *
 *  @param urlString    请求的url地址
 *  @param postParamDic 上传给服务器的json
 *  @param imageDataArr 上传的图片的数组
 *  @param success      获取的数据的block
 *  @param failure      错误的block
 *  @param noNetWork    没有网络的block
 */
+(void)postImageRequstWithUrlString:(NSString *)urlString
                       postParamDic:(NSMutableDictionary *)postParamDic
                       imageDataArr:(NSMutableArray *)imageDataArr
                            success:(void (^)(id responseDic))success
                            failure:(void(^)(NSError *error))failure
                            apiName:(NSString *)apiName
                          noNetWork:(void(^)())noNetWork;

@end
