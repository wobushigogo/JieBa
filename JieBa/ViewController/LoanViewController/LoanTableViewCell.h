//
//  LoanTableViewCell.h
//  JieBa
//
//  Created by 汪洋 on 16/10/18.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    stringType,
    numberType
} KeyBoardType;

@protocol LoanTableViewCellDelegate <NSObject>
-(void)textFieldDidEndEditing:(UITextField *)textField indexRow:(NSInteger)indexRow;
@end

@interface LoanTableViewCell : UITableViewCell
@property(nonatomic,assign)BOOL isShowLabel;
@property(nonatomic,assign)BOOL isShowCutLine;
@property(nonatomic,assign)BOOL isShowDetailLanel;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *contentStr;
@property(nonatomic,strong)NSString *placeholderStr;
@property(nonatomic,weak)id<LoanTableViewCellDelegate>delegate;
@property(nonatomic,assign)KeyBoardType keyBoardType;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end
