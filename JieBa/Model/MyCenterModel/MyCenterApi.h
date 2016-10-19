//
//  MyCenterApi.h
//  JieBa
//
//  Created by 汪洋 on 16/10/13.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface MyCenterApi : NSObject
//邀请记录
+ (void)invitationListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//系统消息列表
+ (void)systemMessageListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//上传头像
+ (void)updataHeadWithBlock:(void (^)(NSString *imageUrl, NSError *error))block imgData:(NSData *)imgData noNetWork:(void(^)())noNetWork;

//个人中心
+ (void)getUserInfoListWithBlock:(void (^)(UserInfoModel *model, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//订单列表 不传是全部订单 1是审核中订单 2审核成功订单 3是审核失败订单
+ (void)orderListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
