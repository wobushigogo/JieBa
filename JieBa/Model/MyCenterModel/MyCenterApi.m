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
#import "MessageModel.h"
#import "AssedModel.h"

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
        if([responseDic[@"dataresult"][@"systemlist"] count] !=0){
            for(NSDictionary *item in responseDic[@"dataresult"][@"systemlist"]){
                MessageModel *model = [[MessageModel alloc] init];
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
    } apiName:@"system" noNetWork:nil];
}

+ (void)systemMessageInfoWithBlock:(void (^)(MessageModel *model, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?system"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        MessageModel *model = [[MessageModel alloc] init];
        [model setDict:responseDic[@"dataresult"][@"systemlist"]];
        if(block){
            block(model,nil);
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
            block(responseDic[@"dataresult"][@"avatar"],nil);
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

+ (void)waitCommentListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?order"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if([responseDic[@"dataresult"][@"assedlist"] count] !=0){
            for(NSDictionary *item in responseDic[@"dataresult"][@"assedlist"]){
                AssedModel *model = [[AssedModel alloc] init];
                [model setDict:item];
                model.is_assed = NO;
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

+ (void)endCommentListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?order"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if([responseDic[@"dataresult"][@"assedlist"] count] !=0){
            for(NSDictionary *item in responseDic[@"dataresult"][@"assedlist"]){
                AssedModel *model = [[AssedModel alloc] init];
                [model setDict:item];
                model.is_assed = YES;
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

+ (void)updataUserNameWithBlock:(void (^)(NSString *userName, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
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

+ (void)updataPwdWithBlock:(void (^)(NSString *pwd, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
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

+(void)getUserInfoWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?member_changeuserinfo"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"][@"member_info"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"member_changeuserinfo" noNetWork:nil];
}

+(void)realWithBlock:(void (^)(NSString *string, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
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

+ (void)orderLoanInfoWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?order"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:responseDic[@"dataresult"][@"loanerp"][@"ContractNo"]];
        [arr addObject:responseDic[@"dataresult"][@"loanerp"][@"is_repayment"]];
        [arr addObject:[StringTool timeChange2:responseDic[@"dataresult"][@"loanerp"][@"UpdateDate"]]];
        [arr addObject:[NSString stringWithFormat:@"%@元",responseDic[@"dataresult"][@"loanerp"][@"ApplayMoney"]]];
        [arr addObject:[NSString stringWithFormat:@"%@元",responseDic[@"dataresult"][@"loanerp"][@"MatchMoney"]]];
        [arr addObject:[NSString stringWithFormat:@"%@元",responseDic[@"dataresult"][@"loanerp"][@"leftMoney"]]];
        [arr addObject:[NSString stringWithFormat:@"%@期",responseDic[@"dataresult"][@"loanerp"][@"periodes"]]];
        [arr addObject:[StringTool timeChange2:responseDic[@"dataresult"][@"loanerp"][@"BackDate"]]];
        [arr addObject:[NSString stringWithFormat:@"%@元",responseDic[@"dataresult"][@"loanerp"][@"BackTotalMoney"]]];
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

+ (void)orderRentInfoWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?order"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:responseDic[@"dataresult"][@"loanerp"][@"applyCode"]];
        [arr addObject:[StringTool timeChange2:responseDic[@"dataresult"][@"loanerp"][@"timeadd"]]];
        [arr addObject:[NSString stringWithFormat:@"%@元",responseDic[@"dataresult"][@"loanerp"][@"backtotalmoney"]]];
        [arr addObject:[StringTool timeChange2:responseDic[@"dataresult"][@"loanerp"][@"loanmonth"]]];
        [arr addObject:responseDic[@"dataresult"][@"loanerp"][@"city"]];
        [arr addObject:responseDic[@"dataresult"][@"loanerp"][@"dealer"]];
        [arr addObject:responseDic[@"dataresult"][@"loanerp"][@"car_brand"]];
        [arr addObject:responseDic[@"dataresult"][@"loanerp"][@"car_class"]];
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

+ (void)addCashWithBlock:(void (^)(NSMutableDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?cash"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"cash" noNetWork:nil];
}

+ (void)withdrawCashWithBlock:(void (^)(NSMutableDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?cash"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"cash" noNetWork:nil];
}

+ (void)getFuyouInfoWithBlock:(void (^)(NSMutableDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?credit"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"][@"fuyou_info"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"credit" noNetWork:nil];
}

+ (void)feedBackWithBlock:(void (^)(NSMutableDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?view"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"view" noNetWork:nil];
}

+ (void)orderCommentInfoWithBlock:(void (^)(NSMutableDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"?order"];
    [SendRequst formRequstWithUrlString:urlStr postParamDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"dataresult"][@"data"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } apiName:@"order" noNetWork:nil];
}
@end
