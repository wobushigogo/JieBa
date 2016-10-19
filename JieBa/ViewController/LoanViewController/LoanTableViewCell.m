//
//  LoanTableViewCell.m
//  JieBa
//
//  Created by 汪洋 on 16/10/18.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "LoanTableViewCell.h"

@interface LoanTableViewCell()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titileLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,copy)UIColor *contentColor;
@end

@implementation LoanTableViewCell

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
        [self titileLabel];
        [self cutLine];
        [self textField];
        [self contentLabel];
        [self detailLabel];
    }
    return self;
}

#pragma mark - 页面元素
-(UILabel *)titileLabel{
    if(!_titileLabel){
        UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, WidthXiShu(65), HeightXiShu(50))];
        titileLabel.textColor = TitleColor;
        titileLabel.font = HEITI(HeightXiShu(16));
        [self addSubview:titileLabel];
        _titileLabel = titileLabel;
    }
    return _titileLabel;
}

-(UITextField *)textField{
    if(!_textField){
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(self.titileLabel.maxX+WidthXiShu(22), 0, WidthXiShu(220), HeightXiShu(50))];
        textField.font = HEITI(HeightXiShu(14));
        textField.delegate = self;
        textField.textColor = TitleColor;
        textField.returnKeyType = UIReturnKeyDone;
        [textField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [self addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titileLabel.maxX+WidthXiShu(22), 0, WidthXiShu(220), HeightXiShu(50))];
        contentLabel.font = HEITI(HeightXiShu(14));
        contentLabel.textColor = PlaceholderColor;
        [self addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
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

-(UILabel *)detailLabel{
    if(!_detailLabel){
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(40), 0, WidthXiShu(40), HeightXiShu(50))];
        detailLabel.textColor = TitleColor;
        detailLabel.font = HEITI(HeightXiShu(16));
        detailLabel.text = @"元/月";
        [self addSubview:detailLabel];
        _detailLabel = detailLabel;
    }
    return _detailLabel;
}

#pragma - mark setter
-(void)setIsShowCutLine:(BOOL)isShowCutLine{
    self.cutLine.hidden = !isShowCutLine;
    self.contentLabel.textColor = isShowCutLine ? self.contentColor:NavColor;
}

-(void)setIsShowDetailLanel:(BOOL)isShowDetailLanel{
    self.detailLabel.hidden = !isShowDetailLanel;
}

-(void)setIsShowLabel:(BOOL)isShowLabel{
    self.textField.hidden = isShowLabel;
    self.contentLabel.hidden = !isShowLabel;
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titileLabel.text = titleStr;
}

-(void)setPlaceholderStr:(NSString *)placeholderStr{
    _placeholderStr = placeholderStr;
    self.textField.placeholder = placeholderStr;
    self.contentLabel.text = placeholderStr;
    self.contentColor = PlaceholderColor;
}

-(void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
    self.textField.text = contentStr;
    if(![contentStr isEqualToString:@""]){
        self.contentLabel.text = contentStr;
        self.contentColor = TitleColor;
    }
}

-(void)setKeyBoardType:(KeyBoardType)keyBoardType{
    if(keyBoardType == stringType){
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }else{
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

#pragma  mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:indexRow:)]){
        [self.delegate textFieldDidEndEditing:textField indexRow:self.indexPath.row];
    }
}
@end
