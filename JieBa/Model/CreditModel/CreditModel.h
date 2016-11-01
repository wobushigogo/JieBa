//
//  CreditModel.h
//  JieBa
//
//  Created by 汪洋 on 16/10/21.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditModel : NSObject
@property(nonatomic,copy)NSString *minMoney;
@property(nonatomic,copy)NSString *maxMoney;
//1：未申请过、拒单、完成还款  允许贷款【去借钱】
//2：订单处于审核中  不允许贷款   【审核中请等待】
//3：完成放款，可以还款   【去还钱】，或者【已逾期，去还款】
//4：订单处于审核通过  可以签约  【去签约】【放弃订单
//5：订单处于审核通过  签约完成，等待打款【已签约等待打款】
@property(nonatomic)NSInteger order_status;
@property(nonatomic)NSInteger is_late;
@property(nonatomic,strong)NSDictionary *dict;
@end
