//
//  CreditListModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/21.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CreditListModel.h"

@implementation CreditListModel
-(void)setDict:(NSDictionary *)dict{
    self.orderId = dict[@"id"];
    self.timeadd = [NSString stringWithFormat:@"%@借",dict[@"timeadd"]];
    self.loanmoney = dict[@"loanmoney"];
    self.order_status_name = dict[@"order_status_name"];
    if([self.order_status_name isEqualToString:@"已完成"]){
        self.status = 0;
    }else if ([self.order_status_name isEqualToString:@"未通过"]){
        self.status = 1;
    }else if ([self.order_status_name isEqualToString:@"使用中"]){
        self.status = 2;
    }else if ([self.order_status_name isEqualToString:@"审核中"]){
        self.status = 3;
    }else if ([self.order_status_name isEqualToString:@"已逾期"]){
        self.status = 4;
    }else{
        self.status = 1;
    }
}
@end


@implementation CreditDetailModel

-(void)setDict:(NSDictionary *)dict{
    self.credit_order_status = [dict[@"credit_order_status"] integerValue];
    self.loanmoney = dict[@"loanmoney"];
    self.timeadd = dict[@"timeadd"];
    self.back_date = dict[@"back_date"];
    self.back_time = dict[@"back_time"];
    self.pay_time = dict[@"pay_time"];
    self.late_fee = dict[@"late_fee"];
    self.late_days = dict[@"late_days"];
}

@end
