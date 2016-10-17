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
@property(nonatomic,strong)UIButton *userImgBtn;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UIButton *signBtn;
@property(nonatomic,strong)UIButton *activeBtn;
@end

@implementation MyCenterHead

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self bgImageView];
        [self userImgBtn];
        [self nameLabel];
        [self levelLabel];
        [self footerView];
        [self cutLine];
        [self signBtn];
        [self activeBtn];
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

- (UIButton *)userImgBtn {
    if (!_userImgBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(60), WidthXiShu(65), HeightXiShu(65))];
        btn.layer.cornerRadius = btn.halfWidth;
        btn.layer.borderWidth = 5;
        btn.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        
        //[btn setImage:[GetImagePath getImagePath:@"个人中心9"] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [self addSubview:btn];
        
        _userImgBtn = btn;
    }
    return _userImgBtn;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(90), HeightXiShu(72), WidthXiShu(150), HeightXiShu(20))];
        nameLabel.text = @"孙大蛇";
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

-(UILabel *)levelLabel{
    if(!_levelLabel){
        UILabel *levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(90), HeightXiShu(97), WidthXiShu(150), HeightXiShu(20))];
        levelLabel.textColor = [UIColor whiteColor];
        levelLabel.text = @"普通会员";
        levelLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:levelLabel];
        _levelLabel = levelLabel;
    }
    return _levelLabel;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, HeightXiShu(165), kScreenWidth, HeightXiShu(45))];
        footerView.backgroundColor = NavColor;
        footerView.alpha = .3;
        [self addSubview:footerView];
        _footerView = footerView;
    }
    return _footerView;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-1, HeightXiShu(165), WidthXiShu(2), HeightXiShu(45))];
        cutLine.backgroundColor = NavColor;
        [self addSubview:cutLine];
        _cutLine = cutLine;
    }
    return _cutLine;
}

-(UIButton *)signBtn{
    if(!_signBtn){
        UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        signBtn.frame = CGRectMake(0, HeightXiShu(165), kScreenWidth/2-2, HeightXiShu(45));
        [signBtn setTitle:@"签到" forState:UIControlStateNormal];
        [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        signBtn.titleLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:signBtn];
        _signBtn = signBtn;
    }
    return _signBtn;
}

-(UIButton *)activeBtn{
    if(!_activeBtn){
        UIButton *activeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        activeBtn.frame = CGRectMake(kScreenWidth/2+2, HeightXiShu(165), kScreenWidth/2-2, HeightXiShu(45));
        [activeBtn setTitle:@"邀请" forState:UIControlStateNormal];
        [activeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        activeBtn.titleLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:activeBtn];
        _activeBtn = activeBtn;
    }
    return _activeBtn;
}
@end
