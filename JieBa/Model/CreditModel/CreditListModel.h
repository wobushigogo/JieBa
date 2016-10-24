//
//  CreditListModel.h
//  JieBa
//
//  Created by 汪洋 on 16/10/21.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditListModel : NSObject
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *loanmoney;
@property(nonatomic,copy)NSString *timeadd;
@property(nonatomic,copy)NSString *order_status_name;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSDictionary *dict;
@end


@interface CreditDetailModel : NSObject
@property(nonatomic)NSInteger credit_order_status;
@property(nonatomic,copy)NSString *loanmoney;
@property(nonatomic,copy)NSString *timeadd;
@property(nonatomic,copy)NSString *back_date;
@property(nonatomic,copy)NSString *back_time;
@property(nonatomic,copy)NSString *pay_time;
@property(nonatomic,copy)NSString *late_fee;
@property(nonatomic,copy)NSString *late_days;
@property(nonatomic,strong)NSDictionary *dict;
@end
