//
//  MoreViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/21.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MoreViewController.h"
#import "NavView.h"
#import "CompanyProfileViewController.h"
#import "HomeApi.h"
#import "HelpCenterViewController.h"
#import "FeedbackViewController.h"

@interface MoreViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,copy)NSMutableDictionary *urlDic;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.scrollEnabled = NO;
    [self loadUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - tableView delegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

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
    static NSString* const identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, kScreenWidth-WidthXiShu(30), HeightXiShu(50))];
    title.text = @[@"帮助中心",@"关于我们",@"意见反馈"][indexPath.row];
    title.font = HEITI(HeightXiShu(16));
    title.textColor = TitleColor;
    [cell.contentView addSubview:title];
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(50), kScreenWidth, .5)];
    cutLine.backgroundColor = AllLightGrayColor;
    [cell.contentView addSubview:cutLine];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        HelpCenterViewController *view = [[HelpCenterViewController alloc] init];
        view.webUrl = self.urlDic[@"helpcenter"];
        [self.navigationController pushViewController:view animated:YES];
    }else if (indexPath.row == 1){
        CompanyProfileViewController *view = [[CompanyProfileViewController alloc] init];
        view.webUrl = self.urlDic[@"jieba"];
        [self.navigationController pushViewController:view animated:YES];
    }else{
        FeedbackViewController *view = [[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"更多";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 接口
-(void)loadUrl{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"banner" forKey:@"_cmd_"];
    [dic setObject:@"more" forKey:@"type"];
    
    [HomeApi html5WithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            self.urlDic = dict;
            [LoginSqlite insertData:dict[@"sign"] datakey:@"sign"];
            [LoginSqlite insertData:dict[@"activity"] datakey:@"activity"];
        }
    } dic:dic noNetWork:nil];
}
@end
