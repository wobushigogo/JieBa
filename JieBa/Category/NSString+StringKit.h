//
//  NSString+StringKit.h
//  tianjing
//
//  Created by 孙元侃 on 16/3/23.
//  Copyright © 2016年 lanwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringKit)

//中文
- (NSUInteger)chineseStrCount;
- (BOOL)isAllChineses;

//数字
- (NSUInteger)numberCount;
- (BOOL)isAllNumbers;

//字母
- (NSUInteger)alpbetCount;
- (BOOL)isAllAlphabets;

//去头尾空格
- (NSString *)removePrefixAndSuffixSpace;

//判断是否包含这些中文
- (BOOL)isInStr:(NSString *)str;

- (NSString *)transformFromChineseToAlphabet;

@end
