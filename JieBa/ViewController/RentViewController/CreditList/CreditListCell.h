//
//  CreditListCell.h
//  JieBa
//
//  Created by 汪洋 on 16/10/21.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditListModel.h"

@interface CreditListCell : UITableViewCell
@property(nonatomic,strong)CreditListModel *model;
@property(nonatomic)BOOL isShowArrow;
@end
