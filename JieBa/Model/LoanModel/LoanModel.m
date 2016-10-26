//
//  LoanModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/24.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "LoanModel.h"

@implementation LoanModel
-(void)setDict:(NSDictionary *)dict{
    self.borrow_money = dict[@"borrow_money"];
    self.borrow_count = dict[@"borrow_count"];
    self.loanMonthArr = [[NSMutableArray alloc] initWithArray:dict[@"borrow_setting"][@"loanmonth"]];
}
@end
