//
//  MessageListCell.h
//  JieBa
//
//  Created by 汪洋 on 16/10/28.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageListCell : UITableViewCell
@property(nonatomic,assign)BOOL isShowCutLine;
@property(nonatomic,strong)MessageModel *model;
@end
