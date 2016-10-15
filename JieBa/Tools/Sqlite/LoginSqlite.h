//
//  LoginSqlite.h
//  mybuilding
//
//  Created by 汪洋 on 15/7/31.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  保存个人登录信息的本地数据库
 */
@interface LoginSqlite : NSObject
/**
 *  创建table
 */
+(void)opensql;

/**
 *  插入数据
 *
 *  @param data    要插入的数据
 *  @param datakey 插入取数据时的key
 */
+(void)insertData:(NSString *)data datakey:(NSString *)datakey;

/**
 *  获取数据
 *
 *  @param datakey 数据对应的key
 *
 *  @return 取出数据字符串
 */
+(NSString *)getdata:(NSString *)datakey;

+(void)deleteAll;
@end
