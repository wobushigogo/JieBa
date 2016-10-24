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
@property(nonatomic,strong)NSDictionary *dict;
@end
