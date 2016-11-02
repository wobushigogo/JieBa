//
//  FuiouInfoViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/2.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "FuiouInfoViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"
#import "CreditApi.h"

@interface FuiouInfoViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)NSMutableArray *contentArr;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UIView *yzmView;
@property(nonatomic,strong)UITextField *yzmTextField;
@property(nonatomic,strong)UIButton *yzmBtn;
@property(nonatomic,strong)NSString *phoneStr;
@property(nonatomic,strong)NSString *login_id;
@end

@implementation FuiouInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *arr = @[@[@"",@""],@[@"",@"",@""]];
    self.contentArr = [NSMutableArray arrayWithArray:arr];
    [self statusBar];
    [self navView];
    
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = self.footerView;
    
    [self loadInfo];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }else{
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }
    return HeightXiShu(10);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSString *titleStr = @[@[@"姓       名",@"身份证号"],@[@"开户银行",@"开户支行",@"银行卡号"]][indexPath.section][indexPath.row];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, WidthXiShu(80), HeightXiShu(50))];
    title.font = HEITI(HeightXiShu(15));
    title.textColor = TitleColor;
    title.text = titleStr;
    [cell.contentView addSubview:title];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(title.maxX+WidthXiShu(22), 0, WidthXiShu(180), HeightXiShu(50))];
    content.text = self.contentArr[indexPath.section][indexPath.row];
    content.font = HEITI(HeightXiShu(15));
    content.textColor = MessageColor;
    [cell.contentView addSubview:content];
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(49), kScreenWidth-WidthXiShu(12), .5)];
    cutLine.backgroundColor = AllLightGrayColor;
    [cell.contentView addSubview:cutLine];
    return cell;
}
#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"金账户详情";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.tableView.height-HeightXiShu(260))];
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
        [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        submitBtn.backgroundColor = ButtonColor;
        submitBtn.titleLabel.font = HEITI(HeightXiShu(15));
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:submitBtn];
        
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
    [dic setObject:@"bindFuyouSms" forKey:@"type"];
    [dic setObject:self.phoneStr forKey:@"mobile"];
    
    [CreditApi fuiouYzmWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            [self addAlertView:@"验证码已发送" block:nil];
        }
    } dic:dic noNetWork:nil];
}

-(void)submitAction{
    [self.yzmTextField resignFirstResponder];
    [self bindFuiou];
}

#pragma  mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 接口
-(void)loadInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"fuyou_info" forKey:@"type"];
    
    [MyCenterApi getFuyouInfoWithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            NSArray *arr1 = [[NSArray alloc] initWithObjects:dict[@"cust_nm"],dict[@"certif_id"], nil];
            NSArray *arr2 = [[NSArray alloc] initWithObjects:dict[@"bank_name"],dict[@"bank_nm"],dict[@"capAcntNo"], nil];
            [self.contentArr replaceObjectAtIndex:0 withObject:arr1];
            [self.contentArr replaceObjectAtIndex:1 withObject:arr2];
            [self.tableView reloadData];
            self.phoneStr = dict[@"mobile_no"];
            self.login_id = dict[@"login_id"];
            self.phoneLabel.text = [dict[@"mobile_no"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
    } dic:dic noNetWork:nil];
}

-(void)bindFuiou{
    if([self.yzmTextField.text isEqualToString:@""]){
        [self addAlertView:@"验证码不能为空" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"bindFuyou" forKey:@"type"];
    [dic setObject:self.yzmTextField.text forKey:@"sms_code"];
    [dic setObject:self.phoneStr forKey:@"mobile"];
    [dic setObject:self.login_id forKey:@"fuyou_login_id"];
    
    __block typeof(self)wSelf = self;
    [CreditApi bindFuiouWithBlock:^(NSString *message, NSError *error) {
        if(!error){
            [self addAlertView:@"绑定成功" block:^{
                [wSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }
    } dic:dic noNetWork:nil];
}
@end
