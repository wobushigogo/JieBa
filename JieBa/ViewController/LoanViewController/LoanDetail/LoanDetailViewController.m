//
//  LoanDetailViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/24.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "LoanDetailViewController.h"
#import "NavView.h"
#import "LoanApi.h"
#import "LoanSuccessViewController.h"

#define placeholderFont HEITI(HeightXiShu(15))
#define titleMargin WidthXiShu(22)
#define titleWidth WidthXiShu(60)

@interface LoanDetailViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *nameView;
@property(nonatomic,strong)UIView *phoneView;
@property(nonatomic,strong)UIView *yzmView;
@property(nonatomic,strong)UITextField *nameTextFiled;
@property(nonatomic,strong)UITextField *phoneTextFiled;
@property(nonatomic,strong)UITextField *yzmTextFiled;
@property(nonatomic,strong)UIButton *yzmBtn;
@property(nonatomic,strong)UIButton *agreeBtn;
@end

@implementation LoanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.tableHeaderView = self.headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(361);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(361))];
    imageView.image = [GetImagePath getImagePath:@"loan_detail"];
    [cell.contentView addSubview:imageView];
    return cell;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"我要申请";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)headView{
    if(!_headView){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(240))];
        [headView addSubview:self.contentView];
        _headView = headView;
    }
    return _headView;
}

-(UIView *)contentView{
    if(!_contentView){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, HeightXiShu(10), kScreenWidth, HeightXiShu(220))];
        contentView.backgroundColor = [UIColor whiteColor];
        
        [contentView addSubview:self.nameView];
        [contentView addSubview:self.phoneView];
        [contentView addSubview:self.yzmView];
        [contentView addSubview:self.agreeBtn];
        
        _contentView = contentView;
    }
    return _contentView;
}

-(UIView *)nameView{
    if(!_nameView){
        UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, titleWidth, HeightXiShu(50))];
        title.text = @"姓      名";
        title.font = placeholderFont;
        title.textColor = TitleColor;
        [nameView addSubview:title];
        
        UITextField *nameTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, nameView.width-(title.maxX+titleMargin)-WidthXiShu(30), HeightXiShu(50))];
        nameTextFiled.placeholder = @"请输入姓名";
        nameTextFiled.font = placeholderFont;
        nameTextFiled.returnKeyType = UIReturnKeyDone;
        nameTextFiled.delegate = self;
        [nameTextFiled setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [nameView addSubview:nameTextFiled];
        _nameTextFiled = nameTextFiled;
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth-WidthXiShu(10), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [nameView addSubview:cutLine];
        
        _nameView = nameView;
    }
    return _nameView;
}

-(UIView *)phoneView{
    if(!_phoneView){
        UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, self.nameView.maxY, kScreenWidth, HeightXiShu(50))];
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

-(UIButton *)agreeBtn{
    if(!_agreeBtn){
        UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreeBtn.frame = CGRectMake(WidthXiShu(12), self.yzmView.maxY+HeightXiShu(10), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        [agreeBtn setTitle:@"确认提交" forState:UIControlStateNormal];
        agreeBtn.backgroundColor = ButtonColor;
        agreeBtn.titleLabel.font = HEITI(HeightXiShu(19));
        [agreeBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
        agreeBtn.layer.masksToBounds = YES;
        agreeBtn.layer.cornerRadius = HeightXiShu(5);
        
        _agreeBtn = agreeBtn;
    }
    return _agreeBtn;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
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
    [dic setObject:@"order" forKey:@"_cmd_"];
    [dic setObject:@"borrowSendSms" forKey:@"type"];
    [dic setObject:self.phoneTextFiled.text forKey:@"mobile"];
    
    [LoanApi loanYzmWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
        
        }
    } dic:dic noNetWork:nil];
}

-(void)agreeAction{
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:@"order" forKey:@"_cmd_"];
//    [dic setObject:[NSNumber numberWithInteger:self.type] forKey:@"car_type"];
//    [dic setObject:@"borrow_add" forKey:@"type"];
//    [dic setObject:self.dict[@"city"] forKey:@"city"];
//    [dic setObject:self.dict[@"money"] forKey:@"loanmoney"];
//    [dic setObject:self.dict[@"time"] forKey:@"loanmonth"];
//    [dic setObject:self.phoneTextFiled.text forKey:@"mobile"];
//    [dic setObject:self.nameTextFiled.text forKey:@"names"];
//    [dic setObject:self.yzmTextFiled.text forKey:@"sms_code"];
//    NSMutableArray *contentArr = [[NSMutableArray alloc] init];
//    [contentArr addObject:dic[@"names"]];
//    [contentArr addObject:dic[@"mobile"]];
//    [contentArr addObject:dic[@"city"]];
//    [contentArr addObject:[NSString stringWithFormat:@"%@元",dic[@"loanmoney"]]];
//    [contentArr addObject:[NSString stringWithFormat:@"%@月",dic[@"loanmonth"]]];
//    [contentArr addObject:self.dict[@"allMoney"]];
//    LoanSuccessViewController *view = [[LoanSuccessViewController alloc] init];
//    view.contentArr = contentArr;
//    [self.navigationController pushViewController:view animated:YES];
//    return;
    
    [self.nameTextFiled resignFirstResponder];
    [self.phoneTextFiled resignFirstResponder];
    [self.yzmTextFiled resignFirstResponder];
    
    if([self.nameTextFiled.text isEqualToString:@""]){
        [self addAlertView:@"姓名不能为空" block:nil];
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
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"order" forKey:@"_cmd_"];
    [dic setObject:[NSNumber numberWithInteger:self.type] forKey:@"car_type"];
    [dic setObject:@"borrow_add" forKey:@"type"];
    [dic setObject:self.dict[@"city"] forKey:@"city"];
    [dic setObject:self.dict[@"money"] forKey:@"loanmoney"];
    [dic setObject:self.dict[@"time"] forKey:@"loanmonth"];
    [dic setObject:self.phoneTextFiled.text forKey:@"mobile"];
    [dic setObject:self.nameTextFiled.text forKey:@"names"];
    [dic setObject:self.yzmTextFiled.text forKey:@"sms_code"];
    
    __block typeof(self)wSelf = self;
    [LoanApi addLoanWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
            NSMutableArray *contentArr = [[NSMutableArray alloc] init];
            [contentArr addObject:dic[@"names"]];
            [contentArr addObject:dic[@"mobile"]];
            [contentArr addObject:dic[@"city"]];
            [contentArr addObject:dic[@"loanmoney"]];
            [contentArr addObject:dic[@"loanmonth"]];
            [contentArr addObject:self.dict[@"allMoney"]];
            
            LoanSuccessViewController *view = [[LoanSuccessViewController alloc] init];
            view.contentArr = contentArr;
            [wSelf.navigationController pushViewController:view animated:YES];
        }
    } dic:dic noNetWork:nil];
}
@end
