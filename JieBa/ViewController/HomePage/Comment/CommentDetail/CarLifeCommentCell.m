//
//  CarLifeCommentCell.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CarLifeCommentCell.h"

@interface CarLifeCommentCell()
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel  *dateLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIButton *detailBtn;
@end

@implementation CarLifeCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)carculateCellHeightWithString:(NSString *)str{
    CGFloat height = 0;
    CGRect size = [str autosizeWithFont:HEITI(HeightXiShu(15)) maxWidth:kScreenWidth-WidthXiShu(24)-WidthXiShu(53)];
    height += size.size.height+HeightXiShu(42);
    return height;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self headImageView];
        [self nameLabel];
        [self dateLabel];
        [self contentLabel];
        [self detailBtn];
        [self cutLine];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)headImageView{
    if(!_headImageView){
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(5), WidthXiShu(40), HeightXiShu(40))];
        headImageView.layer.masksToBounds = YES;
        headImageView.layer.cornerRadius = HeightXiShu(20);
        [self addSubview:headImageView];
        _headImageView = headImageView;
    }
    return _headImageView;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.maxX+WidthXiShu(10), HeightXiShu(5), WidthXiShu(200), HeightXiShu(20))];
        nameLabel.textColor = TitleColor;
        nameLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

-(UILabel *)dateLabel{
    if(!_dateLabel){
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(120), HeightXiShu(5), WidthXiShu(120), HeightXiShu(20))];
        dateLabel.textColor = MessageColor;
        dateLabel.font = HEITI(HeightXiShu(14));
        dateLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:dateLabel];
        _dateLabel = dateLabel;
    }
    return _dateLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.maxX+WidthXiShu(10), self.nameLabel.maxY+HeightXiShu(10), kScreenWidth-WidthXiShu(12)-(self.headImageView.maxX+WidthXiShu(10)), 0)];
        contentLabel.textColor = TitleColor;
        contentLabel.font = HEITI(HeightXiShu(15));
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}

-(UIButton *)detailBtn{
    if(!_detailBtn){
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        detailBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(60), self.dateLabel.maxY+HeightXiShu(5), WidthXiShu(60), HeightXiShu(20));
        [detailBtn setTitle:@"删除" forState:UIControlStateNormal];
        [detailBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
        detailBtn.titleLabel.font = HEITI(HeightXiShu(14));
        detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:detailBtn];
        _detailBtn = detailBtn;
    }
    return _detailBtn;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [self.contentView addSubview:cutLine];
        _cutLine = cutLine;
    }
    return _cutLine;
}

-(void)setModel:(CommentModel *)model{
    CGFloat height = 0;
    CGRect size = [model.content autosizeWithFont:HEITI(HeightXiShu(15)) maxWidth:kScreenWidth-WidthXiShu(24)-WidthXiShu(53)];
    height += size.size.height+HeightXiShu(42);
    self.contentLabel.height = size.size.height;
    
    self.cutLine.minY = height-0.5;
    
    self.nameLabel.text = model.name;
    [self.headImageView sd_setImageWithURL:model.avatarUrl];
    self.dateLabel.text = model.lastTime;
    
    if(model.isReply){
        NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"回复%@：%@",model.to_names,model.content]];
        [attStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(2, model.to_names.length)];
        self.contentLabel.attributedText = attStr;
    }else{
        self.contentLabel.text = model.content;
    }
}
@end
