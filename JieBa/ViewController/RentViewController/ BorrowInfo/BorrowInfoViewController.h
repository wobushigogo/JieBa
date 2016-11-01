//
//  BorrowInfoViewController.h
//  JieBa
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CreditModel.h"

@interface BorrowInfoViewController : BaseTableViewController
@property(nonatomic,strong)CreditModel *model;
@property(nonatomic,copy)NSMutableDictionary *urlDic;
@end
