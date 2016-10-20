//
//  ChangePwdViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/20.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"

@interface ChangePwdViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)NSString *pwdOld;
@property(nonatomic,strong)NSString *pwdNew;
@property(nonatomic,strong)NSString *pwdNewAgain;
@property(nonatomic,strong)UITextField *textField;
@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pwdNew = @"";
    self.pwdOld = @"";
    self.pwdNewAgain = @"";
    [self statusBar];
    [self navView];
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.scrollEnabled = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
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
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(60), HeightXiShu(50))];
    title.text = @[@"原始密码",@"新 密 码",@"确认密码"][indexPath.row];
    title.font = HEITI(HeightXiShu(15));
    title.textColor = TitleColor;
    [cell.contentView addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+WidthXiShu(22), 0, kScreenWidth-(title.maxX+WidthXiShu(22))-WidthXiShu(30), HeightXiShu(50))];
    textField.placeholder = @[@"请输入密码",@"请输入新密码",@"请再次输入新密码"][indexPath.row];
    textField.font = HEITI(HeightXiShu(15));
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    textField.tag = indexPath.row;
    textField.secureTextEntry = YES;
    [textField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [cell.contentView addSubview:textField];
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(50), kScreenWidth, .5)];
    cutLine.backgroundColor = AllLightGrayColor;
    [cell.contentView addSubview:cutLine];
    
    if(indexPath.row !=2){
        cutLine.hidden = NO;
    }else{
        cutLine.hidden = YES;
    }
    return cell;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"修改密码";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.tableView.height - HeightXiShu(112))];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(WidthXiShu(12), HeightXiShu(34), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        btn.backgroundColor = ButtonColor;
        [btn setTitle:@"确认提交" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = HeightXiShu(5);
        [btn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
        
        _footerView = footerView;
    }
    return _footerView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitAction{
    [self.textField resignFirstResponder];
    if([self.pwdOld isEqualToString:@""]){
        [self addAlertView:@"密码不能为空" block:nil];
        return;
    }
    
    if([self.pwdNew isEqualToString:@""]){
        [self addAlertView:@"新密码不能为空" block:nil];
        return;
    }
    
    if([self.pwdNewAgain isEqualToString:@""]){
        [self addAlertView:@"请确认密码" block:nil];
        return;
    }
    
    if(![self.pwdNewAgain isEqualToString:self.pwdNew]){
        [self addAlertView:@"两次输入密码不同，请重新输入" block:nil];
        return;
    }

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_changeuserinfo" forKey:@"_cmd_"];
    [dic setObject:@"setpwd" forKey:@"type"];
    [dic setObject:self.pwdOld forKey:@"old_pwd"];
    [dic setObject:self.pwdNew forKey:@"new_pwd"];
    [dic setObject:self.pwdNewAgain forKey:@"renew_pwd"];
    
    __block typeof(self)wSelf = self;
    [MyCenterApi updataPwdWithBlock:^(NSString *userName, NSError *error) {
        if(!error){
            [self addAlertView:@"修改成功请重新登录" block:^{
                [LoginSqlite deleteAll];
                wSelf.tabBarController.tabBar.hidden = NO;
                wSelf.tabBarController.selectedIndex = 0;
                [wSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }
    } dic:dic noNetWork:nil];
}

#pragma mark - textFiled delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.textField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"asdfasdfsadfasdf");
    if(textField.tag == 0){
        self.pwdOld = textField.text;
    }else if(textField.tag == 1){
        self.pwdNew = textField.text;
    }else{
        self.pwdNewAgain = textField.text;
    }
}
@end
