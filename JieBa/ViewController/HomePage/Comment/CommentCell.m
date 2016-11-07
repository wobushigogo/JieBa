//
//  CommentCell.m
//  JieBa
//
//  Created by 汪洋 on 16/10/27.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel  *dateLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *locationLabel;
@property(nonatomic,strong)UIView *commentView;
@property(nonatomic,strong)UILabel *commentLabel;
@property(nonatomic,strong)UIImageView *commentImageView;
@property(nonatomic,strong)UIView *goodView;
@property(nonatomic,strong)UILabel *goodLabel;
@property(nonatomic,strong)UIImageView *goodImageView;
@property(nonatomic,strong)UIView *imagesView;
@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)carculateCellHeightWithString:(NSString *)str imgArr:(NSMutableArray *)imgArr{
    CGFloat height = 0;
    CGRect size = [str autosizeWithFont:HEITI(HeightXiShu(14)) maxWidth:kScreenWidth-WidthXiShu(24) maxHeight:HeightXiShu(40)];
    if(imgArr.count != 0){
        height += size.size.height+HeightXiShu(62)+HeightXiShu(10)+HeightXiShu(161);
    }else{
        height += size.size.height+HeightXiShu(62)+HeightXiShu(10)+HeightXiShu(161)-HeightXiShu(125);
    }
    return height;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = AllBackLightGratColor;
        [self bgView];
        [self headImageView];
        [self nameLabel];
        [self dateLabel];
        [self detailLabel];
        [self contentLabel];
        [self imagesView];
        [self locationLabel];
        [self commentView];
    }
    return self;
}

#pragma mark - 页面元素
-(UIView *)bgView{
    if(!_bgView){
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, HeightXiShu(10), kScreenWidth, HeightXiShu(50))];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}

-(UIImageView *)headImageView{
    if(!_headImageView){
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(5), WidthXiShu(40), HeightXiShu(40))];
        headImageView.layer.masksToBounds = YES;
        headImageView.layer.cornerRadius = HeightXiShu(20);
        [self.bgView addSubview:headImageView];
        _headImageView = headImageView;
    }
    return _headImageView;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.maxX+WidthXiShu(10), HeightXiShu(5), WidthXiShu(200), HeightXiShu(20))];
        nameLabel.textColor = TitleColor;
        nameLabel.font = HEITI(HeightXiShu(14));
        [self.bgView addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

-(UILabel *)dateLabel{
    if(!_dateLabel){
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.maxX+WidthXiShu(10), self.nameLabel.maxY, WidthXiShu(200), HeightXiShu(20))];
        dateLabel.textColor = MessageColor;
        dateLabel.font = HEITI(HeightXiShu(14));
        [self.bgView addSubview:dateLabel];
        _dateLabel = dateLabel;
    }
    return _dateLabel;
}

-(UILabel *)detailLabel{
    if(!_detailLabel){
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(80), HeightXiShu(20), WidthXiShu(80), HeightXiShu(20))];
        detailLabel.text = @"查看全文》";
        detailLabel.font = HEITI(HeightXiShu(14));
        detailLabel.textColor = ButtonColor;
        detailLabel.textAlignment = NSTextAlignmentRight;
        [self.bgView addSubview:detailLabel];
        _detailLabel = detailLabel;
    }
    return _detailLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), self.headImageView.maxY+HeightXiShu(8), kScreenWidth-WidthXiShu(24), 0)];
        contentLabel.textColor = TitleColor;
        contentLabel.font = HEITI(HeightXiShu(14));
        contentLabel.numberOfLines = 0;
        [self.bgView addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}

-(UIView *)imagesView{
    if(!_imagesView){
        UIView *imagesView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentLabel.maxY+HeightXiShu(6), kScreenWidth, HeightXiShu(113))];
        [self.bgView addSubview:imagesView];
        _imagesView = imagesView;
    }
    return _imagesView;
}

-(UILabel *)locationLabel{
    if(!_locationLabel){
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), self.bgView.height-HeightXiShu(16)-HeightXiShu(20), WidthXiShu(100), HeightXiShu(20))];
        locationLabel.textColor = MessageColor;
        locationLabel.font = HEITI(HeightXiShu(14));
        [self.bgView addSubview:locationLabel];
        _locationLabel = locationLabel;
    }
    return _locationLabel;
}

-(UIView *)commentView{
    if(!_commentView){
        UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(60), self.bgView.height-HeightXiShu(16)-HeightXiShu(20), WidthXiShu(60), HeightXiShu(20))];
        
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(commentView.width-WidthXiShu(42), 0, WidthXiShu(42), HeightXiShu(20))];
        commentLabel.textAlignment = NSTextAlignmentRight;
        commentLabel.textColor = MessageColor;
        commentLabel.font = HEITI(HeightXiShu(14));
        [commentView addSubview:commentLabel];
        
        UIImageView *commentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, WidthXiShu(18), HeightXiShu(18))];
        commentImageView.maxX = commentLabel.minX;
        commentImageView.image = [GetImagePath getImagePath:@"carLife_listComment"];
        [commentView addSubview:commentImageView];
        
        [self.bgView addSubview:commentView];
        _commentImageView = commentImageView;
        _commentLabel = commentLabel;
        _commentView = commentView;
    }
    return _commentView;
}

-(UIView *)goodView{
    if(!_goodView){
        UIView *goodView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bgView.height-HeightXiShu(16)-HeightXiShu(20), WidthXiShu(60), HeightXiShu(20))];
        
        UILabel *goodLabel = [[UILabel alloc] initWithFrame:CGRectMake(goodView.width-WidthXiShu(42), 0, WidthXiShu(42), HeightXiShu(20))];
        goodLabel.textAlignment = NSTextAlignmentRight;
        goodLabel.textColor = MessageColor;
        goodLabel.font = HEITI(HeightXiShu(14));
        [goodView addSubview:goodLabel];
        
        UIImageView *goodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, WidthXiShu(18), HeightXiShu(18))];
        goodImageView.maxX = goodLabel.minX;
        [goodView addSubview:goodImageView];
        
        UIButton *goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        goodBtn.frame = CGRectMake(0, 0, WidthXiShu(60), HeightXiShu(20));
        [goodBtn addTarget:self action:@selector(goodAction) forControlEvents:UIControlEventTouchUpInside];
        [goodView addSubview:goodBtn];
        
        [self.bgView addSubview:goodView];
        _goodImageView = goodImageView;
        _goodLabel = goodLabel;
        _goodView = goodView;
    }
    return _goodView;
}

-(void)setModel:(CarlifeModel *)model{
    _model = model;
    [self.imagesView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGRect size = [model.content autosizeWithFont:HEITI(HeightXiShu(14)) maxWidth:kScreenWidth-WidthXiShu(24) maxHeight:HeightXiShu(40)];
    self.contentLabel.height = size.size.height;
    if(model.imageArr.count != 0){
        self.bgView.height = self.contentLabel.maxY+HeightXiShu(161);
        self.imagesView.height = HeightXiShu(113);
    }else{
        self.bgView.height = self.contentLabel.maxY+HeightXiShu(161)-HeightXiShu(125);
        self.imagesView.height = 0;
    }
    
    self.nameLabel.text = model.name;
    [self.headImageView sd_setImageWithURL:model.avatarUrl];
    self.dateLabel.text = [StringTool timeChange2:model.lastTime];
    self.contentLabel.text = model.content;
    self.imagesView.minY = self.contentLabel.maxY + HeightXiShu(6);
    
    [model.imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(((WidthXiShu(6)+WidthXiShu(113))*idx)+WidthXiShu(16), 0, WidthXiShu(113), HeightXiShu(113))];
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[GetImagePath getImagePath:@"default_smallBannre"]];
        [self.imagesView addSubview:imageView];
    }];
    
    self.locationLabel.text = model.location;
    self.locationLabel.maxY = self.bgView.height - HeightXiShu(12);
    
    self.commentView.maxY = self.bgView.height - HeightXiShu(12);
    self.commentLabel.text = model.eval_num;
    [self.commentLabel autosize];
    self.commentLabel.height = HeightXiShu(20);
    self.commentLabel.maxX = self.commentView.width;
    self.commentImageView.maxX = self.commentLabel.minX-WidthXiShu(4);
    
    self.goodView.maxY = self.bgView.height - HeightXiShu(12);
    self.goodView.maxX = self.commentView.minX - WidthXiShu(5);
    self.goodLabel.text = model.point_num;
    [self.goodLabel autosize];
    self.goodLabel.height = HeightXiShu(20);
    self.goodLabel.maxX = self.goodView.width;
    self.goodImageView.maxX = self.goodLabel.minX - WidthXiShu(4);
    
    if(model.is_point){
        self.goodImageView.image = [GetImagePath getImagePath:@"carLife_good"];
    }else{
        self.goodImageView.image = [GetImagePath getImagePath:@"carLife_noGood"];
    }
}

-(void)setIs_point:(BOOL)is_point{
    _is_point = is_point;
    if(is_point){
        self.goodImageView.image = [GetImagePath getImagePath:@"carLife_good"];
    }else{
        self.goodImageView.image = [GetImagePath getImagePath:@"carLife_noGood"];
    }
}

-(void)setPoint_num:(NSString *)point_num{
    _point_num = point_num;
    self.goodLabel.text = point_num;
}

-(void)goodAction{
    if([self.delegate respondsToSelector:@selector(goodClick:cell:)]){
        [self.delegate goodClick:self.model cell:self];
    }
}
@end
