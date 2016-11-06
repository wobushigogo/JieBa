//
//  CommentChatToolBar.m
//  tianjing
//
//  Created by 汪洋 on 15/10/23.
//  Copyright © 2015年 lanwan. All rights reserved.
//

#import "CommentChatToolBar.h"

@interface CommentChatToolBar()<UITextViewDelegate>
@property(nonatomic,strong)UIButton *sendBtn;
@property(nonatomic,strong)UILabel *placeLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic)NSInteger maxTextCount;
@property(nonatomic)NSInteger maxTextCountInChat;
@property(nonatomic)CGFloat lastContentSizeHeight;
@end

@implementation CommentChatToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        self.backgroundColor = RGBCOLOR(250, 250, 250);
        [self addSubview:self.cutLine];
        [self.textView addSubview:self.placeLabel];
        [self addSubview:self.textView];
        //[self addSubview:self.sendBtn];
        [self.textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(0.5))];
        _cutLine.backgroundColor = RGBCOLOR(217, 217, 217);
    }
    return _cutLine;
}

-(UITextView *)textView{
    if(!_textView){
        _textView=[[UITextView alloc]initWithFrame:CGRectZero];
        _textView.layer.cornerRadius=3;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.borderColor = RGBCOLOR(199, 199, 204).CGColor;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.font = [UIFont systemFontOfSize:HeightXiShu(15)];
        _textView.delegate=self;
        _textView.enablesReturnKeyAutomatically = YES;
        
        CGFloat x = WidthXiShu(12);
        CGFloat height = HeightXiShu(35);
        CGFloat y= HeightXiShu(11);
        CGFloat width = kScreenWidth-WidthXiShu(24);
        _textView.frame = CGRectMake(x, y, width, height);
    }
    return _textView;
}

-(UIButton *)sendBtn{
    if(!_sendBtn){
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:RGBCOLOR(124, 124, 124) forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:HeightXiShu(15)];
        [_sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.frame = CGRectMake(kScreenWidth-HeightXiShu(50), 10, HeightXiShu(50), 30);
    }
    return _sendBtn;
}

-(UILabel *)placeLabel{
    if (!_placeLabel) {
        NSString* placeText=[NSString stringWithFormat:@"评论"];
        CGFloat height=CGRectGetHeight(self.textView.frame);
        _placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, height)];
        
        _placeLabel.font=[UIFont systemFontOfSize:HeightXiShu(15)];
        _placeLabel.textColor=RGBCOLOR(179, 179, 179);
        _placeLabel.text=placeText;
        _placeLabel.backgroundColor=[UIColor clearColor];
    }
    return _placeLabel;
}

-(NSInteger)maxTextCount{
    if (_maxTextCount==0) {
        _maxTextCount=30;
    }
    return _maxTextCount;
}

-(NSInteger)maxTextCountInChat{
    if (_maxTextCountInChat==0) {
        _maxTextCountInChat=30;
    }
    return _maxTextCountInChat;
}

-(CGFloat)lastContentSizeHeight{
    if (_lastContentSizeHeight==0) {
        _lastContentSizeHeight=HeightXiShu(33);
    }
    return _lastContentSizeHeight;
}

-(void)textViewDidChange:(UITextView *)textView{
    NSInteger limitNumber=self.maxTextCount;
    NSArray *array = [UITextInputMode activeInputModes];
    if (array.count > 0) {
        UITextInputMode *textInputMode = [array firstObject];
        NSString *lang = [textInputMode primaryLanguage];
        if ([lang isEqualToString:@"zh-Hans"]) {
            if (textView.text.length != 0) {
                UITextRange *selectedRange = [textView markedTextRange];
                //获取高亮部分
                UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
                if (!position) {
                    if (textView.text.length > limitNumber) {
                        textView.text = [textView.text substringToIndex:limitNumber];
                    }
                }else{
                    
                }
            }
        } else {
            if (textView.text.length >= limitNumber) {
                textView.text = [textView.text substringToIndex:limitNumber];
            }
        }
    }
    
    self.placeLabel.alpha=!textView.text.length;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSInteger limitNumber=self.maxTextCountInChat;
    NSLog(@"%d",(int)textView.text.length+(int)text.length);
    if ([text isEqualToString:@"\n"]) {
        if((int)textView.text.length+(int)text.length >limitNumber){
            UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"不能超过%d个字",(int)limitNumber] preferredStyle:UIAlertControllerStyleAlert];
            [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self.window.rootViewController presentViewController:alertControl animated:YES completion:nil];
        }else if ((int)textView.text.length+(int)text.length <3){
            UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"不能少于3个字" preferredStyle:UIAlertControllerStyleAlert];
            [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self.window.rootViewController presentViewController:alertControl animated:YES completion:nil];
        }
        else{
            if ([self.delegate respondsToSelector:@selector(chatToolSendBtnClickedWithContent:)]) {
                [self.delegate chatToolSendBtnClickedWithContent:textView.text];
            }
            textView.text=@"";
            self.placeLabel.text = @"评论";
            [self textViewDidChange:textView];
            [textView resignFirstResponder];
        }
        return NO;
    }else{
        return YES;
    }
}

-(void)sendAction{
    if(![self.textView.text isEqualToString:@""]){
        if ([self.delegate respondsToSelector:@selector(chatToolSendBtnClickedWithContent:)]) {
            [self.delegate chatToolSendBtnClickedWithContent:self.textView.text];
        }
        self.textView.text=@"";
        self.placeLabel.text = @"评论";
        [self textViewDidChange:self.textView];
        [self.textView resignFirstResponder];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object==self.textView) {
        NSLog(@"change==%lf,%lf",self.textView.frame.size.height,self.textView.contentSize.height);
        [self updateFrames];
    }
}

-(void)updateFrames{
    CGFloat orginContentSizeHeight=HeightXiShu(31);
    CGFloat extraContentHeight=self.textView.contentSize.height-self.lastContentSizeHeight;
    if (self.textView.contentSize.height < HeightXiShu(28)) {
        return;
    }
    if (extraContentHeight<=5&&extraContentHeight>=-5) {
        return;
    }else{
        self.lastContentSizeHeight=self.textView.contentSize.height;
    }
    
    CGFloat const lineTextHeight=[UIFont systemFontOfSize:14].lineHeight;
    CGFloat const lineSpaceHeight=4;
    CGFloat const maxSizeHeight=3*lineTextHeight+2*lineSpaceHeight;
    
    CGFloat extraHeight=self.textView.contentSize.height-orginContentSizeHeight;
    
    if (self.textView.contentSize.height>maxSizeHeight) {
        extraHeight=maxSizeHeight-orginContentSizeHeight;
    }
    
    {
        CGFloat leftDownHeight=CGRectGetMaxY(self.frame);
        CGFloat needHeight=HeightXiShu(50)+extraHeight;
        CGRect frame=self.frame;
        frame.origin.y=leftDownHeight-needHeight;
        frame.size.height=needHeight;
        self.frame=frame;
    }
    
    {
        CGFloat needHeight=orginContentSizeHeight+extraHeight;
        CGRect frame=self.textView.frame;
        frame.size.height=needHeight;
        self.textView.frame=frame;
    }
    
    if ([self.delegate respondsToSelector:@selector(chatToolBarSizeChangeWithHeight:)]) {
        [self.delegate chatToolBarSizeChangeWithHeight:CGRectGetHeight(self.frame)];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.bKeyBoardHide = NO;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing");
    self.textView.text=@"";
    self.placeLabel.text = @"评论";
    [self textViewDidChange:self.textView];
    self.bKeyBoardHide = YES;
}

-(void)setPlaceStr:(NSString *)placeStr{
    self.placeLabel.text = placeStr;
}

-(void)dealloc{
    [self.textView removeObserver:self forKeyPath:@"contentSize"];
}
@end
