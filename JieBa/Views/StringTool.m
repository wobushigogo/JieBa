//
//  StringTool.m
//  tianjing
//
//  Created by 汪洋 on 15/11/16.
//  Copyright © 2015年 lanwan. All rights reserved.
//

#import "StringTool.h"
#import "RegexKitLite.h"

@implementation StringTool
+(NSString *)stringToRBM:(NSString *)text{
    NSNumberFormatter*numberFormatter= [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    numberFormatter.currencyCode = @"￥";
    id result;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    result=[f numberFromString:text];
    if(!(result))
    {
        result=text;
    }
    NSString *str =[numberFormatter stringFromNumber:result];
    return str;
}

+ (NSString *)timeInfoWithDateString:(NSString *)dateString {
    // 把日期字符串格式化为日期对象
    //NSDate *date = [NSDate dateFromString:dateString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    NSArray *dateArr = [arr[0] componentsSeparatedByString:@"-"];
    NSString *string = [NSString stringWithFormat:@"%@-%@",dateArr[1],dateArr[2]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    NSDateComponents *curDateComponent = [calendar components:unitFlags fromDate:curDate];
    
    int month = (int)([curDateComponent month] - [dateComponent month]);
    int year = (int)([curDateComponent year] - [dateComponent year]);
    int day = (int)([curDateComponent day] - [dateComponent day]);
    
    NSTimeInterval retTime = 1.0;
    // 小于一小时
    if (time < 3600) {
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    }
    // 小于一天，也就是今天
    else if (time < 3600 * 24) {
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    }
    // 昨天
    else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDateComponent month] == 1 && [dateComponent month] == 12)) {
        int retDay = 0;
        // 同年
        if (year == 0) {
            // 同月
            if (month == 0) {
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 这里按月最大值来计算
            // 获取发布日期中，该月总共有多少天
            NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
            int totalDays = (int)totaldaysInMonth.length;
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDateComponent day] + (totalDays - (int)[dateComponent day]);
            
            if (retDay >= totalDays) {
                //return [NSString stringWithFormat:@"%d个月前", (abs)(MAX(retDay / 31, 1))];
                return [NSString stringWithFormat:@"%@",string];
            }
        }
        
        if(retDay>7){
            return [NSString stringWithFormat:@"%@",string];
        }else{
            return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
        }
    } else  {
//        if (abs(year) <= 1) {
//            if (year == 0) { // 同年
//                return [NSString stringWithFormat:@"%d个月前", abs(month)];
//            }
//            
//            // 相差一年
//            int month = (int)[curDateComponent month];
//            int preMonth = (int)[dateComponent month];
//            
//            // 隔年，但同月，就作为满一年来计算
//            if (month == 12 && preMonth == 12) {
//                return @"1年前";
//            }  
//            
//            // 也不看，但非同月  
//            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];  
//        }  
//        
//        return [NSString stringWithFormat:@"%d年前", abs(year)];
        return [NSString stringWithFormat:@"%@",string];
    }
    
    return @"1小时前";  
}

+ (NSString *)timeInfoWithDateString2:(NSString *)dateString {
    // 把日期字符串格式化为日期对象
    //NSDate *date = [NSDate dateFromString:dateString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    NSArray *dateArr = [arr[0] componentsSeparatedByString:@"-"];
    NSString *string = [NSString stringWithFormat:@"%@-%@",dateArr[1],dateArr[2]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    NSDateComponents *curDateComponent = [calendar components:unitFlags fromDate:curDate];
    
    int month = (int)([curDateComponent month] - [dateComponent month]);
    int year = (int)([curDateComponent year] - [dateComponent year]);
    int day = (int)([curDateComponent day] - [dateComponent day]);
    
    NSTimeInterval retTime = 1.0;
    // 小于一小时
    if (time < 3600) {
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        //return [NSString stringWithFormat:@"%.0f分钟前", retTime];
        return [NSString stringWithFormat:@"%@",[StringTool timeChange:arr[0]]];
    }
    // 小于一天，也就是今天
    else if (time < 3600 * 24) {
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        //return [NSString stringWithFormat:@"%.0f小时前", retTime];
        return [NSString stringWithFormat:@"%@",[StringTool timeChange:arr[0]]];
    }
    // 昨天
    else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDateComponent month] == 1 && [dateComponent month] == 12)) {
        int retDay = 0;
        // 同年
        if (year == 0) {
            // 同月
            if (month == 0) {
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 这里按月最大值来计算
            // 获取发布日期中，该月总共有多少天
            NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
            int totalDays = (int)totaldaysInMonth.length;
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDateComponent day] + (totalDays - (int)[dateComponent day]);
            
            if (retDay >= totalDays) {
                return [NSString stringWithFormat:@"%d个月前", (abs)(MAX(retDay / 31, 1))];
                //return [NSString stringWithFormat:@"%@",string];
            }
        }
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 相差一年
            int month = (int)[curDateComponent month];
            int preMonth = (int)[dateComponent month];
            
            // 隔年，但同月，就作为满一年来计算
            if (month == 12 && preMonth == 12) {
                return @"1年前";
            }
            
            // 也不看，但非同月
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    //return @"1小时前";
    return [NSString stringWithFormat:@"%@",[StringTool timeChange:arr[0]]];
}

+(NSString *)stringWithNull:(NSString *)str{
    NSString *string = nil;
    if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@""]){
        string = @"";
    }else{
        string = str;
    }
    return string;
}

+(NSString *)timeChange:(NSString *)dateString{
    NSString *string = nil;
    if([[NSString stringWithFormat:@"%@",dateString] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",dateString] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",dateString] isEqualToString:@""]){
        string = @"";
    }else{
        NSArray *arr = [dateString componentsSeparatedByString:@" "];
        NSArray *dateArr = [arr[0] componentsSeparatedByString:@"-"];
        string = [NSString stringWithFormat:@"%@-%@-%@",dateArr[0],dateArr[1],dateArr[2]];
    }
    return string;
}

+(NSString *)timeChange2:(NSString *)dateString{
    NSString *string = nil;
    if([[NSString stringWithFormat:@"%@",dateString] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",dateString] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",dateString] isEqualToString:@""]){
        string = @"";
    }else{
        NSArray *arr = [dateString componentsSeparatedByString:@" "];
        NSArray *dateArr = [arr[0] componentsSeparatedByString:@"-"];
        string = [NSString stringWithFormat:@"%@年%@月%@日",dateArr[0],dateArr[1],dateArr[2]];
    }
    return string;
}

+ (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius usingImage:(UIImage *)original
{
    CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(original.size, NO, 1.0);
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:cornerRadius] addClip];
    // Draw your image
    [original drawInRect:frame];
    // Retrieve and return the new image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}

+ (BOOL)validateMobile:(NSString *)mobileNum
{
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    //18301727385
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}

+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//判断是否是表情
+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}


+ (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}




//验证军官证或警官证
//必须是下面两种格式中的一种
//格式一：4到20位数字
//格式二：大于或等于10位并且小于等于20位（中文按两位），并满足以下规则
//1）必须有“字第”两字
//2）“字第”前面有至少一个字符
//3）“字第”后是4位以上数字
+ (BOOL)verifyCardNumberWithSoldier:(NSString *)value{
    NSString *s1 = @"^//d*$";
    NSString *s2 = @"^.{1,}字第//d{4,}$";
    //NSString *s3 = @"^([A-Za-z0-9//u4e00-//u9fa5])*$";
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([StringTool verifyText:value withRegex:s1]) {
        NSString *s11 = @"^//d{4,20}$";
        return [value isMatchedByRegex:s11];
    } else if ([self lengthUsingChineseCharacterCountByTwo:value] >= 10
               && [self lengthUsingChineseCharacterCountByTwo:value] <= 20) {
        return [value isMatchedByRegex:s2];
    }
    return NO;
}

+ (NSUInteger)lengthUsingChineseCharacterCountByTwo:(NSString *)string{
    NSUInteger count = 0;
    for (NSUInteger i = 0; i< string.length; ++i) {
        if ([string characterAtIndex:i] < 256) {
            count++;
        } else {
            count += 2;
        }
    }
    return count;
}

//正则验证
+(BOOL)verifyText:(NSString *)text withRegex:(NSString *)regex{
         return  [[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isMatchedByRegex:regex];
     }


+ (BOOL)isNumAndLetters:(NSString *)string{
    NSString * regex = @"^[A-Za-z0-9]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}


+(NSNumber *)roundFloat:(double)price{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber* decimal = [[NSDecimalNumber alloc] initWithDouble:price];
    NSNumber* ratio = [decimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return ratio;
}

+(BOOL)isLogin{
    if([[StringTool stringWithNull:[LoginSqlite getdata:@"token"]] isEqualToString:@""]){
        return NO;
    }else{
        return YES;
    }
}
@end
