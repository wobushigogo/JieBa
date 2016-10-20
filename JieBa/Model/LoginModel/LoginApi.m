//
//  LoginApi.m
//  JieBa
//
//  Created by 汪洋 on 16/10/13.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "LoginApi.h"
#import "SendRequst.h"

@implementation LoginApi
+ (void)loginWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_login"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        [LoginSqlite insertData:responseDic[@"dataresult"][@"_token_"] datakey:@"token"];
        [LoginSqlite insertData:responseDic[@"dataresult"][@"username"] datakey:@"userName"];
        [LoginSqlite insertData:dic[@"mobile"] datakey:@"phone"];
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_login" noNetWork:nil];
}

+ (void)logoutWithBlock:(void (^)(NSString *string, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_logout"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_logout" noNetWork:nil];
}

+(void)getYZMWithBlock:(void (^)(NSString *yzmCode, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_register"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_register" noNetWork:nil];
}

+(void)registerWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_register"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        [LoginSqlite insertData:responseDic[@"dataresult"][@"_token_"] datakey:@"token"];
        [LoginSqlite insertData:responseDic[@"dataresult"][@"username"] datakey:@"userName"];
        [LoginSqlite insertData:dic[@"mobile"] datakey:@"phone"];
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_register" noNetWork:nil];
}

+(void)recoverPwdYZMWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_recoverpwd"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_recoverpwd" noNetWork:nil];
}

+(void)getTokenWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_recoverpwd"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_recoverpwd" noNetWork:nil];
}

+(void)restPwdWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_recoverpwd"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_recoverpwd" noNetWork:nil];
}

+(void)changeUserNameWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_changeuserinfo"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_changeuserinfo" noNetWork:nil];
}

+(void)changePwdWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_changeuserinfo"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_changeuserinfo" noNetWork:nil];
}

+(void)trueNameWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_changeuserinfo"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_changeuserinfo" noNetWork:nil];
}

+(void)changeInviteWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_changeuserinfo"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_changeuserinfo" noNetWork:nil];
}

+(void)changeInviteYZMWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_changeuserinfo"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_changeuserinfo" noNetWork:nil];
}
@end
