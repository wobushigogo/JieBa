//
//  ChangeUserNameViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/20.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "ChangeUserNameViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"

@interface ChangeUserNameViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UITextField *textField;
@end

@implementation ChangeUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
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
    return 1;
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
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(60), HeightXiShu(50))];
    title.text = @"用 户 名";
    title.font = HEITI(HeightXiShu(15));
    title.textColor = TitleColor;
    [cell.contentView addSubview:title];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+WidthXiShu(22), 0, kScreenWidth-(title.maxX+WidthXiShu(22))-WidthXiShu(30), HeightXiShu(50))];
    self.textField.placeholder = [LoginSqlite getdata:@"userName"];
    self.textField.font = HEITI(HeightXiShu(15));
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    [self.textField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [cell.contentView addSubview:self.textField];
    return cell;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"修改用户名";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)headView{
    if(!_headView){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(62))];
        
        UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(24), WidthXiShu(19), HeightXiShu(19))];
        smallImageView.image = [GetImagePath getImagePath:@"myCente_changUserName"];
        [headView addSubview:smallImageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12)+smallImageView.maxX, HeightXiShu(24), WidthXiShu(250), HeightXiShu(20))];
        title.text = @"用户名为2-8位汉字、字母、数字结合";
        title.textColor = TitleColor;
        title.font = HEITI(HeightXiShu(14));
        [headView addSubview:title];
        
        _headView = headView;
    }
    return _headView;
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
    [self.textField restorationIdentifier];
    if([self.textField.text isEqualToString:@""]){
        [self addAlertView:@"用户名不能为空" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_changeuserinfo" forKey:@"_cmd_"];
    [dic setObject:@"setusername" forKey:@"type"];
    [dic setObject:self.textField.text forKey:@"username"];
    
    __block typeof(self)wSelf = self;
    [MyCenterApi updataUserNameWithBlock:^(NSString *userName, NSError *error) {
        if(!error){
            [self addAlertView:@"用户名已修改成功" block:^{
                __block typeof(self)otherSelf = wSelf;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUserName" object:nil userInfo:nil];
                [otherSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }
    } dic:dic noNetWork:nil];
}

#pragma mark - textFiled delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
