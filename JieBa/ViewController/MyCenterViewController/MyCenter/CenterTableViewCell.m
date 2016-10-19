//
//  CenterTableViewCell.m
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CenterTableViewCell.h"

@interface CenterTableViewCell()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UIImageView *cutLine;
@end

@implementation CenterTableViewCell

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
        [self titleLabel];
        [self detailLabel];
        [self arrowImageView];
        [self cutLine];
    }
    return self;
}

#pragma mark - 页面元素
-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, WidthXiShu(100), HeightXiShu(50))];
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(HeightXiShu(15)));
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UILabel *)detailLabel{
    if(!_detailLabel){
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(30)-WidthXiShu(100), 0, WidthXiShu(100), HeightXiShu(50))];
        detailLabel.textColor = TitleColor;
        detailLabel.font = HEITI(HeightXiShu(HeightXiShu(15)));
        detailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:detailLabel];
        _detailLabel = detailLabel;
    }
    return _detailLabel;
}

-(UIImageView *)arrowImageView{
    if(!_arrowImageView){
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(10)-WidthXiShu(8), HeightXiShu(18.5), WidthXiShu(8), HeightXiShu(13))];
        arrowImageView.image = [GetImagePath getImagePath:@"myCenter_arrow"];
        [self addSubview:arrowImageView];
        _arrowImageView = arrowImageView;
    }
    return _arrowImageView;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(50), kScreenWidth, .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [self addSubview:cutLine];
        _cutLine = cutLine;
    }
    return _cutLine;
}

#pragma mark - setter
-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

-(void)setDetail:(NSString *)detail{
    self.detailLabel.text = detail;
}

-(void)setIsShowCutLine:(BOOL)isShowCutLine{
    _isShowCutLine = isShowCutLine;
    self.cutLine.hidden = !isShowCutLine;
}
@end
