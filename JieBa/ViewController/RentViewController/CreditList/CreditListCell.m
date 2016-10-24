//
//  CreditListCell.m
//  JieBa
//
//  Created by 汪洋 on 16/10/21.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CreditListCell.h"

@interface CreditListCell()
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UIImageView *arrowImageView;
@end

@implementation CreditListCell

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
        [self cutLine];
        [self moneyLabel];
        [self timeLabel];
        [self statusLabel];
        [self arrowImageView];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)cutLine{
    if(!_cutLine){
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(49), kScreenWidth, .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [self.contentView addSubview:cutLine];
        _cutLine = cutLine;
    }
    return _cutLine;
}

-(UILabel *)moneyLabel{
    if(!_moneyLabel){
        UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(8), WidthXiShu(150), HeightXiShu(20))];
        moneyLabel.textColor = TitleColor;
        moneyLabel.font = HEITI(HeightXiShu(14));
        [self.contentView addSubview:moneyLabel];
        _moneyLabel = moneyLabel;
    }
    return _moneyLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), self.moneyLabel.maxY, WidthXiShu(150), HeightXiShu(20))];
        timeLabel.textColor = MessageColor;
        timeLabel.font = HEITI(HeightXiShu(14));
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}

-(UILabel *)statusLabel{
    if(!_statusLabel){
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(10)-WidthXiShu(15)-WidthXiShu(80)-self.arrowImageView.width, HeightXiShu(15), WidthXiShu(80), HeightXiShu(20))];
        statusLabel.textColor = MessageColor;
        statusLabel.font = HEITI(HeightXiShu(14));
        statusLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:statusLabel];
        _statusLabel = statusLabel;
    }
    return _statusLabel;
}

-(UIImageView *)arrowImageView{
    if(!_arrowImageView){
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(15)-WidthXiShu(8), HeightXiShu(18.5), WidthXiShu(8), HeightXiShu(13))];
        arrowImageView.image = [GetImagePath getImagePath:@"myCenter_arrow"];
        [self.contentView addSubview:arrowImageView];
        _arrowImageView = arrowImageView;
    }
    return _arrowImageView;
}

-(void)setModel:(CreditListModel *)model{
    self.moneyLabel.text = model.loanmoney;
    self.timeLabel.text = model.timeadd;
    self.statusLabel.text = model.order_status_name;
}

-(void)setIsShowArrow:(BOOL)isShowArrow{
    self.arrowImageView.hidden = !isShowArrow;
}
@end
