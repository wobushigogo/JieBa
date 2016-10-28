//
//  MessageModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/28.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
-(void)setDict:(NSDictionary *)dict{
    self.messageId = dict[@"id"];
    self.title = dict[@"title"];
    self.summary = dict[@"summary"];
    self.content = dict[@"content"];
    self.timeadd = dict[@"timeadd"];
    self.time = [StringTool timeInfoWithDateString:[NSString stringWithFormat:@"%@ 00:00:00",dict[@"timeadd"]]];
    if(![dict[@"is_read"] isEqualToString:@""]){
        self.isRead = YES;
    }else{
        self.isRead = NO;
    }
}
@end
