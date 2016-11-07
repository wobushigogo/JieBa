//
//  AssedModel.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/7.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "AssedModel.h"

@implementation AssedModel
-(void)setDict:(NSDictionary *)dict{
    self.orderId = dict[@"id"];
    self.orderType = [dict[@"order_type"] integerValue];
    if(self.orderType == 1){
        self.orderTypeStr = @"车贷宝";
    }else if (self.orderType == 2){
        self.orderTypeStr = @"车租宝";
    }else{
        self.orderTypeStr = @"信用贷";
    }
    self.applyCode = dict[@"applyCode"];
    self.timeadd = dict[@"timeadd"];
    self.loanmoney = dict[@"loanmoney"];
    self.imageUrl = [NSURL URLWithString:dict[@"logo"]];
    self.backTotalMoney = dict[@"backtotalmoney"];
    self.statusStr = @"交易成功";
    self.assedId = dict[@"is_assed"];
}
@end
