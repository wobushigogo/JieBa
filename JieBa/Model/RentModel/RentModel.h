//
//  RentModel.h
//  JieBa
//
//  Created by 汪洋 on 16/10/26.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RentModel : NSObject
@property(nonatomic,copy)NSString *buy_money;
@property(nonatomic,copy)NSString *buy_count;
@property(nonatomic,copy)NSString *month_point;
@property(nonatomic,strong)NSMutableArray *firstPercentArr;
@property(nonatomic,strong)NSMutableArray *percentArr;
@property(nonatomic,strong)NSMutableArray *dealersArr;
@property(nonatomic,strong)NSDictionary *dict;
@end
