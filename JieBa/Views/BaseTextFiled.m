//
//  BaseTextFiled.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseTextFiled.h"

@implementation BaseTextFiled

#pragma mark - placeholder

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholder:(NSString *)placeholder{
    [super setPlaceholder:placeholder];
    [self setValue:self.placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)setPlaceholderStr:(NSString *)placeholderStr{
    NSLog(@"==>%@",placeholderStr);
    [super setPlaceholder:placeholderStr];
    [self setValue:self.placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - margin

- (void)setLeftMargin:(CGFloat)leftMargin {
    _leftMargin = leftMargin;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftMargin, 0)];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setRightMargin:(CGFloat)rightMargin {
    _rightMargin = rightMargin;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightMargin, 0)];
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

#pragma mark - leftView,rightView

- (void)setLeftView:(UIView *)leftView {
    [super setLeftView:leftView];
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setRightView:(UIView *)rightView {
    [super setRightView:rightView];
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end
