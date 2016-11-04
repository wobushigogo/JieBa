//
//  CarlifeModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/27.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CarlifeModel.h"

@implementation CarlifeModel
-(void)setDict:(NSDictionary *)dict{
    self.commentId = dict[@"id"];
    self.name = dict[@"names"];
    self.content = dict[@"content"];
    self.avatarUrl = [NSURL URLWithString:dict[@"avatar"]];
    self.lastTime = dict[@"lasttime"];
    self.imageArr = [NSMutableArray arrayWithArray:dict[@"images"]];
    self.location = dict[@"location"];
    self.eval_num = dict[@"eval_num"];
    self.point_num = dict[@"point_num"];
}
@end

@implementation CommentModel

-(void)setDict:(NSDictionary *)dict{
    self.assedId = dict[@"assed_id"];
    self.name = dict[@"names"];
    self.content = dict[@"content"];
    self.avatarUrl = [NSURL URLWithString:dict[@"avatar"]];
    self.lastTime = dict[@"date_time"];
    if([dict[@"can_delete"] integerValue] == 0){
        self.can_delete = NO;
    }else{
        self.can_delete = YES;
    }
    self.to_names = dict[@"to_names"];
    if([self.to_names isEqualToString:@""]){
        self.isReply = NO;
    }else{
        self.isReply = YES;
    }
}

@end
