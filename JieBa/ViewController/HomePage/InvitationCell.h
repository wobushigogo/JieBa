//
//  InvitationCell.h
//  JieBa
//
//  Created by 汪洋 on 16/10/16.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InvitationCell;

@protocol InvitationCellDelegate <NSObject>

- (void)detailedListInvitationCell:(InvitationCell *)cell imageClicked:(NSInteger)index;
@end

@interface InvitationCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray *modelsArr;
@property(nonatomic,weak)id<InvitationCellDelegate>delegate;
@end
