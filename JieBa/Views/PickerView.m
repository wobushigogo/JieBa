//
//  PickerView.m
//  JieBa
//
//  Created by 汪洋 on 16/10/18.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "PickerView.h"

@interface PickerView()
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIButton *bgBtn;
@property(nonatomic,copy)NSMutableArray *dataArr;
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,assign)NSInteger selectIndex;
@end

@implementation PickerView

-(id)initWithTitle:(CGRect)frame title:(NSString *)title dataArr:(NSMutableArray *)dataArr{
    if(self = [super initWithFrame:frame]){
        self.titleStr = title;
        self.dataArr = dataArr;
        [self bgBtn];
        [self contentView];
        __block typeof(self)wSelf = self;
        [UIView animateWithDuration:.5 animations:^{
            wSelf.contentView.frame = CGRectMake(0, kScreenHeight-HeightXiShu(240), kScreenWidth, HeightXiShu(200));
        }];
    }
    return self;
}

#pragma mark - 页面元素
-(UIButton *)bgBtn{
    if(!_bgBtn){
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bgBtn.frame = CGRectMake(0, 0, self.width, self.height);
        [bgBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgBtn];
    }
    return _bgBtn;
}

-(UIView *)contentView{
    if(!_contentView){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0,self.height, kScreenWidth, HeightXiShu(40)+HeightXiShu(160))];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(40))];
        topView.backgroundColor = NavColor;
        [contentView addSubview:topView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(40))];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = HEITI(HeightXiShu(14));
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = self.titleStr;
        [topView addSubview:titleLabel];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(WidthXiShu(15), 0, WidthXiShu(40), HeightXiShu(40));
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = HEITI(HeightXiShu(14));
        [cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:cancelBtn];
        
        UIButton *finshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        finshBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(15)-WidthXiShu(40), 0, WidthXiShu(40), HeightXiShu(40));
        [finshBtn setTitle:@"确定" forState:UIControlStateNormal];
        finshBtn.titleLabel.font = HEITI(HeightXiShu(14));
        [finshBtn addTarget:self action:@selector(finshAction) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:finshBtn];
        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, topView.maxY, kScreenWidth, HeightXiShu(160))];
        pickerView.backgroundColor = AllBackLightGratColor;
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [contentView addSubview:pickerView];
        
        [self addSubview:contentView];
        _contentView = contentView;
        _pickerView = pickerView;
    }
    return _contentView;
}

#pragma mark - pickerView delegate datasrouce
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.dataArr.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dataArr objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectIndex = row;
}

#pragma - mark 事件
-(void)closeAction{
    __block typeof(self)wSelf = self;
    [UIView animateWithDuration:.5 animations:^{
        wSelf.contentView.frame = CGRectMake(0, self.height, kScreenWidth, HeightXiShu(200));
    } completion:^(BOOL finished) {
        if(wSelf.cancelBlock){
            wSelf.cancelBlock();
        }
    }];
}

-(void)finshAction{
    __block typeof(self)wSelf = self;
    [UIView animateWithDuration:.5 animations:^{
        wSelf.contentView.frame = CGRectMake(0, self.height, kScreenWidth, HeightXiShu(200));
    } completion:^(BOOL finished) {
        if(wSelf.finshBlock){
            wSelf.finshBlock(self.selectIndex);
        }
    }];
}
@end
