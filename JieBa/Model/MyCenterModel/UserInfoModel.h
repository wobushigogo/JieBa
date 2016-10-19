//
//  UserInfoModel.h
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
@property(nonatomic,strong)NSURL *avatarUrl;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,assign)NSInteger assed_count;//待评价数量
@property(nonatomic,strong)NSString *balance;//余额
@property(nonatomic,strong)NSURL *card_name_url;//二维码图像
@property(nonatomic,strong)NSString *invitecode;//邀请码
@property(nonatomic,strong)NSDictionary *dict;
@end
