//
//  OrderModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
-(void)setDict:(NSDictionary *)dict{
    self.orderId = dict[@"id"];
    self.orderType = [dict[@"order_type"] integerValue];
    self.orderTypeStr = dict[@"titles"];
    if([dict[@"status"] integerValue] == 1){
        self.statusStr = @"审核中";
    }else if ([dict[@"status"] integerValue] == 2){
        self.statusStr = @"交易成功";
    }else if([dict[@"status"] integerValue] == 3){
        self.statusStr = @"交易失败";
    }else{
        self.statusStr = @"";
    }
    self.status = [dict[@"status"] integerValue];
    self.applyCode = dict[@"applyCode"];
    self.timeadd = [StringTool timeChange:dict[@"timeadd"]];
    self.loanmoney = dict[@"loanmoney"];
    self.imageUrl = [NSURL URLWithString:dict[@"imgs"]];
    self.order_status = dict[@"order_status"];
}
@end
