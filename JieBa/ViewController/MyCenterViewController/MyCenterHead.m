//
//  MyCenterHead.m
//  JieBa
//
//  Created by 汪洋 on 16/10/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MyCenterHead.h"

@interface MyCenterHead()
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIButton *userImgBtn;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UIButton *signBtn;
@property(nonatomic,strong)UIButton *activeBtn;
@property(nonatomic,strong)UIButton *QRBtn;
@property(nonatomic,strong)UIView *messageView;
@property(nonatomic,strong)UILabel *numLabel;
@end

@implementation MyCenterHead

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self bgImageView];
        [self userImgBtn];
        [self nameLabel];
        [self levelLabel];
        [self messageView];
        [self QRBtn];
        [self footerView];
        [self cutLine];
        [self signBtn];
        [self activeBtn];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)bgImageView{
    if(!_bgImageView){
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        bgImageView.image = [GetImagePath getImagePath:@"myCenter_banner"];
        [self addSubview:bgImageView];
        _bgImageView = bgImageView;
    }
    return _bgImageView;
}

- (UIButton *)userImgBtn {
    if (!_userImgBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(60), WidthXiShu(65), HeightXiShu(65))];
        btn.layer.cornerRadius = btn.halfWidth;
        btn.layer.borderWidth = 5;
        btn.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        btn.layer.masksToBounds = YES;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [btn addTarget:self action:@selector(changeHeadAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        _userImgBtn = btn;
    }
    return _userImgBtn;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(90), HeightXiShu(72), WidthXiShu(150), HeightXiShu(20))];
        nameLabel.text = @"";
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

-(UILabel *)levelLabel{
    if(!_levelLabel){
        UILabel *levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(90), HeightXiShu(97), WidthXiShu(150), HeightXiShu(20))];
        levelLabel.textColor = [UIColor whiteColor];
        levelLabel.text = @"普通会员";
        levelLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:levelLabel];
        _levelLabel = levelLabel;
    }
    return _levelLabel;
}

-(UIView *)messageView{
    if(!_messageView){
        UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(20)-WidthXiShu(30), HeightXiShu(30), WidthXiShu(30), HeightXiShu(30))];
        
        UIImageView *messageImage = [[UIImageView alloc] initWithImage:[GetImagePath getImagePath:@"myCenter_message"]];
        messageImage.center = CGPointMake(WidthXiShu(15), HeightXiShu(15));
        [messageView addSubview:messageImage];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, messageView.width, messageView.height);
        [btn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
        [messageView addSubview:btn];
        
        [self addSubview:messageView];
        
        _messageView = messageView;
    }
    return _messageView;
}

-(UIButton *)QRBtn{
    if(!_QRBtn){
        UIButton *QRBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        QRBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(20)-WidthXiShu(25), HeightXiShu(84), WidthXiShu(25), HeightXiShu(23));
        [QRBtn setImage:[GetImagePath getImagePath:@"myCenter_ewm"] forState:UIControlStateNormal];
        [QRBtn addTarget:self action:@selector(QRCodeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:QRBtn];
        _QRBtn = QRBtn;
    }
    return _QRBtn;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, HeightXiShu(165), kScreenWidth, HeightXiShu(45))];
        footerView.backgroundColor = NavColor;
        footerView.alpha = .3;
        [self addSubview:footerView];
        _footerView = footerView;
    }
    return _footerView;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-1, HeightXiShu(165), WidthXiShu(2), HeightXiShu(45))];
        cutLine.backgroundColor = NavColor;
        [self addSubview:cutLine];
        _cutLine = cutLine;
    }
    return _cutLine;
}

-(UIButton *)signBtn{
    if(!_signBtn){
        UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        signBtn.frame = CGRectMake(0, HeightXiShu(165), kScreenWidth/2-2, HeightXiShu(45));
        [signBtn setTitle:@"签到" forState:UIControlStateNormal];
        [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [signBtn setImage:[GetImagePath getImagePath:@"myCenter_sign"] forState:UIControlStateNormal];
        signBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WidthXiShu(10));
        signBtn.titleLabel.font = HEITI(HeightXiShu(14));
        [signBtn addTarget:self action:@selector(signAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:signBtn];
        _signBtn = signBtn;
    }
    return _signBtn;
}

-(UIButton *)activeBtn{
    if(!_activeBtn){
        UIButton *activeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        activeBtn.frame = CGRectMake(kScreenWidth/2+2, HeightXiShu(165), kScreenWidth/2-2, HeightXiShu(45));
        [activeBtn setTitle:@"邀请" forState:UIControlStateNormal];
        [activeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [activeBtn setImage:[GetImagePath getImagePath:@"myCenter_ invitation"] forState:UIControlStateNormal];
        activeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WidthXiShu(10));
        activeBtn.titleLabel.font = HEITI(HeightXiShu(14));
        [activeBtn addTarget:self action:@selector(activeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:activeBtn];
        _activeBtn = activeBtn;
    }
    return _activeBtn;
}

#pragma mark - 事件
-(void)changeHeadAction{
    if([self.delegate respondsToSelector:@selector(changeHeadClick)]){
        [self.delegate changeHeadClick];
    }
}

-(void)messageAction{
    if([self.delegate respondsToSelector:@selector(messageClick)]){
        [self.delegate messageClick];
    }
}

-(void)QRCodeAction{
    if([self.delegate respondsToSelector:@selector(QRCoedeClick)]){
        [self.delegate QRCoedeClick];
    }
}

-(void)signAction{
    if([self.delegate respondsToSelector:@selector(signClick)]){
        [self.delegate signClick];
    }
}

-(void)activeAction{
    if([self.delegate respondsToSelector:@selector(activeClick)]){
        [self.delegate activeClick];
    }
}

#pragma mark - setter
-(void)setModel:(UserInfoModel *)model{
    __block typeof(self)wSelf = self;
    [self.userImgBtn sd_setImageWithURL:model.avatarUrl forState:UIControlStateNormal placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [wSelf.userImgBtn setImage:[StringTool imageWithRoundedCornersSize:image.size.width/2 usingImage:image] forState:UIControlStateNormal];
    }];
    self.nameLabel.text = model.userName;
}

-(void)setAvatarUrl:(NSString *)avatarUrl{
    _avatarUrl = avatarUrl;
    __block typeof(self)wSelf = self;
    [self.userImgBtn sd_setImageWithURL:[NSURL URLWithString:avatarUrl] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [wSelf.userImgBtn setImage:[StringTool imageWithRoundedCornersSize:image.size.width/2 usingImage:image] forState:UIControlStateNormal];
    }];
}
@end
