//
//  MessageListCell.m
//  JieBa
//
//  Created by 汪洋 on 16/10/28.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MessageListCell.h"

@interface MessageListCell()
@property(nonatomic,strong)UIImageView *smallImageView;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@end

@implementation MessageListCell

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
        [self smallImageView];
        [self titleLabel];
        [self contentLabel];
        [self timeLabel];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)smallImageView{
    if(!_smallImageView){
        UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(20), WidthXiShu(8), HeightXiShu(8))];
        smallImageView.backgroundColor = ButtonColor;
        smallImageView.layer.masksToBounds = YES;
        smallImageView.layer.cornerRadius = HeightXiShu(4);
        [self.contentView addSubview:smallImageView];
        _smallImageView = smallImageView;
    }
    return _smallImageView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(15), WidthXiShu(180), HeightXiShu(20))];
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(15));
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), self.titleLabel.maxY+HeightXiShu(17), kScreenWidth-WidthXiShu(24), HeightXiShu(20))];
        contentLabel.textColor = MessageColor;
        contentLabel.font = HEITI(HeightXiShu(14));
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(80), HeightXiShu(15), WidthXiShu(80), HeightXiShu(20))];
        timeLabel.textColor = PlaceholderColor;
        timeLabel.font = HEITI(HeightXiShu(15));
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(79), kScreenWidth, .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [self addSubview:cutLine];
        _cutLine = cutLine;
    }
    return _cutLine;
}

-(void)setIsShowCutLine:(BOOL)isShowCutLine{
    self.cutLine.hidden = isShowCutLine;
}

-(void)setModel:(MessageModel *)model{
    if(model.isRead){
        self.smallImageView.hidden = YES;
        self.titleLabel.frame = CGRectMake(WidthXiShu(12), HeightXiShu(15), WidthXiShu(180), HeightXiShu(20));
    }else{
        self.smallImageView.hidden = NO;
        self.titleLabel.frame = CGRectMake(WidthXiShu(12)+WidthXiShu(10)+self.smallImageView.width, HeightXiShu(15), WidthXiShu(180), HeightXiShu(20));
    }
    
    
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.contentLabel.text = model.content;
}
@end
