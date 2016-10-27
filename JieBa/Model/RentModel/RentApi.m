//
//  RentApi.m
//  JieBa
//
//  Created by 汪洋 on 16/10/26.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RentApi.h"
#import "SendRequst.h"

@implementation RentApi
+ (void)rentInfoWithBlock:(void (^)(RentModel *model, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?order"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        RentModel *model = [[RentModel alloc] init];
        [model setDict:responseDic[@"dataresult"]];
        if(block){
            block(model,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"order" noNetWork:nil];
}

+ (void)rentYzmWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?order"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"order" noNetWork:nil];
}

+ (void)addRentWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?order"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"order" noNetWork:nil];
}
@end
