//
//  LoanApi.m
//  JieBa
//
//  Created by 汪洋 on 16/10/22.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "LoanApi.h"
#import "SendRequst.h"

@implementation LoanApi
+ (void)loanInfoWithBlock:(void (^)(LoanModel *model, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?order"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        LoanModel *model = [[LoanModel alloc] init];
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

+ (void)loanYzmWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
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

+ (void)addLoanWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
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
