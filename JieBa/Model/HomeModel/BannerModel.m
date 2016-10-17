//
//  BannerModel.m
//  JieBa
//
//  Created by 汪洋 on 16/10/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel
-(void)setDict:(NSDictionary *)dict{
    self.bannerUrl = [NSURL URLWithString:dict[@"banner"]];
    self.htmlUrl = [NSURL URLWithString:dict[@"banner_url"]];
}
@end
