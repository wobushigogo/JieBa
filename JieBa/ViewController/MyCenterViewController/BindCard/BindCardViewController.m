//
//  BindCardViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/28.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BindCardViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"

#define placeholderFont HEITI(HeightXiShu(15))
#define titleMargin WidthXiShu(22)
#define titleWidth WidthXiShu(80)

@interface BindCardViewController ()
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)NSMutableArray *contentArr;
@end

@implementation BindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentArr = [[NSMutableArray alloc] init];
    [self statusBar];
    [self navView];
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.scrollEnabled = NO;
    [self loadInfo];
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
    return self.contentArr.count;
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
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, titleWidth, HeightXiShu(50))];
    title.font = placeholderFont;
    title.textColor = TitleColor;
    title.text = @[@"姓      名",@"开户银行",@"开户支行",@"银行卡号"][indexPath.row];
    [cell.contentView addSubview:title];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, WidthXiShu(180), HeightXiShu(50))];
    content.text = self.contentArr[indexPath.row];
    content.font = placeholderFont;
    content.textColor = MessageColor;
    [cell.contentView addSubview:content];
    return cell;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"绑定银行卡";
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
-(void)loadInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"fuyou_info" forKey:@"type"];
    
    [MyCenterApi getFuyouInfoWithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            [self.contentArr addObject:dict[@"cust_nm"]];
            [self.contentArr addObject:dict[@"bank_name"]];
            [self.contentArr addObject:dict[@"bank_nm"]];
            [self.contentArr addObject:dict[@"capAcntNo"]];
            [self.tableView reloadData];
        }
    } dic:dic noNetWork:nil];
}
@end
