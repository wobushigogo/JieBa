//
//  NSString+StringKit.m
//  tianjing
//
//  Created by 孙元侃 on 16/3/23.
//  Copyright © 2016年 lanwan. All rights reserved.
//

#import "NSString+StringKit.h"

@implementation NSString (StringKit)

- (NSUInteger)chineseStrCount {
    NSRegularExpression* expression = [[NSRegularExpression alloc] initWithPattern:@"[\u4E00-\u9FA5]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger number = [expression numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return number;
}

- (BOOL)isAllChineses {
    return self.length == [self chineseStrCount];
}


- (NSUInteger)numberCount {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return numberOfMatches;
}

- (BOOL)isAllNumbers {
    return self.length == [self numberCount];
}

- (NSUInteger)alpbetCount {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return numberOfMatches;
}

- (BOOL)isAllAlphabets {
    return self.length == [self alpbetCount];
}

- (NSString *)removePrefixAndSuffixSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isInStr:(NSString *)str {
    //普通空格
    NSArray <NSString *>*strArr = [self componentsSeparatedByString:@" "];
    
//    NSLog(@"strArr = %@",strArr);
    
    if (strArr.count == 0) return YES;
    
    if (strArr.count == 1) {
        __block BOOL isIn = YES;
        [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            if ([substring isAllChineses]) {
                if (![str containsString:substring]) {
                    isIn = NO;
                    *stop = YES;
                }
            }
        }];
        return isIn;
    }else {
        __block BOOL returnValue = YES;
        [strArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isInStr:str]) {
                returnValue = NO;
                *stop = YES;
            };
        }];
        return returnValue;
    }
}

- (NSString *)transformFromChineseToAlphabet {
        NSMutableString *pinyin = [self mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
        //    NSLog(@"pinyin = %@<>", pinyin);
        return [[pinyin lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
}
@end
