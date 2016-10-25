//
//  OrderLoanViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/25.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "OrderLoanViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"

@interface OrderLoanViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)NSMutableArray *contentArr;
@end

@implementation OrderLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, HeightXiShu(90), HeightXiShu(50))];
    title.font = HEITI(HeightXiShu(15));
    title.textColor = TitleColor;
    title.text = @[@"合同编号",@"状      态",@"申请日期",@"放款金额",@"实际到账金额",@"剩余还款金额",@"本期期数",@"到期还款日",@"本期还款金额"][indexPath.row];
    [cell.contentView addSubview:title];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(title.maxX+HeightXiShu(22), 0, WidthXiShu(180), HeightXiShu(50))];
    content.text = self.contentArr[indexPath.row];
    content.font = HEITI(HeightXiShu(15));
    content.textColor = TitleColor;
    [cell.contentView addSubview:content];
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(49), kScreenWidth-WidthXiShu(12), .5)];
    cutLine.backgroundColor = AllLightGrayColor;
    [cell.contentView addSubview:cutLine];
    
    if(indexPath.row != 8){
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
        navView.titleLabel.text = @"贷款详情";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [navView.rightBtn setTitle:@"还款明细" forState:UIControlStateNormal];
        [navView.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{

}

#pragma mark - 接口
-(void)loadInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"order" forKey:@"_cmd_"];
    [dic setObject:@"loanerp" forKey:@"type"];
    [dic setObject:self.contractNo forKey:@"ContractNo"];
    
    [MyCenterApi orderLoanInfoWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            self.contentArr = array;
            [self.tableView reloadData];
        }
    } dic:dic noNetWork:nil];
}
@end
