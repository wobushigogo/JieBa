//
//  InputTextFiledView.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "InputTextFiledView.h"

@interface InputTextFiledView()
@property(nonatomic,strong)UIImageView *bottomSepeLine;
@end

@implementation InputTextFiledView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textField = [[BaseTextFiled alloc] initWithFrame:CGRectMake(0, self.height - HeightXiShu(30), 0, HeightXiShu(30))];
        self.textField.font = HEITI(HeightXiShu(16));
        [self addSubview:self.textField];
        [self bottomSepeLine];
    }
    return self;
}

-(UIImageView *)bottomSepeLine{
    if(!_bottomSepeLine){
        UIImageView *bottomSepeLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width, .5)];
        bottomSepeLine.backgroundColor = RGBACOLOR(255, 255, 255, .7);
        [self addSubview:bottomSepeLine];
        _bottomSepeLine = bottomSepeLine;
    }
    return _bottomSepeLine;
}

-(void)setTextField:(BaseTextFiled *)textField{
    _textField = textField;
}

-(void)setLeftView:(UIView *)leftView{
    [self.leftView removeFromSuperview];
    _leftView = leftView;
    [self addSubview:self.leftView];
}

-(void)setRightView:(UIView *)rightView{
    [self.rightView removeFromSuperview];
    _rightView = rightView;
    [self addSubview:self.rightView];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.textField.placeholder = self.placeholder;
}

-(void)setTextFiledMargin:(NSInteger)textFiledMargin{
    _textFiledMargin = textFiledMargin;
    self.textField.minX = textFiledMargin;
}

-(void)setTextWidth:(NSInteger)textWidth{
    _textWidth = textWidth;
    self.textField.width = textWidth;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.textField.placeholderColor = self.placeholderColor;
    self.textField.textColor = self.placeholderColor;
    self.textField.tintColor = self.placeholderColor;
}
@end
