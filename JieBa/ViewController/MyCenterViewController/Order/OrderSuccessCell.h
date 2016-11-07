//
//  OrderSuccessCell.h
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "AssedModel.h"

@protocol OrderSuccessCellDelegate <NSObject>
-(void)commentClick:(NSInteger)index;
@end

@interface OrderSuccessCell : UITableViewCell
@property(nonatomic,strong)OrderModel *model;
@property(nonatomic,strong)AssedModel *assedModel;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak)id<OrderSuccessCellDelegate>delegate;
@end
