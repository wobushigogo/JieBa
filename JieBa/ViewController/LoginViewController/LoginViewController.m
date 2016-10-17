//
//  LoginViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "LoginViewController.h"
#import "NavView.h"
#import "InputTextFiledView.h"
#import "LoginApi.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIImageView *bgImgView;
@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)InputTextFiledView *phoneInputView;
@property(nonatomic,strong)InputTextFiledView *pwdInputView;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIButton *forgetBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bgImgView];
    [self navView];
    [self iconImgView];
    [self phoneInputView];
    [self pwdInputView];
    [self loginBtn];
    [self registerBtn];
    [self forgetBtn];
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
        navView.backgroundColor = [UIColor clearColor];
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        bgImgView.image = [GetImagePath getImagePath:@"login_bg"];
        [self.view addSubview:bgImgView];
        
        _bgImgView = bgImgView;
    }
    return _bgImgView;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-WidthXiShu(82))/2, HeightXiShu(70), WidthXiShu(82), HeightXiShu(64))];
        iconImgView.image = [GetImagePath getImagePath:@"login_TM"];
        [self.view addSubview:iconImgView];
        
        _iconImgView = iconImgView;
    }
    return _iconImgView;
}

-(InputTextFiledView *)phoneInputView{
    if(!_phoneInputView){
        InputTextFiledView *phoneInputView = [[InputTextFiledView alloc] initWithFrame:CGRectMake(WidthXiShu(32), self.iconImgView.maxY+HeightXiShu(30), kScreenWidth-WidthXiShu(64), HeightXiShu(50))];
        phoneInputView.placeholder = @"请输入手机号";
        phoneInputView.placeholderColor = [UIColor whiteColor];
        phoneInputView.textFiledMargin = WidthXiShu(41);
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WidthXiShu(31), HeightXiShu(41))];
        leftView.image = [GetImagePath getImagePath:@"login_phone"];
        phoneInputView.leftView = leftView;
        phoneInputView.textWidth = phoneInputView.width - WidthXiShu(55);
        phoneInputView.textField.returnKeyType = UIReturnKeyDone;
        phoneInputView.textField.keyboardType = UIKeyboardTypeNumberPad;
        phoneInputView.textField.delegate = self;
        [self.view addSubview:phoneInputView];
        _phoneInputView = phoneInputView;
    }
    return _phoneInputView;
}

-(InputTextFiledView *)pwdInputView{
    if(!_pwdInputView){
        InputTextFiledView *pwdInputView = [[InputTextFiledView alloc] initWithFrame:CGRectMake(WidthXiShu(32), self.phoneInputView.maxY+HeightXiShu(30), kScreenWidth-WidthXiShu(64), HeightXiShu(50))];
        pwdInputView.placeholder = @"请输入密码";
        pwdInputView.placeholderColor = [UIColor whiteColor];
        pwdInputView.textFiledMargin = WidthXiShu(41);
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WidthXiShu(31), HeightXiShu(41))];
        leftView.image = [GetImagePath getImagePath:@"login_pwd"];
        pwdInputView.leftView = leftView;
        pwdInputView.textWidth = pwdInputView.width - WidthXiShu(55);
        pwdInputView.textField.returnKeyType = UIReturnKeyDone;
        pwdInputView.textField.secureTextEntry = YES;
        pwdInputView.textField.delegate = self;
        [self.view addSubview:pwdInputView];
        _pwdInputView = pwdInputView;
    }
    return _pwdInputView;
}

-(UIButton *)loginBtn{
    if(!_loginBtn){
         UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame = CGRectMake(WidthXiShu(12), self.pwdInputView.maxY+HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        loginBtn.backgroundColor = ButtonColor;
        loginBtn.titleLabel.font = HEITI(HeightXiShu(19));
        [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.cornerRadius = HeightXiShu(5);
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:loginBtn];
        
        _loginBtn = loginBtn;
    }
    return _loginBtn;
}

-(UIButton *)registerBtn{
    if(!_registerBtn){
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(WidthXiShu(12), self.loginBtn.maxY+HeightXiShu(20), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        registerBtn.backgroundColor = [UIColor whiteColor];
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        registerBtn.titleLabel.font = HEITI(HeightXiShu(19));
        [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        registerBtn.layer.masksToBounds = YES;
        registerBtn.layer.cornerRadius = HeightXiShu(5);
        [self.view addSubview:registerBtn];
        
        _registerBtn = registerBtn;
    }
    return _registerBtn;
}

-(UIButton *)forgetBtn{
    if(!_forgetBtn){
        UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forgetBtn.frame = CGRectMake(kScreenWidth - WidthXiShu(12)-WidthXiShu(80), self.registerBtn.maxY+HeightXiShu(10), WidthXiShu(80), HeightXiShu(30));
        [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [forgetBtn setTitleColor:RGBCOLOR(84, 149, 230) forState:UIControlStateNormal];
        forgetBtn.titleLabel.font = HEITI(HeightXiShu(13));
        forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [forgetBtn addTarget:self action:@selector(gotoForgetPwd) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forgetBtn];
        _forgetBtn = forgetBtn;
    }
    return _forgetBtn;
}

#pragma mark - 事件
-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loginAction{
    [self.phoneInputView.textField resignFirstResponder];
    [self.pwdInputView.textField resignFirstResponder];
    [self login];
}

-(void)registerAction{
    RegisterViewController *view = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)gotoForgetPwd{
    ForgetPwdViewController *view = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - textFiled delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.phoneInputView.textField resignFirstResponder];
    [self.pwdInputView.textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"===>%@",self.phoneInputView.textField.text);
    NSLog(@"===>%@",self.pwdInputView.textField.text);
}

#pragma mark - 接口
-(void)login{
    if([self.phoneInputView.textField.text isEqualToString:@""]){
        [self addAlertView:@"手机号不能为空" block:nil];
        return;
    }
    
    if(![StringTool validateMobile:self.phoneInputView.textField.text]){
        [self addAlertView:@"请输入正确手机号" block:nil];
        return;
    }
    
    if([self.pwdInputView.textField.text isEqualToString:@""]){
        [self addAlertView:@"密码不能为空" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_login" forKey:@"_cmd_"];
    [dic setObject:self.phoneInputView.textField.text forKey:@"mobile"];
    [dic setObject:self.pwdInputView.textField.text forKey:@"password"];
    
    __block typeof(self)wSelf = self;
    [LoginApi loginWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
            [self addAlertView:@"登录成功" block:^{
                __block typeof(self)otherSelf = wSelf;
                [otherSelf dismissViewControllerAnimated:YES completion:nil];
            }];
        }
    } dic:dic noNetWork:nil];
}

-(void)dealloc{
    NSLog(@"LoginViewController dealloc");
}
@end
