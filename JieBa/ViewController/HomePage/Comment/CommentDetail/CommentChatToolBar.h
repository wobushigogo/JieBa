//
//  CommentChatToolBar.h
//  tianjing
//
//  Created by 汪洋 on 15/10/23.
//  Copyright © 2015年 lanwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentChatToolBarDelegate <NSObject>
@optional
-(void)chatToolBarSizeChangeWithHeight:(CGFloat)height;
-(void)chatToolSendBtnClickedWithContent:(NSString *)string;
@end

@interface CommentChatToolBar : UIView
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)NSString *placeStr;
@property(nonatomic)BOOL bKeyBoardHide;
@property(nonatomic,weak)id<CommentChatToolBarDelegate>delegate;
@end
