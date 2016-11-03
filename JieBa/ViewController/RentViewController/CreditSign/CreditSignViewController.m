//
//  CreditRepayViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/3.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CreditSignViewController.h"
#import "NavView.h"
#import "AgreeMentViewController.h"
#import "CreditApi.h"

@interface CreditSignViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UIButton *agreeBtn;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UIView *yzmView;
@property(nonatomic,strong)UITextField *yzmTextField;
@property(nonatomic,strong)UIButton *yzmBtn;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic)BOOL isAgree;
@end

@implementation CreditSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAgree = NO;
    [self statusBar];
    [self navView];
    
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = self.footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    CGRect rect = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty =  -rect.size.height;
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.tableView.transform = CGAffineTransformMakeTranslation(0,ty);
    }];
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.tableView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
    title.font = HEITI(HeightXiShu(15));
    title.textColor = ButtonColor;
    title.text = @[@"个人借款协议",@"居间服务协议"][indexPath.row];
    title.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:title];
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(49), kScreenWidth-WidthXiShu(12), .5)];
    cutLine.backgroundColor = AllLightGrayColor;
    [cell.contentView addSubview:cutLine];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AgreeMentViewController *view = [[AgreeMentViewController alloc] init];
    if(indexPath.row == 0){
        view.webUrl = self.urlDic[@"creditagreement"];
    }else{
        view.webUrl = self.urlDic[@"creditagreement2"];
    }
    view.money = self.money;
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"签署合约";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth,self.tableView.height - HeightXiShu(100))];
        
        UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreeBtn.frame = CGRectMake(WidthXiShu(12), HeightXiShu(15), WidthXiShu(21), HeightXiShu(21));
        [agreeBtn setImage:[GetImagePath getImagePath:@"credit_noSelect"] forState:UIControlStateNormal];
        [agreeBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:agreeBtn];
        _agreeBtn = agreeBtn;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(agreeBtn.maxX+WidthXiShu(11), HeightXiShu(15), WidthXiShu(250), HeightXiShu(20))];
        title.text = @"同意贷款相关合同（勾选之后才可签约）";
        title.textColor = MessageColor;
        title.font = HEITI(HeightXiShu(14));
        [footerView addSubview:title];
        
        UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(0, title.maxY+HeightXiShu(100), kScreenWidth, HeightXiShu(20))];
        title2.textColor = TitleColor;
        title2.font = HEITI(HeightXiShu(15));
        title2.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:@"验证码将发送到您的手机"];
        [attStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(0, 3)];
        title2.attributedText = attStr;
        [footerView addSubview:title2];
        
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(5)+title2.maxY, kScreenWidth, HeightXiShu(20))];
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        phoneLabel.font = HEITI(HeightXiShu(15));
        phoneLabel.textColor = TitleColor;
        phoneLabel.text = [[LoginSqlite getdata:@"phone"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        [footerView addSubview:phoneLabel];
        _phoneLabel = phoneLabel;
        
        [footerView addSubview:self.yzmView];
        
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(WidthXiShu(12), self.yzmView.maxY+HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        [submitBtn setTitle:@"签约" forState:UIControlStateNormal];
        submitBtn.backgroundColor = ButtonColor;
        submitBtn.titleLabel.font = HEITI(HeightXiShu(19));
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:submitBtn];
        _submitBtn = submitBtn;
        
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

-(void)agreeAction{
    if(self.isAgree){
        [self.agreeBtn setImage:[GetImagePath getImagePath:@"credit_noSelect"] forState:UIControlStateNormal];
        self.isAgree = NO;
    }else{
        [self.agreeBtn setImage:[GetImagePath getImagePath:@"credit_selected"] forState:UIControlStateNormal];
        self.isAgree = YES;
    }
}

-(void)yzmAction{
    if(!self.isAgree){
        [self addAlertView:@"请同意协议" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"eqian_sms" forKey:@"type"];
    
    [CreditApi creditYzmWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            [self addAlertView:@"验证码已发送" block:nil];
        }
    } dic:dic noNetWork:nil];
}

-(void)submitAction{
    [self.yzmTextField resignFirstResponder];
    if(!self.isAgree){
        [self addAlertView:@"请同意协议" block:nil];
        return;
    }
    
    if([self.yzmTextField.text isEqualToString:@""]){
        [self addAlertView:@"验证码不能为空" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"eqian_submit" forKey:@"type"];
    [dic setObject:self.yzmTextField.text forKey:@"eqian_smscode"];
    self.submitBtn.enabled = NO;
    __block typeof(self)wSelf = self;
    [CreditApi sginCreditWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            [self addAlertView:@"签约成功" block:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil userInfo:nil];
                [wSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }
        self.submitBtn.enabled = YES;
    } dic:dic noNetWork:nil];
}

#pragma  mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
