//
//  RegisterViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RegisterViewController.h"
#import "NavView.h"
#import "LoginApi.h"

#define placeholderFont HEITI(HeightXiShu(15))
#define titleMargin WidthXiShu(22)
#define titleWidth WidthXiShu(60)

@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *phoneView;
@property(nonatomic,strong)UIView *yzmView;
@property(nonatomic,strong)UIView *pwdView;
@property(nonatomic,strong)UIView *pwdAgainView;
@property(nonatomic,strong)UIView *recommendView;
@property(nonatomic,strong)UITextField *phoneTextFiled;
@property(nonatomic,strong)UITextField *yzmTextFiled;
@property(nonatomic,strong)UITextField *pwdTextFiled;
@property(nonatomic,strong)UITextField *pwdAgainTextFiled;
@property(nonatomic,strong)UITextField *recommendTextFiled;
@property(nonatomic,strong)UIButton *yzmBtn;
@property(nonatomic,strong)UIButton *showPwdBtn;
@property(nonatomic,strong)UIButton *agreeBtn;
@property(nonatomic,strong)UIButton *agreementBtn;
@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,assign)BOOL isShowPwd;
@property(nonatomic,assign)BOOL isAgree;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isShowPwd = NO;
    self.isAgree = YES;
    [self statusBar];
    [self navView];
    [self contentView];
    [self agreeBtn];
    [self titleLabel];
    [self agreementBtn];
    [self registerBtn];
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
        navView.titleLabel.text = @"注册";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)contentView{
    if(!_contentView){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY+HeightXiShu(10), kScreenWidth, HeightXiShu(250))];
        contentView.backgroundColor = [UIColor whiteColor];
        
        [contentView addSubview:self.phoneView];
        [contentView addSubview:self.yzmView];
        [contentView addSubview:self.pwdView];
        [contentView addSubview:self.pwdAgainView];
        [contentView addSubview:self.recommendView];

        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

-(UIView *)phoneView{
    if(!_phoneView){
        UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, titleWidth, HeightXiShu(50))];
        title.text = @"手 机 号";
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
        title.text = @"验 证 码";
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
        [yzmBtn setTitleColor:RGBCOLOR(99, 168, 233) forState:UIControlStateNormal];
        yzmBtn.titleLabel.font = placeholderFont;
        [yzmBtn addTarget:self action:@selector(yzmAction) forControlEvents:UIControlEventTouchUpInside];
        [yzmView addSubview:yzmBtn];
        _yzmBtn = yzmBtn;
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth-WidthXiShu(10), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [yzmView addSubview:cutLine];
        
        _yzmView =yzmView;
    }
    return _yzmView;
}

-(UIView *)pwdView{
    if(!_pwdView){
        UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(0, self.yzmView.maxY, kScreenWidth, HeightXiShu(50))];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, titleWidth, HeightXiShu(50))];
        title.text = @"密     码";
        title.font = placeholderFont;
        title.textColor = TitleColor;
        [pwdView addSubview:title];
        
        UITextField *pwdTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, pwdView.width-(title.maxX+titleMargin)-WidthXiShu(30), HeightXiShu(50))];
        pwdTextFiled.placeholder = @"6-10位字母，数字结合";
        pwdTextFiled.font = placeholderFont;
        pwdTextFiled.returnKeyType = UIReturnKeyDone;
        pwdTextFiled.secureTextEntry = YES;
        pwdTextFiled.delegate = self;
        [pwdTextFiled setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [pwdView addSubview:pwdTextFiled];
        _pwdTextFiled = pwdTextFiled;
        
        UIButton *showPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        showPwdBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(28)-WidthXiShu(10), HeightXiShu(11), WidthXiShu(28), HeightXiShu(28));
        [showPwdBtn setImage:[GetImagePath getImagePath:@"register_show"] forState:UIControlStateNormal];
        [showPwdBtn addTarget:self action:@selector(showPwd) forControlEvents:UIControlEventTouchUpInside];
        [pwdView addSubview:showPwdBtn];
        _showPwdBtn = showPwdBtn;
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth-WidthXiShu(10), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [pwdView addSubview:cutLine];
        
        _pwdView =pwdView;
    }
    return _pwdView;
}

-(UIView *)pwdAgainView{
    if(!_pwdAgainView){
        UIView *pwdAgainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.pwdView.maxY, kScreenWidth, HeightXiShu(50))];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, titleWidth, HeightXiShu(50))];
        title.text = @"确认密码";
        title.font = placeholderFont;
        title.textColor = TitleColor;
        [pwdAgainView addSubview:title];
        
        UITextField *pwdAgainTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, pwdAgainView.width-(title.maxX+titleMargin)-WidthXiShu(30), HeightXiShu(50))];
        pwdAgainTextFiled.placeholder = @"请再次确认密码";
        pwdAgainTextFiled.font = placeholderFont;
        pwdAgainTextFiled.returnKeyType = UIReturnKeyDone;
        pwdAgainTextFiled.secureTextEntry = YES;
        pwdAgainTextFiled.delegate = self;
        [pwdAgainTextFiled setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [pwdAgainView addSubview:pwdAgainTextFiled];
        _pwdAgainTextFiled = pwdAgainTextFiled;
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth-WidthXiShu(10), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [pwdAgainView addSubview:cutLine];
        
        _pwdAgainView =pwdAgainView;
    }
    return _pwdAgainView;
}

-(UIView *)recommendView{
    if(!_recommendView){
        UIView *recommendView = [[UIView alloc] initWithFrame:CGRectMake(0, self.pwdAgainView.maxY, kScreenWidth, HeightXiShu(50))];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, titleWidth, HeightXiShu(50))];
        title.text = @"好友推荐";
        title.font = placeholderFont;
        title.textColor = TitleColor;
        [recommendView addSubview:title];
        
        UITextField *recommendTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, recommendView.width-(title.maxX+titleMargin)-WidthXiShu(30), HeightXiShu(50))];
        recommendTextFiled.placeholder = @"好友手机号";
        recommendTextFiled.font = placeholderFont;
        recommendTextFiled.returnKeyType = UIReturnKeyDone;
        recommendTextFiled.secureTextEntry = YES;
        recommendTextFiled.delegate = self;
        [recommendTextFiled setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [recommendView addSubview:recommendTextFiled];
        _recommendTextFiled = recommendTextFiled;
        
        _recommendView =recommendView;
    }
    return _recommendView;
}

-(UIButton *)agreeBtn{
    if(!_agreeBtn){
        UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreeBtn.frame = CGRectMake(WidthXiShu(12), self.contentView.maxY+HeightXiShu(10), WidthXiShu(20), HeightXiShu(20));
        [agreeBtn setImage:[GetImagePath getImagePath:@"register_select"] forState:UIControlStateNormal];
        [agreeBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:agreeBtn];
        
        _agreeBtn = agreeBtn;
    }
    return _agreeBtn;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.agreeBtn.maxX+WidthXiShu(5), self.contentView.maxY+HeightXiShu(10), WidthXiShu(100), HeightXiShu(20))];
        titleLabel.text = @"已经同意并阅读";
        titleLabel.font = HEITI(HeightXiShu(13));
        [self.view addSubview:titleLabel];
        
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UIButton *)agreementBtn{
    if(!_agreementBtn){
        UIButton *agreementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreementBtn.frame = CGRectMake(self.titleLabel.maxX, self.contentView.maxY+HeightXiShu(10), WidthXiShu(150), HeightXiShu(20));
        [agreementBtn setTitle:@"《车生活用户协议》" forState:UIControlStateNormal];
        [agreementBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
        agreementBtn.titleLabel.font = HEITI(HeightXiShu(13));
        agreementBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.view addSubview:agreementBtn];
        
        _agreementBtn = agreementBtn;
    }
    return _agreementBtn;
}

-(UIButton *)registerBtn{
    if(!_registerBtn){
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(WidthXiShu(12), self.agreementBtn.maxY+HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        registerBtn.backgroundColor = ButtonColor;
        registerBtn.titleLabel.font = HEITI(HeightXiShu(19));
        [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        registerBtn.layer.masksToBounds = YES;
        registerBtn.layer.cornerRadius = HeightXiShu(5);
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:registerBtn];
        
        _registerBtn = registerBtn;
    }
    return _registerBtn;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showPwd{
    if(self.isShowPwd){
        self.pwdTextFiled.secureTextEntry = YES;
        self.isShowPwd = NO;
        [self.showPwdBtn setImage:[GetImagePath getImagePath:@"register_show"] forState:UIControlStateNormal];
    }else{
        self.pwdTextFiled.secureTextEntry = NO;
        self.isShowPwd = YES;
        [self.showPwdBtn setImage:[GetImagePath getImagePath:@"register_noShow"] forState:UIControlStateNormal];
    }
}

-(void)agreeAction{
    if(self.isAgree){
        [self.agreeBtn setImage:[GetImagePath getImagePath:@"register_noSelect"] forState:UIControlStateNormal];
        self.isAgree = NO;
    }else{
        [self.agreeBtn setImage:[GetImagePath getImagePath:@"register_select"] forState:UIControlStateNormal];
        self.isAgree = YES;
    }
}

#pragma mark - 接口
-(void)registerAction{
    if(!self.isAgree){
        [self addAlertView:@"请同意条款" block:nil];
        return;
    }
    
    if([self.phoneTextFiled.text isEqualToString:@""]){
        [self addAlertView:@"手机号不能为空" block:nil];
        return;
    }
    
    if(![StringTool validateMobile:self.phoneTextFiled.text]){
        [self addAlertView:@"请输入正确手机号" block:nil];
        return;
    }
    
    if([self.yzmTextFiled.text isEqualToString:@""]){
        [self addAlertView:@"验证码不能为空" block:nil];
        return;
    }
    
    if([self.pwdTextFiled.text isEqualToString:@""]){
        [self addAlertView:@"密码不能为空" block:nil];
        return;
    }
    
    if([self.pwdAgainTextFiled.text isEqualToString:@""]){
        [self addAlertView:@"请确认密码" block:nil];
        return;
    }
    
    if(![self.pwdAgainTextFiled.text isEqualToString:self.pwdTextFiled.text]){
        [self addAlertView:@"两次密码不一致" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_register" forKey:@"_cmd_"];
    [dic setObject:self.phoneTextFiled.text forKey:@"mobile"];
    [dic setObject:@"reg" forKey:@"type"];
    [dic setObject:self.pwdTextFiled.text forKey:@"password"];
    [dic setObject:self.pwdAgainTextFiled.text forKey:@"re_password"];
    [dic setObject:self.yzmTextFiled.text forKey:@"verify_code"];
    [dic setObject:self.recommendTextFiled.text forKey:@"recintcode"];
    
    __block typeof(self)wSelf = self;
    [LoginApi registerWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
            [self addAlertView:@"注册成功" block:^{
                if(wSelf.backBlock){
                    wSelf.backBlock();
                }
                [wSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    } dic:dic noNetWork:nil];
}

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
    [dic setObject:@"member_register" forKey:@"_cmd_"];
    [dic setObject:self.phoneTextFiled.text forKey:@"mobile"];
    [dic setObject:@"get_mobileverify" forKey:@"type"];

    [LoginApi getYZMWithBlock:^(NSString *yzmCode, NSError *error) {
        if(!error){
            [self addAlertView:@"验证码已发送" block:nil];
        }
    } dic:dic noNetWork:nil];
}

#pragma mark - textFiled delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)dealloc{
    NSLog(@"RegisterViewController dealloc");
}
@end
