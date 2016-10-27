//
//  LoanDetailViewController.h
//  JieBa
//
//  Created by 汪洋 on 16/10/24.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseTableViewController.h"

typedef enum {
    loanType,
    rentType
}LoanOrRent;

@interface LoanDetailViewController : BaseTableViewController
@property(nonatomic,assign)LoanOrRent loanOrRent;
@property(nonatomic)NSInteger type;
@property(nonatomic,copy)NSMutableDictionary *dict;
@end
