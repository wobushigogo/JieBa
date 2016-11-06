//
//  CommentHeadView.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CommentHeadView.h"

@interface CommentHeadView()
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel  *dateLabel;
@property(nonatomic,strong)UIButton *detailBtn;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *locationLabel;
@property(nonatomic,strong)UIView *commentView;
@property(nonatomic,strong)UILabel *commentLabel;
@property(nonatomic,strong)UIImageView *commentImageView;
@property(nonatomic,strong)UIView *goodView;
@property(nonatomic,strong)UILabel *goodLabel;
@property(nonatomic,strong)UIImageView *goodImageView;
@end

@implementation CommentHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self headImageView];
        [self nameLabel];
        [self dateLabel];
        [self detailBtn];
        [self contentLabel];
        [self locationLabel];
        [self commentView];
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
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.maxX+WidthXiShu(10), self.nameLabel.maxY, WidthXiShu(200), HeightXiShu(20))];
        dateLabel.textColor = MessageColor;
        dateLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:dateLabel];
        _dateLabel = dateLabel;
    }
    return _dateLabel;
}

-(UIButton *)detailBtn{
    if(!_detailBtn){
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        detailBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(60), HeightXiShu(20), WidthXiShu(60), HeightXiShu(20));
        [detailBtn setTitle:@"删除" forState:UIControlStateNormal];
        [detailBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
        detailBtn.titleLabel.font = HEITI(HeightXiShu(14));
        detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:detailBtn];
        _detailBtn = detailBtn;
    }
    return _detailBtn;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), self.headImageView.maxY+HeightXiShu(8), kScreenWidth-WidthXiShu(24), 0)];
        contentLabel.textColor = TitleColor;
        contentLabel.font = HEITI(HeightXiShu(14));
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}

-(UILabel *)locationLabel{
    if(!_locationLabel){
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), self.height-HeightXiShu(16)-HeightXiShu(20), WidthXiShu(100), HeightXiShu(20))];
        locationLabel.textColor = MessageColor;
        locationLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:locationLabel];
        _locationLabel = locationLabel;
    }
    return _locationLabel;
}

-(UIView *)commentView{
    if(!_commentView){
        UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(60), self.height-HeightXiShu(16)-HeightXiShu(20), WidthXiShu(60), HeightXiShu(20))];
                
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(commentView.width-WidthXiShu(42), 0, WidthXiShu(42), HeightXiShu(20))];
        commentLabel.textAlignment = NSTextAlignmentRight;
        commentLabel.textColor = MessageColor;
        commentLabel.font = HEITI(HeightXiShu(14));
        [commentView addSubview:commentLabel];
        
        UIImageView *commentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, WidthXiShu(18), HeightXiShu(18))];
        commentImageView.maxX = commentLabel.minX;
        commentImageView.image = [GetImagePath getImagePath:@"carLife_listComment"];
        [commentView addSubview:commentImageView];
        
        UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commentBtn.frame = CGRectMake(0, 0, WidthXiShu(60), HeightXiShu(20));
        [commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
        [commentView addSubview:commentBtn];
        
        [self addSubview:commentView];
        _commentImageView = commentImageView;
        _commentLabel = commentLabel;
        _commentView = commentView;
    }
    return _commentView;
}

-(UIView *)goodView{
    if(!_goodView){
        UIView *goodView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-HeightXiShu(16)-HeightXiShu(20), WidthXiShu(60), HeightXiShu(20))];
        
        UILabel *goodLabel = [[UILabel alloc] initWithFrame:CGRectMake(goodView.width-WidthXiShu(42), 0, WidthXiShu(42), HeightXiShu(20))];
        goodLabel.textAlignment = NSTextAlignmentRight;
        goodLabel.textColor = MessageColor;
        goodLabel.font = HEITI(HeightXiShu(14));
        [goodView addSubview:goodLabel];
        
        UIImageView *goodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, WidthXiShu(18), HeightXiShu(18))];
        goodImageView.maxX = goodLabel.minX;
        goodImageView.image = [GetImagePath getImagePath:@"carLife_good"];
        [goodView addSubview:goodImageView];
        
        [self addSubview:goodView];
        _goodImageView = goodImageView;
        _goodLabel = goodLabel;
        _goodView = goodView;
    }
    return _goodView;
}

-(void)setModel:(CarlifeModel *)model{
    _model = model;
    CGFloat height = 0;
    CGRect size = [model.content autosizeWithFont:HEITI(HeightXiShu(14)) maxWidth:kScreenWidth-WidthXiShu(24)];
    height += size.size.height+HeightXiShu(62)+HeightXiShu(10)+HeightXiShu(161);
    if(self.heightBlock){
        self.heightBlock(height);
    }
    self.contentLabel.height = size.size.height;
    self.nameLabel.text = model.name;
    [self.headImageView sd_setImageWithURL:model.avatarUrl];
    self.dateLabel.text = [StringTool timeInfoWithDateString:model.lastTime];
    self.contentLabel.text = model.content;
    self.detailBtn.hidden = !model.can_delete;
    
    
    [model.imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(((WidthXiShu(6)+WidthXiShu(113))*idx)+WidthXiShu(16), self.contentLabel.maxY+HeightXiShu(6), WidthXiShu(113), HeightXiShu(113))];
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj]];
        [self addSubview:imageView];
    }];
    
    self.locationLabel.text = model.location;
    self.locationLabel.maxY = height - HeightXiShu(12);
    
    self.commentView.maxY = height - HeightXiShu(12);
    self.commentLabel.text = model.eval_num;
    [self.commentLabel autosize];
    self.commentLabel.height = HeightXiShu(20);
    self.commentLabel.maxX = self.commentView.width;
    self.commentImageView.maxX = self.commentLabel.minX-WidthXiShu(4);
    
    self.goodView.maxY = height - HeightXiShu(12);
    self.goodView.maxX = self.commentView.minX - WidthXiShu(5);
    self.goodLabel.text = model.point_num;
    [self.goodLabel autosize];
    self.goodLabel.height = HeightXiShu(20);
    self.goodLabel.maxX = self.goodView.width;
    self.goodImageView.maxX = self.goodLabel.minX - WidthXiShu(4);
}

-(void)commentAction{
    if([self.delegate respondsToSelector:@selector(commentClick:)]){
        [self.delegate commentClick:self.model.commentId];
    }
}
@end
