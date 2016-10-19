//
//  StageChooseView.h
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StageChooseViewDelegate <NSObject>
@optional
- (void)stageBtnClickedWithNumber:(NSInteger)stageNumber;
- (BOOL)shouldChangeStageToNumber:(NSInteger)stageNumber;
/**
 *  右箭头按钮被点击
 */
- (void)stageChooseViewAssistBtnClicked;
@end

@interface StageChooseView : UIView
+(StageChooseView *)stageChooseViewWithStages:(NSArray*)stages numbers:(NSArray*)numbers delegate:(id<StageChooseViewDelegate>)delegate underLineIsWhole:(BOOL)underLineIsWhole normalColor:(UIColor*)normalColor highlightColor:(UIColor*)highlightColor height:(CGFloat)height;
- (void)hideVerticalLine;
@property(nonatomic,strong)NSMutableArray* labels;

@end
