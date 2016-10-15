//
//  InviteModel.h
//  JieBa
//
//  Created by 汪洋 on 16/10/13.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InviteModel : NSObject
//借款金额
@property(nonatomic,copy)NSString *loanmoney;
//用户手机号
@property(nonatomic,copy)NSString *mobile;
//借款时间
@property(nonatomic,copy)NSString *timeadd;
//username
@property(nonatomic,copy)NSString *username;

@property(nonatomic,strong)NSDictionary *dict;
@end
