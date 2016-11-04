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
    CGRect size = [str autosizeWithFont:HEITI(HeightXiShu(14)) maxWidth:kScreenWidth-WidthXiShu(24)];
    height += size.size.height+HeightXiShu(62)+HeightXiShu(10)+HeightXiShu(161);
    return height;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
@end
