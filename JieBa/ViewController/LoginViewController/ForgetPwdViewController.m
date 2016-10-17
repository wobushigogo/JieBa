//
//  ForgetPwdViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/15.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "NavView.h"
#import "LoginApi.h"
#import "UpdataPwdViewController.h"

#define placeholderFont HEITI(HeightXiShu(15))
#define titleMargin WidthXiShu(22)
#define titleWidth WidthXiShu(50)

@interface ForgetPwdViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *phoneView;
@property(nonatomic,strong)UIView *yzmView;
@property(nonatomic,strong)UITextField *phoneTextFiled;
@property(nonatomic,strong)UITextField *yzmTextFiled;
@property(nonatomic,strong)UIButton *yzmBtn;
@property(nonatomic,strong)UIButton *nextBtn;
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self contentView];
    [self nextBtn];
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
        navView.titleLabel.text = @"找回密码";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)contentView{
    if(!_contentView){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY+HeightXiShu(10), kScreenWidth, HeightXiShu(100))];
        contentView.backgroundColor = [UIColor whiteColor];
        
        [contentView addSubview:self.phoneView];
        [contentView addSubview:self.yzmView];
        
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

-(UIView *)phoneView{
    if(!_phoneView){
        UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, titleWidth, HeightXiShu(50))];
        title.text = @"手机号";
        title.font = placeholderFont;
        title.textColor = TitleColor;
        [phoneView addSubview:title];
        
        UITextField *phoneTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, phoneView.width-(title.maxX+titleMargin)-WidthXiShu(30), HeightXiShu(50))];
        phoneTextFiled.placeholder = @"请输入手机号";
        phoneTextFiled.font = placeholderFont;
        phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        phoneTextFiled.returnKeyType = UIReturnKeyDone;
        phoneTextFiled.delegate = self;
        [phoneTextFiled setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [phoneView addSubview:phoneTextFiled];
        _phoneTextFiled = phoneTextFiled;
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth-WidthXiShu(10), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [phoneView addSubview:cutLine];
        
        _phoneView = phoneView;
    }
    return _phoneView;
}

-(UIView *)yzmView{
    if(!_yzmView){
        UIView *yzmView = [[UIView alloc] initWithFrame:CGRectMake(0, self.phoneView.maxY, kScreenWidth, HeightXiShu(50))];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, titleWidth, HeightXiShu(50))];
        title.text = @"验证码";
        title.font = placeholderFont;
        title.textColor = TitleColor;
        [yzmView addSubview:title];
        
        UITextField *yzmTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, yzmView.width-(title.maxX+titleMargin)-WidthXiShu(100), HeightXiShu(50))];
        yzmTextFiled.placeholder = @"请输入验证码";
        yzmTextFiled.font = placeholderFont;
        yzmTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        yzmTextFiled.returnKeyType = UIReturnKeyDone;
        yzmTextFiled.delegate = self;
        [yzmTextFiled setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [yzmView addSubview:yzmTextFiled];
        _yzmTextFiled = yzmTextFiled;
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(102), 0, 1, HeightXiShu(50))];
        line.backgroundColor = AllLightGrayColor;
        [yzmView addSubview:line];
        
        UIButton *yzmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yzmBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(103), 0, WidthXiShu(103), HeightXiShu(50));
        [yzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [yzmBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
        yzmBtn.titleLabel.font = placeholderFont;
        [yzmBtn addTarget:self action:@selector(yzmAction) forControlEvents:UIControlEventTouchUpInside];
        [yzmView addSubview:yzmBtn];
        _yzmBtn = yzmBtn;
        
        _yzmView =yzmView;
    }
    return _yzmView;
}

-(UIButton *)nextBtn{
    if(!_nextBtn){
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextBtn.frame = CGRectMake(WidthXiShu(12), self.contentView.maxY+HeightXiShu(20), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        nextBtn.backgroundColor = ButtonColor;
        nextBtn.titleLabel.font = HEITI(HeightXiShu(19));
        [nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.layer.masksToBounds = YES;
        nextBtn.layer.cornerRadius = HeightXiShu(5);
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:nextBtn];
        
        _nextBtn = nextBtn;
    }
    return _nextBtn;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 接口
-(void)yzmAction{
    if([self.phoneTextFiled.text isEqualToString:@""]){
        [self addAlertView:@"手机号不能为空" block:nil];
        return;
    }
    
    if(![StringTool validateMobile:self.phoneTextFiled.text]){
        [self addAlertView:@"请输入正确手机号" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_recoverpwd" forKey:@"_cmd_"];
    [dic setObject:self.phoneTextFiled.text forKey:@"mobile"];
    [dic setObject:@"get_mobileverify" forKey:@"type"];
    
    [LoginApi recoverPwdYZMWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
        
        }
    } dic:dic noNetWork:nil];
}

-(void)nextAction{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_recoverpwd" forKey:@"_cmd_"];
    [dic setObject:self.phoneTextFiled.text forKey:@"mobile"];
    [dic setObject:@"recover" forKey:@"type"];
    [dic setObject:self.yzmTextFiled.text forKey:@"verify_code"];
    
    __block typeof(self)wSelf = self;
    [LoginApi getTokenWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
            UpdataPwdViewController *view = [[UpdataPwdViewController alloc] init];
            view.recover_access_token = dict[@"recover_access_token"];
            view.mobile = wSelf.phoneTextFiled.text;
            [wSelf.navigationController pushViewController:view animated:YES];
        }
    } dic:dic noNetWork:nil];
}

#pragma mark - textFiled delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)dealloc{
    NSLog(@"ForgetPwdViewController dealloc");
}
@end
