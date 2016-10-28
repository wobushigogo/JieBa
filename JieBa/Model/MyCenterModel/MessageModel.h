//
//  MessageModel.h
//  JieBa
//
//  Created by 汪洋 on 16/10/28.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property(nonatomic,copy)NSString *messageId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *summary;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *timeadd;
@property(nonatomic)BOOL isRead;
@property(nonatomic,strong)NSDictionary *dict;
@end
