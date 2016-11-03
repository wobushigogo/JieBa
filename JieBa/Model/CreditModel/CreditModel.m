//
//  CreditModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/21.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CreditModel.h"

@implementation CreditModel
-(void)setDict:(NSDictionary *)dict{
    self.minMoney = dict[@"minMoney"];
    self.maxMoney = dict[@"maxMoney"];
    self.order_status = [dict[@"order_status"] integerValue];
    self.is_late = [dict[@"is_late"] integerValue];
    self.loanmoney = dict[@"order_info"][@"loanmoney"];
    self.credit_total_num = dict[@"credit_total_num"];
    self.credit_total_money = dict[@"credit_total_money"];
}
@end
