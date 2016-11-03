//
//  CreditRepayViewController.h
//  JieBa
//
//  Created by 汪洋 on 2016/11/3.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseTableViewController.h"

typedef enum {
    repay,
    overdue
}RepayOrOverdue;

@interface CreditRepayViewController : BaseTableViewController
@property(nonatomic,assign)RepayOrOverdue repayOrOverdue;
@end
