//
//  RentModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/26.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RentModel.h"

@implementation RentModel
-(void)setDict:(NSDictionary *)dict{
    self.buy_money = dict[@"buy_money"];
    self.buy_count = dict[@"buy_count"];
    self.month_point = dict[@"buy_setting"][@"month_point"];
    self.firstPercentArr = [[NSMutableArray alloc] init];
    self.percentArr = [[NSMutableArray alloc] init];
    [[dict[@"buy_setting"][@"first_percent"] allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *string = [NSString stringWithFormat:@"%@期首付比例%@",obj,dict[@"buy_setting"][@"first_percent"][obj]];
        string = [string stringByAppendingString:@"%"];
        [self.firstPercentArr addObject:string];
        [self.percentArr addObject:obj];
    }];
    
    self.dealersArr = [NSMutableArray arrayWithArray:dict[@"dealers"]];
    
}
@end
