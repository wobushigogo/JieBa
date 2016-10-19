//
//  UserInfoModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
-(void)setDict:(NSDictionary *)dict{
    self.avatarUrl = [NSURL URLWithString:dict[@"avatar"]];
    self.card_name_url = [NSURL URLWithString:dict[@"card_name"]];
    self.userName = dict[@"username"];
    self.balance = dict[@"balance"];
    self.assed_count = [dict[@"assed_count"] integerValue];
    self.invitecode = dict[@"invitecode"];
}
@end
