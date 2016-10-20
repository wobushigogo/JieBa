//
//  OrderUnderwayViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "OrderUnderwayViewController.h"
#import "MyCenterApi.h"
#import "OrderModel.h"
#import "OrderFailCell.h"

@interface OrderUnderwayViewController ()
@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;
@end

@implementation OrderUnderwayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
    [self.tableView setMinY:0 maxY:kScreenHeight-HeightXiShu(100)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"OrderUnderwayViewController dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(173);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *model = self.modelArr[indexPath.row];
    static NSString* const identifier = @"OrderFailCell";
    OrderFailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OrderFailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = model;
    return cell;
}

#pragma mark - 事件
-(void)reloadData{
    NSLog(@"OrderUnderwayViewController reloadData");
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
}

#pragma mark - 接口
-(void)netWorkWithType:(BaseTableViewRefreshType)refreshType{
    BOOL isHeaderRefresh = (refreshType == BaseTableViewRefreshFirstLoad || refreshType == BaseTableViewRefreshHeader);
    NSInteger startIndex = isHeaderRefresh ? 1 : (self.startIndex + 1);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"order" forKey:@"_cmd_"];
    [dic setObject:@"list" forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:startIndex] forKey:@"page"];
    [dic setObject:@"1" forKey:@"status"];
    [dic setObject:@"10" forKey:@"number"];
    
    [MyCenterApi orderListWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            isHeaderRefresh ? self.modelArr = array : [self.modelArr addObjectsFromArray:array];
            [self.tableView reloadData];
            if(array.count == 0){
                self.startIndex = startIndex -1;
            }else{
                self.startIndex = startIndex;
            }
        }
        isHeaderRefresh ? [self.tableView.mj_header endRefreshing] : [self.tableView.mj_footer endRefreshing];
    } dic:dic noNetWork:nil];
}
@end
