//
//  InputTextFiledView.h
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextFiled.h"

@interface InputTextFiledView : UIView
@property(nonatomic,strong,readonly)BaseTextFiled *textField;
@property(nonatomic,strong)UIColor *placeholderColor;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,strong)NSString *placeholder;
@property(nonatomic,assign)NSInteger textFiledMargin;
@property(nonatomic,assign)NSInteger textWidth;
@end
