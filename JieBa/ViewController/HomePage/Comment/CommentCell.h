//
//  CommentCell.h
//  JieBa
//
//  Created by 汪洋 on 16/10/27.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarlifeModel.h"

@interface CommentCell : UITableViewCell
@property(nonatomic,strong)CarlifeModel *model;
+(CGFloat)carculateCellHeightWithString:(NSString *)str;
@end
