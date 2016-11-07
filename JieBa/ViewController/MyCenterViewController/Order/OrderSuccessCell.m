//
//  OrderSuccessCell.m
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "OrderSuccessCell.h"

@interface OrderSuccessCell()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *detailView;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UILabel *orderTypeLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UIImageView *cutLine2;
@property(nonatomic,strong)UIImageView *smallImageView;
@property(nonatomic,strong)UILabel *loanmoneyLabel;
@property(nonatomic,strong)UILabel *timeaddLabel;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UILabel *orderStatusLabel;
@property(nonatomic,strong)UIButton *detailBtn;
@end

@implementation OrderSuccessCell

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
        self.contentView.backgroundColor = AllBackLightGratColor;
        [self bgView];
        [self statusLabel];
        [self detailBtn];
        [self detailView];
        [self orderTypeLabel];
        [self cutLine];
        [self smallImageView];
        [self loanmoneyLabel];
        [self timeaddLabel];
        [self orderStatusLabel];
        [self cutLine2];
        [self commentBtn];
    }
    return self;
}

#pragma mark - 页面元素
-(UIView *)bgView{
    if(!_bgView){
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(10), kScreenWidth-WidthXiShu(24), HeightXiShu(207))];
        bgView.backgroundColor = RGBCOLOR(246, 245, 245);
        bgView.layer.borderWidth = 1;
        bgView.layer.borderColor = RGBCOLOR(218, 218, 218).CGColor;
        [self addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}

-(UIView *)detailView{
    if(!_detailView){
        UIView *detailView = [[UIView alloc] initWithFrame:CGRectMake(0, HeightXiShu(35), self.bgView.width, self.bgView.height-HeightXiShu(35))];
        detailView.backgroundColor = [UIColor whiteColor];
        [self.bgView addSubview:detailView];
        _detailView = detailView;
    }
    return _detailView;
}

-(UILabel *)statusLabel{
    if(!_statusLabel){
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, kScreenWidth-WidthXiShu(30), HeightXiShu(35))];
        statusLabel.textColor = ButtonColor;
        statusLabel.font = HEITI(HeightXiShu(14));
        [self.bgView addSubview:statusLabel];
        _statusLabel = statusLabel;
    }
    return _statusLabel;
}

-(UIButton *)detailBtn{
    if(!_detailBtn){
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        detailBtn.frame = CGRectMake(self.bgView.width-WidthXiShu(12)-WidthXiShu(80), 0, WidthXiShu(80), HeightXiShu(35));
        [detailBtn setTitle:@"查看详情>>" forState:UIControlStateNormal];
        [detailBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        detailBtn.titleLabel.font = HEITI(HeightXiShu(14));
        detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.bgView addSubview:detailBtn];
        _detailBtn = detailBtn;
    }
    return _detailBtn;
}

-(UILabel *)orderTypeLabel{
    if(!_orderTypeLabel){
        UILabel *orderTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, kScreenWidth-WidthXiShu(30), HeightXiShu(40))];
        orderTypeLabel.textColor = TitleColor;
        orderTypeLabel.font = HEITI(HeightXiShu(14));
        [self.detailView addSubview:orderTypeLabel];
        _orderTypeLabel = orderTypeLabel;
    }
    return _orderTypeLabel;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(40), self.detailView.width-WidthXiShu(20), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [self.detailView addSubview:cutLine];
        _cutLine = cutLine;
    }
    return _cutLine;
}

-(UIImageView *)cutLine2{
    if(!_cutLine2){
        UIImageView *cutLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(128), self.detailView.width-WidthXiShu(20), .5)];
        cutLine2.backgroundColor = AllLightGrayColor;
        [self.detailView addSubview:cutLine2];
        _cutLine2 = cutLine2;
    }
    return _cutLine2;
}

-(UIImageView *)smallImageView{
    if(!_smallImageView){
        UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), self.cutLine.maxY+HeightXiShu(15), WidthXiShu(61), HeightXiShu(61))];
        [self.detailView addSubview:smallImageView];
        _smallImageView = smallImageView;
    }
    return _smallImageView;
}

-(UILabel *)loanmoneyLabel{
    if(!_loanmoneyLabel){
        UILabel *loanmoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.smallImageView.maxX+WidthXiShu(10), self.cutLine.maxY+HeightXiShu(17), kScreenWidth-(self.smallImageView.maxX+WidthXiShu(20)), HeightXiShu(20))];
        loanmoneyLabel.textColor = TitleColor;
        loanmoneyLabel.font = HEITI(HeightXiShu(14));
        [self.detailView addSubview:loanmoneyLabel];
        _loanmoneyLabel = loanmoneyLabel;
    }
    return _loanmoneyLabel;
}

-(UILabel *)timeaddLabel{
    if(!_timeaddLabel){
        UILabel *timeaddLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.smallImageView.maxX+WidthXiShu(10), self.loanmoneyLabel.maxY+HeightXiShu(5), kScreenWidth-(self.smallImageView.maxX+WidthXiShu(20)), HeightXiShu(20))];
        timeaddLabel.textColor = TitleColor;
        timeaddLabel.font = HEITI(HeightXiShu(14));
        [self.detailView addSubview:timeaddLabel];
        _timeaddLabel = timeaddLabel;
    }
    return _timeaddLabel;
}

-(UIButton *)commentBtn{
    if(!_commentBtn){
        UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commentBtn.frame = CGRectMake(self.detailView.width-WidthXiShu(8)-WidthXiShu(78), self.cutLine2.maxY+HeightXiShu(10), WidthXiShu(78), HeightXiShu(27));
        commentBtn.backgroundColor = ButtonColor;
        [commentBtn setTitle:@"立即评价" forState:UIControlStateNormal];
        commentBtn.titleLabel.font = HEITI(HeightXiShu(14));
        commentBtn.layer.masksToBounds = YES;
        commentBtn.layer.cornerRadius = HeightXiShu(3);
        [commentBtn addTarget:self action:@selector(commentACtion) forControlEvents:UIControlEventTouchUpInside];
        [self.detailView addSubview:commentBtn];
        _commentBtn = commentBtn;
    }
    return _commentBtn;
}

-(UILabel *)orderStatusLabel{
    if(!_orderStatusLabel){
        UILabel *orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.detailView.width-WidthXiShu(12)-WidthXiShu(80), self.timeaddLabel.maxY, WidthXiShu(80), HeightXiShu(20))];
        orderStatusLabel.textColor = ButtonColor;
        orderStatusLabel.textAlignment = NSTextAlignmentRight;
        orderStatusLabel.font = HEITI(HeightXiShu(14));
        [self.detailView addSubview:orderStatusLabel];
        
        _orderStatusLabel = orderStatusLabel;
    }
    return _orderStatusLabel;
}

#pragma mark - setter
-(void)setModel:(OrderModel *)model{
    self.statusLabel.text = model.statusStr;
    self.orderTypeLabel.text = model.orderTypeStr;
    [self.smallImageView sd_setImageWithURL:model.imageUrl placeholderImage:nil];
    self.loanmoneyLabel.text = [NSString stringWithFormat:@"借款金额：%@",model.loanmoney];
    self.timeaddLabel.text = [NSString stringWithFormat:@"申请时间：%@",model.timeadd];
    self.orderStatusLabel.text = model.order_status;
    if(model.is_assed){
        [self.commentBtn setTitle:@"已评价" forState:UIControlStateNormal];
    }else{
        [self.commentBtn setTitle:@"立即评价" forState:UIControlStateNormal];
    }
}

-(void)setAssedModel:(AssedModel *)assedModel{
    self.statusLabel.text = assedModel.statusStr;
    self.orderTypeLabel.text = assedModel.orderTypeStr;
    [self.smallImageView sd_setImageWithURL:assedModel.imageUrl placeholderImage:nil];
    self.loanmoneyLabel.text = [NSString stringWithFormat:@"借款金额：%@",assedModel.loanmoney];
    self.timeaddLabel.text = [NSString stringWithFormat:@"申请时间：%@",assedModel.timeadd];
    if(assedModel.is_assed){
        [self.commentBtn setTitle:@"已评价" forState:UIControlStateNormal];
    }else{
        [self.commentBtn setTitle:@"立即评价" forState:UIControlStateNormal];
    }
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(void)commentACtion{
    if([self.delegate respondsToSelector:@selector(commentClick:)]){
        [self.delegate commentClick:self.indexPath.row];
    }
}
@end
