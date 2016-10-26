//
//  RentApi.h
//  JieBa
//
//  Created by 汪洋 on 16/10/26.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RentModel.h"

@interface RentApi : NSObject
//车租宝信息
+ (void)rentInfoWithBlock:(void (^)(RentModel *model, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
