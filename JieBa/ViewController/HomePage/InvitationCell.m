//
//  InvitationCell.m
//  JieBa
//
//  Created by 汪洋 on 16/10/16.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "InvitationCell.h"
#import "InvitationModel.h"

@interface InvitationCell()
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation InvitationCell

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
        [self addSubview:self.scrollView];
    }
    return self;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(100))];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(void)setModelsArr:(NSMutableArray *)modelsArr{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat const margin = WidthXiShu(12);
    CGFloat const space = WidthXiShu(15);
    CGFloat const width = WidthXiShu(125);
    
    [modelsArr enumerateObjectsUsingBlock:^(InvitationModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(margin + (width + space) * idx, HeightXiShu(10), width, HeightXiShu(133))];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, HeightXiShu(84))];
        [imageView sd_setImageWithURL:model.imageUrl placeholderImage:nil];
        //imageView.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:imageView];
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(84), width, HeightXiShu(49))];
        contentLabel.text = model.content;
        contentLabel.font = HEITI(HeightXiShu(14));
        contentLabel.textColor = TitleColor;
        [bgView addSubview:contentLabel];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, HeightXiShu(133))];
        [btn addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = idx;
        [bgView addSubview:btn];
        [self.scrollView addSubview:bgView];
    }];
    self.scrollView.clipsToBounds = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.subviews.lastObject.maxX, self.scrollView.height);
}

- (void)imageClicked:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(detailedListInvitationCell:imageClicked:)]) {
        [self.delegate detailedListInvitationCell:self imageClicked:btn.tag];
    }
}
@end
