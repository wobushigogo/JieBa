//
//  RechargeViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/25.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RechargeViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"
#import "AddCashViewController.h"

@interface RechargeViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *moneyView;
@property(nonatomic,strong)UITextField *moneyTextFiled;
@property(nonatomic,strong)UIButton *submitBtn;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self moneyView];
    [self submitBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"充值";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)moneyView{
    if(!_moneyView){
        UIView *moneyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY+HeightXiShu(10), kScreenWidth, HeightXiShu(50))];
        moneyView.backgroundColor = [UIColor whiteColor];
        UITextField *moneyTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
        moneyTextFiled.placeholder = @"请输入金额";
        moneyTextFiled.textAlignment = NSTextAlignmentCenter;
        moneyTextFiled.font = HEITI(HeightXiShu(15));
        moneyTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        moneyTextFiled.returnKeyType = UIReturnKeyDone;
        moneyTextFiled.delegate = self;
        [moneyTextFiled setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [moneyView addSubview:moneyTextFiled];
        _moneyTextFiled = moneyTextFiled;
        
        [self.view addSubview:moneyView];
        _moneyView = moneyView;
    }
    return _moneyView;
}

-(UIButton *)submitBtn{
    if(!_submitBtn){
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(WidthXiShu(12), self.moneyView.maxY+HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        submitBtn.backgroundColor = ButtonColor;
        submitBtn.titleLabel.font = HEITI(HeightXiShu(19));
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn setTitle:@"确认充值" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:submitBtn];
        
        _submitBtn = submitBtn;
    }
    return _submitBtn;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitAction{
    [self.moneyTextFiled resignFirstResponder];
    if([self.moneyTextFiled.text isEqualToString:@""]){
        [self addAlertView:@"金额不能为空" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"cash" forKey:@"_cmd_"];
    [dic setObject:self.moneyTextFiled.text forKey:@"money"];
    [dic setObject:@"cash_in" forKey:@"type"];
    
    [MyCenterApi addCashWithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            AddCashViewController *view = [[AddCashViewController alloc] init];
            view.webUrl = dict[@"jumpurl"];
            view.dic = dict;
            [self.navigationController pushViewController:view animated:YES];
        }
    } dic:dic noNetWork:nil];
}

#pragma mark - textFiled delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
