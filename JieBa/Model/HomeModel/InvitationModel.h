//
//  InvitationModel.h
//  JieBa
//
//  Created by 汪洋 on 16/10/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvitationModel : NSObject
@property(nonatomic,copy)NSString *aid;
@property(nonatomic,strong)NSURL *imageUrl;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,strong)NSDictionary *dict;
@end
