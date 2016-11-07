//
//  EndCommentViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/7.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "EndCommentViewController.h"
#import "NavView.h"
#import "OrderSuccessCell.h"
#import "AssedModel.h"
#import "OrderLoanViewController.h"
#import "OrderRentViewController.h"
#import "MyCenterApi.h"
#import "CommentDetailViewController.h"

@interface EndCommentViewController ()<OrderSuccessCellDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)NSMutableArray *modelArr;
@property(nonatomic)NSInteger startIndex;
@end

@implementation EndCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(217);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AssedModel *model = self.modelArr[indexPath.row];
    static NSString* const identifier = @"OrderSuccessCell";
    OrderSuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OrderSuccessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.assedModel = model;
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *model = self.modelArr[indexPath.row];
    if(model.orderType == 1){
        OrderLoanViewController *view = [[OrderLoanViewController alloc] init];
        view.contractNo = model.applyCode;
        [self.navigationController pushViewController:view animated:YES];
    }else if (model.orderType == 2){
        OrderRentViewController *view = [[OrderRentViewController alloc] init];
        view.orderId = model.orderId;
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"已评价";
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

-(void)commentClick:(NSInteger)index{
    AssedModel *model = self.modelArr[index];
    CommentDetailViewController *view = [[CommentDetailViewController alloc] init];
    view.commentId = model.assedId;
    __block typeof(self)wSelf = self;
    view.delBlcok = ^(void){
        [wSelf netWorkWithType:BaseTableViewRefreshHeader];
    };
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 接口
-(void)netWorkWithType:(BaseTableViewRefreshType)refreshType{
    BOOL isHeaderRefresh = (refreshType == BaseTableViewRefreshFirstLoad || refreshType == BaseTableViewRefreshHeader);
    NSInteger startIndex = isHeaderRefresh ? 1 : (self.startIndex + 1);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"order" forKey:@"_cmd_"];
    [dic setObject:@"asseded" forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:startIndex] forKey:@"page"];
    [dic setObject:@"10" forKey:@"number"];
    
    [MyCenterApi endCommentListWithBlock:^(NSMutableArray *array, NSError *error) {
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
