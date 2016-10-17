//
//  LocationView.m
//  JieBa
//
//  Created by 汪洋 on 16/10/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "LocationView.h"

@interface LocationView()
@property(nonatomic,strong)UIImageView *bgView;
@property(nonatomic,strong)UIImageView *smallImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation LocationView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self bgView];
        [self smallImageView];
        [self titleLabel];
    }
    return self;
}

#pragma  mark -页面元素

-(UIImageView *)bgView{
    if(!_bgView){
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        bgView.image = [GetImagePath getImagePath:@"homePage_loactionbg"];
        [self addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}

-(UIImageView *)smallImageView{
    if(!_smallImageView){
        UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(22), HeightXiShu(4), WidthXiShu(12), HeightXiShu(15))];
        smallImageView.image = [GetImagePath getImagePath:@"homePage_location"];
        [self addSubview:smallImageView];
        _smallImageView = smallImageView;
    }
    return _smallImageView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(40), HeightXiShu(4), self.width-WidthXiShu(80), HeightXiShu(15))];
        titleLabel.text = @"定位中...";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
@end
