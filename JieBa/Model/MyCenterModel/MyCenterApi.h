//
//  MyCenterApi.h
//  JieBa
//
//  Created by 汪洋 on 16/10/13.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCenterApi : NSObject
//邀请记录
+ (void)invitationListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//系统消息列表
+ (void)systemMessageListWithBlock:(void (^)(NSMutableArray *array, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
