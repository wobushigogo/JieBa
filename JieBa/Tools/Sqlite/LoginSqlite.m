//
//  LoginSqlite.m
//  mybuilding
//
//  Created by 汪洋 on 15/7/31.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import "LoginSqlite.h"
#import "FMDB.h"

@implementation LoginSqlite
+(void)opensql{
    NSLog(@"%@",DataBasePath);
    FMDatabase *db = [FMDatabase databaseWithPath:DataBasePath];
    
    if ([db open]) {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS Login (data Text ,datakey Text)"];
        BOOL res = [db executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
        [db close];
        
    }
}

+(void)insertData:(NSString *)data datakey:(NSString *)datakey{
    FMDatabase *db = [FMDatabase databaseWithPath:DataBasePath];
    if([db open]){
        NSInteger count = [LoginSqlite loadKey:datakey];
        if(count !=0){
            [db executeUpdate:@"UPDATE Login SET data=? WHERE datakey=?",
             data,datakey];
        }else{
            [db executeUpdate:@"INSERT INTO Login(data,datakey) VALUES (?,?)",data,datakey];
        }
        [db close];
    }
}

+(NSUInteger)loadKey:(NSString *)datakey{
    NSUInteger count = 0;
    FMDatabase *db = [FMDatabase databaseWithPath:DataBasePath];
    if ([db open]) {
        count = [db intForQuery:@"select count(*) from Login where datakey=?",datakey];
        [db close];
    }
    return count;
}

+(NSString *)getdata:(NSString *)datakey
{
    NSString *str = nil;
    FMDatabase *db = [FMDatabase databaseWithPath:DataBasePath];
    if ([db open]) {
        str = [db stringForQuery:@"select data from Login where datakey=?",datakey];
        [db close];
    }
    
    return str;
}

+(void)deleteAll{
    FMDatabase *db = [FMDatabase databaseWithPath:DataBasePath];
    if ([db open]) {
        [db stringForQuery:@"delete from Login"];
        [db close];
    }
}
@end
