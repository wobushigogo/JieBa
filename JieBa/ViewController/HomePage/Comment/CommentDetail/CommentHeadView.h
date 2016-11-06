//
//  CommentHeadView.h
//  JieBa
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarlifeModel.h"

@protocol CommentHeadViewDelegate <NSObject>
-(void)commentClick:(NSString *)aId;
-(void)goodClick:(CarlifeModel *)model;
-(void)delClcik:(NSString *)aId;
@end

@interface CommentHeadView : UIView
@property(nonatomic,strong)CarlifeModel *model;
@property(nonatomic)BOOL is_point;
@property(nonatomic,strong)NSString *point_num;
@property(nonatomic,weak)id<CommentHeadViewDelegate>delegate;
@property(nonatomic,strong)void(^heightBlock)(CGFloat height);
@end
