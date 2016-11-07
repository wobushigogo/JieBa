//
//  OrderAllViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "OrderAllViewController.h"
#import "MyCenterApi.h"
#import "OrderModel.h"
#import "OrderFailCell.h"
#import "OrderSuccessCell.h"
#import "OrderLoanViewController.h"
#import "OrderRentViewController.h"
#import "OrderCommentViewController.h"
#import "CommentDetailViewController.h"

@interface OrderAllViewController ()<OrderSuccessCellDelegate>
@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;
@end

@implementation OrderAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
    [self.tableView setMinY:0 maxY:kScreenHeight-HeightXiShu(110)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"OrderAllViewController dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *model = self.modelArr[indexPath.row];
    if(model.status == 2){
        return HeightXiShu(217);
    }
    return HeightXiShu(173);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *model = self.modelArr[indexPath.row];
    if(model.status == 2){
        static NSString* const identifier = @"OrderSuccessCell";
        OrderSuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OrderSuccessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.model = model;
        return cell;
    }else{
        static NSString* const identifier = @"OrderFailCell";
        OrderFailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OrderFailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = model;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *model = self.modelArr[indexPath.row];
    if(model.orderType == 1 && model.status == 2){
        OrderLoanViewController *view = [[OrderLoanViewController alloc] init];
        view.contractNo = model.applyCode;
        [self.navigationController pushViewController:view animated:YES];
    }else if (model.orderType == 2 && model.status == 2){
        OrderRentViewController *view = [[OrderRentViewController alloc] init];
        view.orderId = model.orderId;
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark - 事件
-(void)reloadData{
    NSLog(@"OrderAllViewController reloadData");
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
}

-(void)commentClick:(NSInteger)index{
    OrderModel *model = self.modelArr[index];
    if(model.is_assed){
        CommentDetailViewController *view = [[CommentDetailViewController alloc] init];
        view.commentId = model.assedId;
        [self.navigationController pushViewController:view animated:YES];
    }else{
        OrderCommentViewController *view = [[OrderCommentViewController alloc] init];
        view.imageUrl = model.imageUrl;
        view.orderId = model.orderId;
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark - 接口
-(void)netWorkWithType:(BaseTableViewRefreshType)refreshType{
    BOOL isHeaderRefresh = (refreshType == BaseTableViewRefreshFirstLoad || refreshType == BaseTableViewRefreshHeader);
    NSInteger startIndex = isHeaderRefresh ? 1 : (self.startIndex + 1);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"order" forKey:@"_cmd_"];
    [dic setObject:@"list" forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:startIndex] forKey:@"page"];
    [dic setObject:@"" forKey:@"status"];
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
