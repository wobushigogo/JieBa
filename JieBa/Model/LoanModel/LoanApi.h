//
//  LoanApi.h
//  JieBa
//
//  Created by 汪洋 on 16/10/22.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoanModel.h"

@interface LoanApi : NSObject
//车贷宝信息
+ (void)loanInfoWithBlock:(void (^)(LoanModel *model, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//车贷宝发送验证码
+ (void)loanYzmWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//新增订单
+ (void)addLoanWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
