//
//  CarlifeApi.m
//  JieBa
//
//  Created by 汪洋 on 16/10/27.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CarlifeApi.h"
#import "SendRequst.h"
#import "CarlifeModel.h"

@implementation CarlifeApi
+ (void)carlifeListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?carlife"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if([responseDic[@"dataresult"][@"assed_list"] count] !=0){
            for(NSDictionary *item in responseDic[@"dataresult"][@"assed_list"]){
                CarlifeModel *model = [[CarlifeModel alloc] init];
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
    } apiName:@"carlife" noNetWork:nil];
}

+ (void)carlifeInfoWithBlock:(void (^)(CarlifeModel *model, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?carlife"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        CarlifeModel *model = [[CarlifeModel alloc] init];
        [model setDict:responseDic[@"dataresult"][@"list"]];
        if(block){
            block(model,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"carlife" noNetWork:nil];
}

+ (void)commentListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?carlife"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if([responseDic[@"dataresult"][@"list"] count] !=0){
            for(NSDictionary *item in responseDic[@"dataresult"][@"list"]){
                CommentModel *model = [[CommentModel alloc] init];
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
    } apiName:@"carlife" noNetWork:nil];
}

+ (void)addCommentWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?carlife"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        if(block){
            block(arr,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"carlife" noNetWork:nil];
}

+ (void)goodCarlifeWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?carlife"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        if(block){
            block(arr,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"carlife" noNetWork:nil];
}

+ (void)delGoodCarlifeWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?carlife"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        if(block){
            block(arr,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"carlife" noNetWork:nil];
}

+ (void)delCarlifeWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?carlife"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        if(block){
            block(arr,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"carlife" noNetWork:nil];
}

+ (void)delCommentWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?carlife"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        if(block){
            block(arr,nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"carlife" noNetWork:nil];
}

+ (void)assedCommitWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic imageDataArr:(NSMutableArray *)imageDataArr noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?carlife"];
    
    NSMutableArray *imgArr = [[NSMutableArray alloc] init];
    [imageDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[NSData class]]){
            [imgArr addObject:obj];
        }
    }];
    NSLog(@"===>%@",imgArr);
    [SendRequst postImageRequstWithUrlString:urlStr postParamDic:dic imageDataArr:imgArr success:^(id responseDic) {
        if(block){
            block([NSMutableArray array],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"carlife" noNetWork:nil];
}
@end
