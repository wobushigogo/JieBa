//
//  RentYzmViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/2.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CreditYzmViewController.h"
#import "NavView.h"
#import "CreditApi.h"
#import "CreditSuccessViewController.h"

@interface CreditYzmViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UIView *yzmView;
@property(nonatomic,strong)UITextField *yzmTextField;
@property(nonatomic,strong)UIButton *yzmBtn;
@end

@implementation CreditYzmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    [self footerView];
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
        navView.titleLabel.text = @"身份验证";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, HeightXiShu(260))];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(32), kScreenWidth, HeightXiShu(20))];
        title.textColor = TitleColor;
        title.font = HEITI(HeightXiShu(15));
        title.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:@"验证码将发送到您的手机"];
        [attStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(0, 3)];
        title.attributedText = attStr;
        [footerView addSubview:title];
        
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(5)+title.maxY, kScreenWidth, HeightXiShu(20))];
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        phoneLabel.font = HEITI(HeightXiShu(15));
        phoneLabel.textColor = TitleColor;
        [footerView addSubview:phoneLabel];
        _phoneLabel = phoneLabel;
        
        [footerView addSubview:self.yzmView];
        
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(WidthXiShu(12), self.yzmView.maxY+HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        [submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        submitBtn.backgroundColor = ButtonColor;
        submitBtn.titleLabel.font = HEITI(HeightXiShu(15));
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:submitBtn];
        
        [self.view addSubview:footerView];
        _footerView = footerView;
    }
    return _footerView;
}

-(UIView *)yzmView{
    if(!_yzmView){
        UIView *yzmView = [[UIView alloc] initWithFrame:CGRectMake(0, self.phoneLabel.maxY+HeightXiShu(18), kScreenWidth, HeightXiShu(50))];
        
        UITextField *yzmTextField = [[UITextField alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, WidthXiShu(200), HeightXiShu(50))];
        yzmTextField.delegate = self;
        yzmTextField.placeholder = @"请输入短信验证码";
        yzmTextField.font = HEITI(HeightXiShu(15));
        yzmTextField.keyboardType = UIKeyboardTypeNumberPad;
        yzmTextField.returnKeyType = UIReturnKeyDone;
        yzmTextField.backgroundColor = [UIColor whiteColor];
        yzmTextField.layer.masksToBounds = YES;
        yzmTextField.layer.cornerRadius = HeightXiShu(5);
        yzmTextField.textAlignment = NSTextAlignmentCenter;
        [yzmTextField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [yzmView addSubview:yzmTextField];
        
        UIButton *yzmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yzmBtn.frame = CGRectMake(yzmTextField.maxX+WidthXiShu(10), 0, WidthXiShu(145), HeightXiShu(50));
        [yzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        yzmBtn.backgroundColor = ButtonColor;
        yzmBtn.titleLabel.font = HEITI(HeightXiShu(15));
        yzmBtn.layer.masksToBounds = YES;
        yzmBtn.layer.cornerRadius = HeightXiShu(5);
        [yzmBtn addTarget:self action:@selector(yzmAction) forControlEvents:UIControlEventTouchUpInside];
        [yzmView addSubview:yzmBtn];
        
        _yzmTextField = yzmTextField;
        _yzmView = yzmView;
    }
    return _yzmView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)yzmAction{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"creditSendSms" forKey:@"type"];
    
    [CreditApi creditYzmWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            [self addAlertView:@"验证码已发送" block:nil];
        }
    } dic:dic noNetWork:nil];
}

-(void)submitAction{
    if([self.yzmTextField.text isEqualToString:@""]){
        [self addAlertView:@"验证码不能为空" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"credit_add" forKey:@"type"];
    [dic setObject:self.money forKey:@"loanmoney"];
    [dic setObject:self.yzmTextField.text forKey:@"sms_code"];
    
    [CreditApi addCreditWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            CreditSuccessViewController *view = [[CreditSuccessViewController alloc] init];
            view.money = self.money;
            [self.navigationController pushViewController:view animated:YES];
        }
    } dic:dic noNetWork:nil];
}

#pragma  mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
