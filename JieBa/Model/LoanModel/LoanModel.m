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
    NSLog(@"==>%@",dict[@"loanmonth"]);
    self.loanMonthArr = [[NSMutableArray alloc] initWithArray:dict[@"loanmonth"]];
}
@end
