//
//  CarLifeCommentCell.h
//  JieBa
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarlifeModel.h"

@protocol CarLifeCommentCellDelegate <NSObject>
-(void)delComment:(NSString *)aId;
@end

@interface CarLifeCommentCell : UITableViewCell
@property(nonatomic,strong)CommentModel *model;
@property(nonatomic,weak)id<CarLifeCommentCellDelegate>delegate;
+(CGFloat)carculateCellHeightWithString:(NSString *)str;
@end
