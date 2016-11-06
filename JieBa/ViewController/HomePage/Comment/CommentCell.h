//
//  CommentCell.h
//  JieBa
//
//  Created by 汪洋 on 16/10/27.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarlifeModel.h"
@class CommentCell;

@protocol CommentCellDelegate <NSObject>
-(void)goodClick:(CarlifeModel *)model cell:(CommentCell *)cell;
@end

@interface CommentCell : UITableViewCell
@property(nonatomic,strong)CarlifeModel *model;
@property(nonatomic)BOOL is_point;
@property(nonatomic,strong)NSString *point_num;
@property(nonatomic,weak)id<CommentCellDelegate>delegate;
+(CGFloat)carculateCellHeightWithString:(NSString *)str;
@end
