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
}
@end
