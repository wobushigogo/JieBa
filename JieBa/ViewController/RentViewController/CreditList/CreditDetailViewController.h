//
//  CreditDetailViewController.h
//  JieBa
//
//  Created by 汪洋 on 16/10/24.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseViewController.h"

@interface CreditDetailViewController : BaseViewController
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,strong)NSMutableDictionary *urlDic;
@property(nonatomic,copy)NSString *money;
@property(nonatomic)BOOL status;
@end
