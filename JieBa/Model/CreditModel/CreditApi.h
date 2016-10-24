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
@end
