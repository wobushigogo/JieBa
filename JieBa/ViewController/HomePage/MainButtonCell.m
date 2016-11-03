//
//  MainButtonCell.m
//  JieBa
//
//  Created by 汪洋 on 16/10/16.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MainButtonCell.h"

@implementation MainButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self introduceBtn];
        [self loanBtn];
        [self rentBtn];
        [self assessBtn];
        [self contactBtn];
        [self businessBtn];
    }
    return self;
}

-(UIButton *)introduceBtn{
    if(!_introduceBtn){
        UIButton *introduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        introduceBtn.frame = CGRectMake(0, 0, kScreenWidth/3, HeightXiShu(98));
        [introduceBtn setImage:[GetImagePath getImagePath:@"homePage_introduce"] forState:UIControlStateNormal];
        introduceBtn.tag = 0;
        [introduceBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:introduceBtn];
        _introduceBtn = introduceBtn;
    }
    return _introduceBtn;
}

-(UIButton *)loanBtn{
    if(!_loanBtn){
        UIButton *loanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loanBtn.frame = CGRectMake(kScreenWidth/3, 0, kScreenWidth/3, HeightXiShu(98));
        [loanBtn setImage:[GetImagePath getImagePath:@"homePage_loan"] forState:UIControlStateNormal];
        loanBtn.tag = 1;
        [loanBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loanBtn];
        _loanBtn = loanBtn;
    }
    return _loanBtn;
}

-(UIButton *)rentBtn{
    if(!_rentBtn){
        UIButton *rentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rentBtn.frame = CGRectMake(kScreenWidth/3*2, 0, kScreenWidth/3, HeightXiShu(98));
        [rentBtn setImage:[GetImagePath getImagePath:@"homePage_credit"] forState:UIControlStateNormal];
        rentBtn.tag = 2;
        [rentBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rentBtn];
        _rentBtn = rentBtn;
    }
    return _rentBtn;
}

-(UIButton *)assessBtn{
    if(!_assessBtn){
        UIButton *assessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        assessBtn.frame = CGRectMake(0, HeightXiShu(98), kScreenWidth/3, HeightXiShu(100));
        [assessBtn setImage:[GetImagePath getImagePath:@"homePage_assess"] forState:UIControlStateNormal];
        assessBtn.tag = 3;
        [assessBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:assessBtn];
        _assessBtn = assessBtn;
    }
    return _assessBtn;
}

-(UIButton *)contactBtn{
    if(!_contactBtn){
        UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        contactBtn.frame = CGRectMake(kScreenWidth/3, HeightXiShu(98), kScreenWidth/3, HeightXiShu(100));
        [contactBtn setImage:[GetImagePath getImagePath:@"homePage_contact"] forState:UIControlStateNormal];
        contactBtn.tag = 4;
        [contactBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:contactBtn];
        _contactBtn = contactBtn;
    }
    return _contactBtn;
}

-(UIButton *)businessBtn{
    if(!_businessBtn){
        UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        businessBtn.frame = CGRectMake(kScreenWidth/3*2, HeightXiShu(98), kScreenWidth/3, HeightXiShu(100));
        [businessBtn setImage:[GetImagePath getImagePath:@"homePage_add"] forState:UIControlStateNormal];
        businessBtn.tag = 5;
        [businessBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:businessBtn];
        _businessBtn = businessBtn;
    }
    return _businessBtn;
}

-(void)buttonAction:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(buttonClick:)]){
        [self.delegate buttonClick:button.tag];
    }
}
@end
