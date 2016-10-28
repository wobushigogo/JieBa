//
//  WithdrawViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/28.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "WithdrawViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"
#import "WithdrawCashViewController.h"

@interface WithdrawViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UILabel *backLabel;
@property(nonatomic,strong)UILabel *balanceLabel;
@property(nonatomic,strong)NSString *backName;
@property(nonatomic,strong)UITextField *moneyTextField;
@property(nonatomic,strong)UIButton *allSubmitBtn;
@property(nonatomic,strong)UILabel *arriveLabel;
@property(nonatomic,strong)UILabel *arriveMoneyLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self contentView];
    [self moneyTextField];
    [self detailLabel];
    [self allSubmitBtn];
    [self arriveLabel];
    [self arriveMoneyLabel];
    [self submitBtn];
    [self scrollView];
    [self loadInfo];
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
        navView.titleLabel.text = @"提现";
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
        
        UILabel *backTitle = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, WidthXiShu(100), HeightXiShu(50))];
        backTitle.text = @"提现银行卡";
        backTitle.textColor = TitleColor;
        backTitle.font = HEITI(HeightXiShu(15));
        [contentView addSubview:backTitle];
        
        UILabel *balanceTitle = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(50), kScreenWidth, HeightXiShu(50))];
        balanceTitle.text = @"可提现金额（元）";
        balanceTitle.textColor = TitleColor;
        balanceTitle.font = HEITI(HeightXiShu(15));
        [contentView addSubview:balanceTitle];
        
        UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(200), 0, WidthXiShu(200), HeightXiShu(50))];
        backLabel.textAlignment = NSTextAlignmentRight;
        backLabel.textColor = TitleColor;
        backLabel.font = HEITI(HeightXiShu(15));
        [contentView addSubview:backLabel];
        
        UILabel *balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(200), HeightXiShu(50), WidthXiShu(200), HeightXiShu(50))];
        balanceLabel.textAlignment = NSTextAlignmentRight;
        balanceLabel.textColor = ButtonColor;
        balanceLabel.font = HEITI(HeightXiShu(15));
        balanceLabel.text = self.balance;
        [contentView addSubview:balanceLabel];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(50), kScreenWidth, .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [contentView addSubview:cutLine];
        
        [self.view addSubview:contentView];
        _backLabel = backLabel;
        _balanceLabel = balanceLabel;
        _contentView = contentView;
    }
    return _contentView;
}

-(UITextField *)moneyTextField{
    if(!_moneyTextField){
        UITextField *moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(WidthXiShu(12), self.contentView.maxY+HeightXiShu(30), WidthXiShu(240), HeightXiShu(50))];
        moneyTextField.placeholder = @"请输入提现金额";
        moneyTextField.font = HEITI(HeightXiShu(15));
        moneyTextField.textColor = TitleColor;
        moneyTextField.backgroundColor = [UIColor whiteColor];
        moneyTextField.layer.masksToBounds = YES;
        moneyTextField.layer.cornerRadius = HeightXiShu(8);
        moneyTextField.delegate = self;
        moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
        moneyTextField.returnKeyType = UIReturnKeyDone;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthXiShu(10), HeightXiShu(50))];
        moneyTextField.leftView = leftView;
        moneyTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [self.view addSubview:moneyTextField];
        
        _moneyTextField = moneyTextField;
    }
    return _moneyTextField;
}

-(UILabel *)detailLabel{
    if(!_detailLabel){
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyTextField.maxX + WidthXiShu(8), self.contentView.maxY+HeightXiShu(30), WidthXiShu(15), HeightXiShu(50))];
        detailLabel.text = @"元";
        detailLabel.textColor = TitleColor;
        detailLabel.font = HEITI(HeightXiShu(15));
        [self.view addSubview:detailLabel];
        _detailLabel = detailLabel;
    }
    return _detailLabel;
}

-(UIButton *)allSubmitBtn{
    if(!_allSubmitBtn){
        UIButton *allSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        allSubmitBtn.frame = CGRectMake(self.detailLabel.maxX + WidthXiShu(20), self.contentView.maxY+HeightXiShu(41), WidthXiShu(67), HeightXiShu(22.5));
        allSubmitBtn.backgroundColor = ButtonColor;
        [allSubmitBtn setTitle:@"全提" forState:UIControlStateNormal];
        allSubmitBtn.titleLabel.font = HEITI(HeightXiShu(14));
        allSubmitBtn.layer.masksToBounds = YES;
        allSubmitBtn.layer.cornerRadius = HeightXiShu(8);
        [allSubmitBtn addTarget:self action:@selector(allWithdrawACtion) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:allSubmitBtn];
        _allSubmitBtn = allSubmitBtn;
    }
    return _allSubmitBtn;
}

-(UILabel *)arriveLabel{
    if(!_arriveLabel){
        UILabel *arriveLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), self.moneyTextField.maxY+HeightXiShu(30), WidthXiShu(100), HeightXiShu(20))];
        arriveLabel.text = @"实际到账金额：";
        arriveLabel.textColor = MessageColor;
        arriveLabel.font = HEITI(HeightXiShu(14));
        [self.view addSubview:arriveLabel];
        _arriveLabel = arriveLabel;
    }
    return _arriveLabel;
}

-(UILabel *)arriveMoneyLabel{
    if(!_arriveMoneyLabel){
        UILabel *arriveMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(200), self.moneyTextField.maxY+HeightXiShu(30), WidthXiShu(200), HeightXiShu(20))];
        arriveMoneyLabel.text = @"";
        arriveMoneyLabel.textColor = MessageColor;
        arriveMoneyLabel.font = HEITI(HeightXiShu(14));
        arriveMoneyLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:arriveMoneyLabel];
        _arriveMoneyLabel = arriveMoneyLabel;
    }
    return _arriveMoneyLabel;
}

-(UIButton *)submitBtn{
    if(!_submitBtn){
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(WidthXiShu(12), self.arriveLabel.maxY+HeightXiShu(30), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        submitBtn.backgroundColor = ButtonColor;
        [submitBtn setTitle:@"确认提现" forState:UIControlStateNormal];
        submitBtn.titleLabel.font = HEITI(HeightXiShu(14));
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn addTarget:self action:@selector(submitACtion) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
        _submitBtn = submitBtn;
    }
    return _submitBtn;
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(WidthXiShu(12), self.submitBtn.maxY+HeightXiShu(15), kScreenWidth-WidthXiShu(24), kScreenHeight-(self.submitBtn.maxY+HeightXiShu(15)))];
        scrollView.backgroundColor = [UIColor whiteColor];
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(7), scrollView.width-WidthXiShu(24), kScreenHeight-(self.submitBtn.maxY+HeightXiShu(15))-HeightXiShu(14))];
        message.textColor = TitleColor;
        message.font = HEITI(HeightXiShu(16));
        message.numberOfLines = 20;
        message.text = @"温馨提示：\n1. 提现资金均在个人存管账户中进行，如有疑问请致电富友客服95138，或微信搜索富友金账户客服；\n2. 在发起提现后，提现到账时间预计为2小时到账（取决于入账银行的处理时间）请您注意查收。\n3. 由于第三方支付公司限制，每笔取现限额为100万元，当日无限额;\n4. 为正常使用快速提现功能，请先前往第三方支付平台点击“系统管理”，授权管理”勾选“委托提现”后启用委托提现服务；\n5. 禁利用借吧进行套现、洗钱、匿名转账，对于频繁的非正常投资为目的的资金充提行为，一经发现，借吧将通过原充值渠道进行资金清退，已收取手续费将不予返还。\n6.富友存管账户常见问题。";
        [message sizeToFit];
        [scrollView addSubview:message];
        
        scrollView.contentSize = CGSizeMake(scrollView.width-WidthXiShu(24), HeightXiShu(300));
        
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)allWithdrawACtion{
    self.moneyTextField.text = self.balance;
    self.arriveMoneyLabel.text = [NSString stringWithFormat:@"%@元",self.balance];
}

#pragma mark - setter
-(void)setBackName:(NSString *)backName{
    _backName = backName;
    self.backLabel.text = backName;
}

-(void)setBalance:(NSString *)balance{
    _balance = balance;
    self.balanceLabel.text = balance;
}

#pragma mark - textFiled delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.arriveMoneyLabel.text = [NSString stringWithFormat:@"%@元",textField.text];
}

-(void)submitACtion{
    [self.moneyTextField resignFirstResponder];
    if([self.moneyTextField.text isEqualToString:@""]){
        [self addAlertView:@"金额不能为空" block:nil];
        return;
    }
    
    if([self.moneyTextField.text floatValue] < 2){
        [self addAlertView:@"金额不能小于2元" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"cash" forKey:@"_cmd_"];
    [dic setObject:self.moneyTextField.text forKey:@"money"];
    [dic setObject:@"cash_out" forKey:@"type"];
    
    [MyCenterApi withdrawCashWithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            WithdrawCashViewController *view = [[WithdrawCashViewController alloc] init];
            view.webUrl = dict[@"jumpurl"];
            [self.navigationController pushViewController:view animated:YES];
        }
    } dic:dic noNetWork:nil];
}

#pragma mark - 接口
-(void)loadInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"fuyou_info" forKey:@"type"];
    
    [MyCenterApi getFuyouInfoWithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            self.backName = dict[@"bank_name"];
        }
    } dic:dic noNetWork:nil];
}
@end
