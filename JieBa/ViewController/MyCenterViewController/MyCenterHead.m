//
//  MyCenterHead.m
//  JieBa
//
//  Created by 汪洋 on 16/10/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MyCenterHead.h"

@interface MyCenterHead()
@property(nonatomic,strong)UIImageView *bgImageView;
@end

@implementation MyCenterHead

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self bgImageView];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)bgImageView{
    if(!_bgImageView){
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        bgImageView.image = [GetImagePath getImagePath:@"myCenter_banner"];
        [self addSubview:bgImageView];
        _bgImageView = bgImageView;
    }
    return _bgImageView;
}
@end
