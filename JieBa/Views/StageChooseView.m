//
//  StageChooseView.m
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "StageChooseView.h"
#import "StageAndNumberView.h"

@interface StageChooseView()
@property(nonatomic,weak)id<StageChooseViewDelegate>delegate;
@property(nonatomic,strong)NSArray* stages;
@property(nonatomic,strong)NSArray* numbers;
@property(nonatomic,strong)NSMutableArray *verticalLines;
@property(nonatomic,strong)UIView* seperatorLine;
@property(nonatomic,strong)UIView* underLineView;
@property(nonatomic,assign)NSInteger nowStageNumber;
@property(nonatomic)BOOL underLineIsWhole;
@property(nonatomic,strong)UIColor* normalColor;
@property(nonatomic,strong)UIColor* highlightColor;
@end

@implementation StageChooseView

+(StageChooseView *)stageChooseViewWithStages:(NSArray*)stages numbers:(NSArray*)numbers delegate:(id<StageChooseViewDelegate>)delegate underLineIsWhole:(BOOL)underLineIsWhole normalColor:(UIColor*)normalColor highlightColor:(UIColor*)highlightColor height:(CGFloat)height{
    StageChooseView* stageChooseView = [[StageChooseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    stageChooseView.delegate = delegate;
    stageChooseView.stages = stages;
    stageChooseView.numbers = numbers;
    stageChooseView.underLineIsWhole = underLineIsWhole;
    stageChooseView.normalColor = normalColor;
    stageChooseView.highlightColor = highlightColor;
    [stageChooseView setUp];
    return stageChooseView;
}

-(void)setUp{
    self.backgroundColor = RGBCOLOR(255, 255, 255);
    NSInteger count=self.stages.count;
    CGFloat const widthWithoutAssistBtn = kScreenWidth;
    
    for (int i=0; i<count; i++) {
        StageAndNumberView* singleStageLabel=[self getSingleStageLabelWithText:self.stages[i] sequence:i];
        
        CGFloat width=widthWithoutAssistBtn/count;
        CGFloat x=width*(0.5+i);
        CGFloat y=self.height*0.5;
        singleStageLabel.center=CGPointMake(x, y);
        
        [self addSubview:singleStageLabel];
        [self.labels addObject:singleStageLabel];
        
        if (i != count - 1) {
            UIView *sepa = [[UIView alloc] initWithFrame:CGRectMake(0, 0, .5, self.height - HeightXiShu(8))];
            sepa.backgroundColor = RGBCOLOR(204, 204, 204);
            sepa.center = CGPointMake(width * (i + 1), y);
            [self addSubview:sepa];
            
            [self.verticalLines addObject:sepa];
        }
    }
    [self addSubview:self.seperatorLine];
    [self addSubview:self.underLineView];
    [self stageLabelClickedWithSequence:0 needResponseDelegate:NO];
}

-(StageAndNumberView *)getSingleStageLabelWithText:(NSString*)text sequence:(NSInteger)sequence{
    StageAndNumberView* stageLabel=self.numbers.count?[StageAndNumberView stageAndNumberViewWithStage:text number:[self.numbers[sequence] integerValue]]:[StageAndNumberView stageAndNumberViewWithStage:text];
    stageLabel.tag=sequence;
    return stageLabel;
}

-(void)stageLabelClickedWithSequence:(NSInteger)sequence needResponseDelegate:(BOOL)needResponseDelegate{
    BOOL canChange = YES;
    if ([self.delegate respondsToSelector:@selector(shouldChangeStageToNumber:)]) {
        canChange = [self.delegate shouldChangeStageToNumber:sequence];
    }
    if (!canChange) return;
    
    self.nowStageNumber=sequence;
    
    [self.labels enumerateObjectsUsingBlock:^(StageAndNumberView *obj, NSUInteger idx, BOOL *stop) {
        BOOL isHighlight = idx == sequence;
        [obj changeColor:isHighlight ? self.highlightColor : self.normalColor];
        [obj changeFont:HEITI(HeightXiShu(14))];
    }];
    StageAndNumberView* stageLabel=self.labels[sequence];
    
    CGRect frame=self.underLineView.frame;
    if (self.underLineIsWhole) {
        frame.size.width=kScreenWidth/self.stages.count;
        frame.origin.x=sequence*kScreenWidth/self.stages.count;
    }else{
        frame.origin.x=CGRectGetMinX(stageLabel.frame)+[stageLabel stageLabelOriginX];
        frame.size.width=[stageLabel stageLabelWidth];
    }
    
    [UIView animateWithDuration:CGRectGetWidth(self.underLineView.frame)?0.3:0 animations:^{
        self.underLineView.frame=frame;
    }];
    
    if (needResponseDelegate&&[self.delegate respondsToSelector:@selector(stageBtnClickedWithNumber:)]) {
        [self.delegate stageBtnClickedWithNumber:sequence];
    }
}

- (void)hideVerticalLine {
    [self.verticalLines enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = YES;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject] ;
    CGPoint point = [touch locationInView:self];
    CGFloat const widthWithoutAssistBtn = kScreenWidth;
    [self stageLabelClickedWithSequence:point.x / (widthWithoutAssistBtn/self.stages.count)];
}

-(void)stageLabelClickedWithSequence:(NSInteger)sequence{
    [self stageLabelClickedWithSequence:sequence needResponseDelegate:YES];
}

-(NSMutableArray *)labels{
    if (!_labels) {
        _labels=[NSMutableArray array];
    }
    return _labels;
}

- (NSMutableArray *)verticalLines {
    if (!_verticalLines) {
        _verticalLines = [NSMutableArray array];
    }
    return _verticalLines;
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, .5)];
        _seperatorLine.backgroundColor=AllLightGrayColor;;
        _seperatorLine.backgroundColor = RGBCOLOR(230, 230, 230);
        [_seperatorLine setMaxY:self.height];
    }
    return _seperatorLine;
}

-(UIView *)underLineView{
    if (!_underLineView) {
        CGFloat height = 1.5;
        CGFloat y=CGRectGetHeight(self.frame)-height;
        _underLineView=[[UIView alloc]initWithFrame:CGRectMake(0, y, 0, height)];
        _underLineView.backgroundColor = self.highlightColor;
    }
    return _underLineView;
}

- (UIColor *)normalColor{
    if (!_normalColor) {
        _normalColor = [UIColor blackColor];
    }
    return _normalColor;
}

- (UIColor *)highlightColor{
    if (!_highlightColor) {
        _highlightColor = ButtonColor;
    }
    return _highlightColor;
}
@end

