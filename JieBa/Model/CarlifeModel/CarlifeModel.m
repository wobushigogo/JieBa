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
    self.name = dict[@"names"];
    self.content = dict[@"content"];
    self.avatarUrl = [NSURL URLWithString:dict[@"avatar"]];
    self.lastTime = [StringTool timeChange2:dict[@"lasttime"]];
    self.imageArr = [NSMutableArray arrayWithArray:dict[@"images"]];
    self.location = dict[@"location"];
    self.eval_num = dict[@"eval_num"];
    self.point_num = dict[@"point_num"];
}
@end
