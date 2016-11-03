//
//  CreditApi.h
//  JieBa
//
//  Created by 汪洋 on 16/10/21.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreditModel.h"
#import "CreditListModel.h"

@interface CreditApi : NSObject
//信用贷信息
+ (void)creditWithBlock:(void (^)(CreditModel *model, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//借款记录
+ (void)creditListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//信用贷借款记录详情
+ (void)creditDetailWithBlock:(void (^)(CreditDetailModel *model, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//绑定富友金账户获取手机验证码
+ (void)fuiouYzmWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//提交绑定富友金账户
+ (void)bindFuiouWithBlock:(void (^)(NSString *message, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取信用贷申请 验证码
+ (void)creditYzmWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//提交信用贷申请
+ (void)addCreditWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//提交签约
+ (void)sginCreditWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//放弃订单
+ (void)giveUpCreditWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//信用贷还款基本信息
+ (void)repayInfoWithBlock:(void (^)(NSMutableDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//提交信用贷还款
+ (void)repayMoneyWithBlock:(void (^)(NSMutableDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
