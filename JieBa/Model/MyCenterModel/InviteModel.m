//
//  InviteModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/13.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "InviteModel.h"

@implementation InviteModel
-(void)setDict:(NSDictionary *)dict{
    self.loanmoney = dict[@"loanmoney"];
    self.mobile = dict[@"mobile"];
    self.timeadd = dict[@"timeadd"];
    self.username = dict[@"username"];
}
@end
