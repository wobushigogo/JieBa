//
//  CenterViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CenterViewController.h"
#import "NavView.h"
#import "LoginApi.h"
#import "CenterTableViewCell.h"
#import "ChangeUserNameViewController.h"
#import "ChangePhoneViewController.h"
#import "ChangePwdViewController.h"
#import "RealNameViewController.h"
#import "ChangeInviteCodeViewController.h"
#import "MyCenterApi.h"
#import "AddCashViewController.h"
#import "BindCardViewController.h"

@interface CenterViewController () 
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,assign)NSInteger failCount;
@property(nonatomic,strong)NSMutableArray *detailArr;
@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailArr = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@""]];
    [self statusBar];
    [self navView];
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.scrollEnabled = NO;
    [self loadNameStatus];
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
        navView.titleLabel.text = @"个人中心";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.tableView.height - HeightXiShu(310))];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(WidthXiShu(12), HeightXiShu(34), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        btn.backgroundColor = ButtonColor;
        [btn setTitle:@"退出当前账号" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = HeightXiShu(5);
        [btn addTarget:self action:@selector(logoutACtion) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
        
        _footerView = footerView;
    }
    return _footerView;
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeightXiShu(10);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"CenterTableViewCell";
    CenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.title = @[@"修改用户名",@"修改手机号",@"修改密码",@"实名认证",@"绑定银行卡",@"更改邀请码"][indexPath.row];
    cell.detail = self.detailArr[indexPath.row];
    if(indexPath.row == 5){
        cell.isShowCutLine = NO;
    }else{
        cell.isShowCutLine = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        ChangeUserNameViewController *view = [[ChangeUserNameViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }else if (indexPath.row == 1){
        ChangePhoneViewController *view = [[ChangePhoneViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }else if (indexPath.row == 2){
        ChangePwdViewController *view = [[ChangePwdViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }else if (indexPath.row == 3){
        RealNameViewController *view = [[RealNameViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }else if (indexPath.row == 4){
        NSString *content = self.detailArr[indexPath.row];
        if([content isEqualToString:@"已绑定"]){
            BindCardViewController *view = [[BindCardViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }else{
            [self isBindCard];
        }
    }else{
        ChangeInviteCodeViewController *view = [[ChangeInviteCodeViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)logoutACtion{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_logout" forKey:@"_cmd_"];
    [dic setObject:[LoginSqlite getdata:@"token"] forKey:@"token"];
    [LoginApi logoutWithBlock:^(NSString *string, NSError *error) {
        if(!error){
            [LoginSqlite deleteAll];
            self.tabBarController.tabBar.hidden = NO;
            [self.navigationController popViewControllerAnimated:YES];
            if(self.logoutBlock){
                self.logoutBlock();
            }
        }
    } dic:dic noNetWork:nil];
}

#pragma mark - 接口

-(void)loadNameStatus{
    __block typeof(self)wSelf = self;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_changeuserinfo" forKey:@"_cmd_"];
    [dic setObject:@"member_info" forKey:@"type"];
    [MyCenterApi getUserInfoWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
            if([dict[@"nameStatus"] integerValue] == 1){
                [self.detailArr replaceObjectAtIndex:3 withObject:@"已认证"];
            }else{
                [self.detailArr replaceObjectAtIndex:3 withObject:@"未认证"];
            }
            
            if([dict[@"openFuyouStatus"] integerValue] == 1){
                [self.detailArr replaceObjectAtIndex:4 withObject:@"已绑定"];
            }else{
                [self.detailArr replaceObjectAtIndex:4 withObject:@"未绑定"];
            }
            [wSelf.tableView reloadData];
        }
    } dic:dic noNetWork:nil];
}

-(void)isBindCard{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"cash" forKey:@"_cmd_"];
    [dic setObject:@"1" forKey:@"money"];
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
@end
