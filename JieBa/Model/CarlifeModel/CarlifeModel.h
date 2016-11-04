//
//  CarlifeModel.h
//  JieBa
//
//  Created by 汪洋 on 16/10/27.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarlifeModel : NSObject
@property(nonatomic,copy)NSString *commentId;
@property(nonatomic,strong)NSURL *avatarUrl;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *lastTime;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *eval_num;
@property(nonatomic,copy)NSString *point_num;
@property(nonatomic)BOOL is_point;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,strong)NSDictionary *dict;
@end


@interface CommentModel : NSObject
@property(nonatomic,copy)NSString *assedId;
@property(nonatomic,strong)NSURL *avatarUrl;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *lastTime;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *to_names;
@property(nonatomic)BOOL can_delete;
@property(nonatomic)BOOL isReply;
@property(nonatomic,strong)NSDictionary *dict;
@end
