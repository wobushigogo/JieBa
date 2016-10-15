//
//  LoginApi.h
//  JieBa
//
//  Created by 汪洋 on 16/10/13.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginApi : NSObject
//登录
+ (void)loginWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//退出登录
+ (void)logoutWithBlock:(void (^)(NSString *string, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//注册发送验证码
+(void)getYZMWithBlock:(void (^)(NSString *yzmCode, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//注册
+(void)registerWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//密码找回发送手机验证码
+(void)recoverPwdYZMWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//找回密码获取access_token
+(void)getTokenWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//提交找回密码信息
+(void)restPwdWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//修改用户名
+(void)changeUserNameWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//修改密码
+(void)changePwdWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//实名认证
+(void)trueNameWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//提交修改邀请码
+(void)changeInviteWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//修改邀请码手机验证码
+(void)changeInviteYZMWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
