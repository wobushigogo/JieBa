//
//  NavView.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "NavView.h"

@interface NavView ()
+ (CGFloat)defualtHeight;
@end

@implementation NavView
+ (CGFloat)defualtHeight {
    return 44;
}

+(NavView *)initNavView{
    NavView *view = [[NavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [self defualtHeight])];
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self leftBtn];
    }
    return self;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WidthXiShu(65), [self.class defualtHeight])];
        [leftBtn setImage:[GetImagePath getImagePath:@"login_back"] forState:UIControlStateNormal];
        [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(5,0,0,0);//设置
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        leftBtn.titleLabel.font = HEITI(HeightXiShu(16));
        [self addSubview:leftBtn];
        
        _leftBtn = leftBtn;
    }
    return _leftBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [self.class defualtHeight])];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = HEITI(HeightXiShu(18));
        [self insertSubview:label atIndex:0];
        
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WidthXiShu(60), [self.class defualtHeight])];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = HEITI(HeightXiShu(15));
        [rightBtn setMaxX:self.width - 15 midY:self.halfHeight];
        [self addSubview:rightBtn];
        
        _rightBtn = rightBtn;
    }
    return _rightBtn;
}
@end
