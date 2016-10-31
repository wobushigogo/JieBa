//
//  FeedbackViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/31.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "FeedbackViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"

@interface FeedbackViewController ()<UITextViewDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)UITextView* textView;
@property(nonatomic,strong)UILabel *placeholderLabel;
@property(nonatomic,strong)UIButton *submitBtn;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self textView];
    [self placeholderLabel];
    [self submitBtn];
    [self submitBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"意见反馈";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UITextView *)textView{
    if(!_textView){
         UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(WidthXiShu(12), self.navView.maxY+HeightXiShu(10), kScreenWidth-WidthXiShu(24), HeightXiShu(90))];
        textView.delegate=self;
        textView.backgroundColor=[UIColor whiteColor];
        textView.font=HEITI(HeightXiShu(15));
        textView.textContainerInset = UIEdgeInsetsMake(WidthXiShu(18), HeightXiShu(15), 0, 0);
        [textView becomeFirstResponder];
        [self.view addSubview:textView];
        _textView = textView;
    }
    return _textView;
}

-(UILabel *)placeholderLabel{
    if(!_placeholderLabel){
        UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(19), HeightXiShu(12), self.textView.width-WidthXiShu(38), HeightXiShu(40))];
        placeholderLabel.text = @"请留下您的宝贵意见和建议，我们将努力改进(不少于五个字)";
        placeholderLabel.textColor = PlaceholderColor;
        placeholderLabel.font = HEITI(HeightXiShu(13));
        placeholderLabel.numberOfLines = 2;
        [self.textView addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

-(UIButton *)submitBtn{
    if(!_submitBtn){
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(WidthXiShu(12), self.textView.maxY+HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        [submitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
        submitBtn.backgroundColor = ButtonColor;
        submitBtn.titleLabel.font = HEITI(HeightXiShu(19));
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
        _submitBtn = submitBtn;
    }
    return _submitBtn;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - textView delegate
-(void)textViewDidChange:(UITextView *)textView{
//    NSArray *array = [UITextInputMode activeInputModes];
//    if (array.count > 0) {
//        UITextInputMode *textInputMode = [array firstObject];
//        NSString *lang = [textInputMode primaryLanguage];
//        if ([lang isEqualToString:@"zh-Hans"]) {
//            if (textView.text.length != 0) {
//                UITextRange *selectedRange = [textView markedTextRange];
//                //获取高亮部分
//                UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
//                if (!position) {
//                    if (textView.text.length > kCommentLimitNumber) {
//                        textView.text = [textView.text substringToIndex:kCommentLimitNumber];
//                    }
//                }else{
//                    
//                }
//            }
//        } else {
//            if (textView.text.length >= kCommentLimitNumber) {
//                textView.text = [textView.text substringToIndex:kCommentLimitNumber];
//            }
//        }
//    }
    
    self.placeholderLabel.alpha=!self.textView.text.length;
}

-(void)submitAction{
    NSString *str = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!str.length) {
        [self addAlertView:@"请填写反馈内容" block:nil];
        return;
    }
    
    if (str.length < 5) {
        [self addAlertView:@"内容不能少于5个字" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"view" forKey:@"_cmd_"];
    [dic setObject:@"view_add" forKey:@"type"];
    [dic setObject:str forKey:@"content"];
    self.submitBtn.enabled=NO;
    [MyCenterApi feedBackWithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            self.submitBtn.enabled=YES;
        }
    } dic:dic noNetWork:nil];
}
@end
