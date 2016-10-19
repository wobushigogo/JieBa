//
//  StageAndNumberView.h
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StageAndNumberView : UIView
+(StageAndNumberView *)stageAndNumberViewWithStage:(NSString*)stage number:(NSInteger)number;
+(StageAndNumberView *)stageAndNumberViewWithStage:(NSString*)stage;
-(void)changeColor:(UIColor*)color;
-(void)changeNumber:(NSInteger)number;
-(CGFloat)stageLabelOriginX;
-(CGFloat)stageLabelWidth;
- (void)changeFont:(UIFont *)font;
@end
