//
//  InvitationModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "InvitationModel.h"

@implementation InvitationModel
-(void)setDict:(NSDictionary *)dict{
    self.aid = dict[@"id"];
    if([dict[@"images"] count] != 0){
        self.imageUrl = [NSURL URLWithString:dict[@"images"][0]];
    }else{
        self.imageUrl = [NSURL URLWithString:@""];
    }
    self.content = dict[@"content"];
}
@end
