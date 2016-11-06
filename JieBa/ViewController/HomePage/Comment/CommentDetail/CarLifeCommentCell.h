//
//  CarLifeCommentCell.h
//  JieBa
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarlifeModel.h"

@interface CarLifeCommentCell : UITableViewCell
@property(nonatomic,strong)CommentModel *model;
+(CGFloat)carculateCellHeightWithString:(NSString *)str;
@end
