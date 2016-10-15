//
//  BaseTextFiled.h
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextFiled : UITextField
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) NSString *placeholderStr;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;
@end
