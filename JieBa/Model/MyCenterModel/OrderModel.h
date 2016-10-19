//
//  OrderModel.h
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *orderType;//订单类型 1车贷宝 2车租宝 3信用贷
@property(nonatomic,assign)NSInteger status;//订单状态 1：审核中   2：交易成功   3：交易失败
@property(nonatomic,copy)NSString *statusStr;
@property(nonatomic,copy)NSString *applyCode;//合同编号
@property(nonatomic,copy)NSString *timeadd;//申请时间
@property(nonatomic,copy)NSString *loanmoney;//借款时间
@property(nonatomic,strong)NSURL *imageUrl;
@property(nonatomic,copy)NSString *order_status;
@property(nonatomic,strong)NSDictionary *dict;
@end
