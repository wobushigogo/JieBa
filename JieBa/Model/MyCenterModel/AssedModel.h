//
//  AssedModel.h
//  JieBa
//
//  Created by 汪洋 on 2016/11/7.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssedModel : NSObject
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,assign)NSInteger orderType;
@property(nonatomic,copy)NSString *orderTypeStr;//订单类型 1车贷宝 2车租宝 3信用贷
@property(nonatomic,copy)NSString *statusStr;
@property(nonatomic,copy)NSString *applyCode;//合同编号
@property(nonatomic,copy)NSString *timeadd;//申请时间
@property(nonatomic,copy)NSString *loanmoney;
@property(nonatomic,strong)NSURL *imageUrl;
@property(nonatomic,copy)NSString *backTotalMoney;
@property(nonatomic,copy)NSString *assedId;
@property(nonatomic)BOOL is_assed;
@property(nonatomic,strong)NSDictionary *dict;
@end
