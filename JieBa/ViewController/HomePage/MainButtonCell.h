//
//  MainButtonCell.h
//  JieBa
//
//  Created by 汪洋 on 16/10/16.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainButtonCellDelegate <NSObject>
-(void)buttonClick:(NSInteger)index;
@end

@interface MainButtonCell : UITableViewCell
@property(nonatomic,strong)UIButton *introduceBtn;
@property(nonatomic,strong)UIButton *loanBtn;
@property(nonatomic,strong)UIButton *rentBtn;
@property(nonatomic,strong)UIButton *assessBtn;
@property(nonatomic,strong)UIButton *contactBtn;
@property(nonatomic,strong)UIButton *businessBtn;
@property(nonatomic,weak)id<MainButtonCellDelegate>delegate;
@end
