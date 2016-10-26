//
//  RentApplyCell.h
//  JieBa
//
//  Created by 汪洋 on 16/10/26.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    stringType,
    numberType
} KeyBoardType;

typedef enum {
    signType,
    doubleType
} DetailLabelType;

@protocol RentApplyCellDelegate <NSObject>
-(void)textFieldDidEndEditing:(UITextField *)textField indexRow:(NSInteger)indexRow;
@end

@interface RentApplyCell : UITableViewCell
@property(nonatomic,assign)BOOL isShowLabel;
@property(nonatomic,assign)BOOL isShowCutLine;
@property(nonatomic,assign)BOOL isShowDetailLanel;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *contentStr;
@property(nonatomic,strong)NSString *placeholderStr;
@property(nonatomic,weak)id<RentApplyCellDelegate>delegate;
@property(nonatomic,assign)KeyBoardType keyBoardType;
@property(nonatomic,assign)DetailLabelType detailLabelType;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end
