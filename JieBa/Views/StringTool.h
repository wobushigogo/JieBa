//
//  StringTool.h
//  tianjing
//
//  Created by 汪洋 on 15/11/16.
//  Copyright © 2015年 lanwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringTool : NSObject
+(NSString *)stringToRBM:(NSString *)text;
+(NSString *)timeInfoWithDateString:(NSString *)dateString;
+ (NSString *)timeInfoWithDateString2:(NSString *)dateString;
+(NSString *)stringWithNull:(NSString *)str;
+(NSString *)timeChange:(NSString *)dateString;
+(UIImage *)imageWithRoundedCornersSize:(float)cornerRadius usingImage:(UIImage *)original;
//验身份证
+ (BOOL)validateIDCardNumber:(NSString *)value;
//验手机号
+ (BOOL)validateMobile:(NSString *)mobileNum;
//验证邮箱
+ (BOOL)validateEmail:(NSString *)email;
//判断是否是表情
+ (BOOL)isContainsEmoji:(NSString *)string;
//判断是否含有除了数字和字母
+ (BOOL)isNumAndLetters:(NSString *)string;

+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (BOOL)verifyCardNumberWithSoldier:(NSString *)value;

+(BOOL)verifyText:(NSString *)text withRegex:(NSString *)regex;

//四舍五入保留2位
+(NSNumber *)roundFloat:(double)price;

+(BOOL)isLogin;
@end
