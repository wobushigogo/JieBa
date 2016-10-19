//
//  MyCenterApi.m
//  JieBa
//
//  Created by 汪洋 on 16/10/13.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MyCenterApi.h"
#import "SendRequst.h"
#import "InviteModel.h"
#import "OrderModel.h"

@implementation MyCenterApi
+ (void)invitationListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_recommend"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if([responseDic[@"dataresult"][@"recommlist"] isKindOfClass:[NSArray class]]){
            for(NSDictionary *item in responseDic[@"dataresult"][@"recommlist"]){
                InviteModel *model = [[InviteModel alloc] init];
                [model setDict:item];
                [arr addObject:model];
            }
        }
        if(block){
            block(arr,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_recommend" noNetWork:nil];
}

+ (void)systemMessageListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?system"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if([responseDic[@"dataresult"][@"systemlist"] isKindOfClass:[NSArray class]]){
            for(NSDictionary *item in responseDic[@"dataresult"][@"systemlist"]){
                
            }
        }
        if(block){
            block(arr,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"system" noNetWork:nil];
}

+ (void)updataHeadWithBlock:(void (^)(NSString *imageUrl, NSError *error))block imgData:(NSData *)imgData noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?system"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"system" forKey:@"_cmd_"];
    [dict setObject:@"avatar" forKey:@"type"];
    [SendRequst postImageRequstWithUrlString:urlStr postParamDic:dict imageDataArr:[NSMutableArray arrayWithObject:imgData] success:^(id responseDic) {
        if(block){
            block(nil,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"system" noNetWork:nil];
}

+ (void)getUserInfoListWithBlock:(void (^)(UserInfoModel *model, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?system"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        UserInfoModel *userInfoModel = [[UserInfoModel alloc] init];
        [userInfoModel setDict:responseDic[@"dataresult"][@"info"]];
        if(block){
            block(userInfoModel,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"system" noNetWork:nil];
}

+ (void)orderListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?order"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if([responseDic[@"dataresult"][@"orderlist"] count] !=0){
            for(NSDictionary *item in responseDic[@"dataresult"][@"orderlist"]){
                OrderModel *model = [[OrderModel alloc] init];
                [model setDict:item];
                [arr addObject:model];
            }
        }
        if(block){
            block(arr,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"order" noNetWork:nil];
}
@end
