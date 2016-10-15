//
//  UpdataPwdViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/15.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "UpdataPwdViewController.h"
#import "NavView.h"
#import "LoginApi.h"

#define placeholderFont HEITI(HeightXiShu(15))
#define titleMargin WidthXiShu(50)

@interface UpdataPwdViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *pwdView;
@property(nonatomic,strong)UIView *pwdAgainView;
@property(nonatomic,strong)UITextField *pwdTextFiled;
@property(nonatomic,strong)UITextField *pwdAgainTextFiled;
@property(nonatomic,strong)UIButton *updataBtn;
@end

@implementation UpdataPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self contentView];
    [self updataBtn];
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
        
        [contentView addSubview:self.pwdView];
        [contentView addSubview:self.pwdAgainView];
        
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

-(UIView *)pwdView{
    if(!_pwdView){
        UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(80), HeightXiShu(50))];
        title.text = @"新 密 码";
        title.font = placeholderFont;
        title.textColor = TextFiledTitleColor;
        [pwdView addSubview:title];
        
        UITextField *pwdTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxY+titleMargin, 0, pwdView.width-(title.maxY+titleMargin)-WidthXiShu(30), HeightXiShu(50))];
        pwdTextFiled.placeholder = @"请输入新密码";
        pwdTextFiled.font = placeholderFont;
        pwdTextFiled.returnKeyType = UIReturnKeyDone;
        pwdTextFiled.secureTextEntry = YES;
        pwdTextFiled.delegate = self;
        [pwdView addSubview:pwdTextFiled];
        _pwdTextFiled = pwdTextFiled;
        
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
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(80), HeightXiShu(50))];
        title.text = @"确认密码";
        title.font = placeholderFont;
        title.textColor = TextFiledTitleColor;
        [pwdAgainView addSubview:title];
        
        UITextField *pwdAgainTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxY+titleMargin, 0, pwdAgainView.width-(title.maxY+titleMargin)-WidthXiShu(30), HeightXiShu(50))];
        pwdAgainTextFiled.placeholder = @"请再次确认密码";
        pwdAgainTextFiled.font = placeholderFont;
        pwdAgainTextFiled.returnKeyType = UIReturnKeyDone;
        pwdAgainTextFiled.secureTextEntry = YES;
        pwdAgainTextFiled.delegate = self;
        [pwdAgainView addSubview:pwdAgainTextFiled];
        _pwdAgainTextFiled = pwdAgainTextFiled;
        
        _pwdAgainView =pwdAgainView;
    }
    return _pwdAgainView;
}

-(UIButton *)updataBtn{
    if(!_updataBtn){
        UIButton *updataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        updataBtn.frame = CGRectMake(WidthXiShu(30), self.contentView.maxY+HeightXiShu(20), kScreenWidth-WidthXiShu(60), HeightXiShu(40));
        updataBtn.backgroundColor = RGBCOLOR(99, 168, 233);
        [updataBtn addTarget:self action:@selector(updataAction) forControlEvents:UIControlEventTouchUpInside];
        updataBtn.layer.masksToBounds = YES;
        updataBtn.layer.cornerRadius = HeightXiShu(5);
        [updataBtn setTitle:@"确认" forState:UIControlStateNormal];
        [updataBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:updataBtn];
        
        _updataBtn = updataBtn;
    }
    return _updataBtn;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 接口
-(void)updataAction{
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
    [dic setObject:@"member_recoverpwd" forKey:@"_cmd_"];
    [dic setObject:self.mobile forKey:@"mobile"];
    [dic setObject:@"recover_submit" forKey:@"type"];
    [dic setObject:self.pwdTextFiled.text forKey:@"setpwd"];
    [dic setObject:self.pwdAgainTextFiled.text forKey:@"resetpwd"];
    [dic setObject:self.recover_access_token forKey:@"recover_access_token"];
    
    __block typeof(self)wSelf = self;
    [LoginApi restPwdWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
            __block typeof(self)otherSelf = wSelf;
            [wSelf addAlertView:@"密码已修改成功，请重新登录" block:^{
                [otherSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }
    } dic:dic noNetWork:nil];
}

-(void)dealloc{
    NSLog(@"UpdataPwdViewController dealloc");
}
@end
