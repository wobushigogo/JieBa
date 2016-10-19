//
//  BaseTableViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/16.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController
@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tableView];
    
    [self setUpHeaderRefresh:YES footerRefresh:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - header,footer,network

- (void)setUpHeaderRefresh:(BOOL)headerRefresh footerRefresh:(BOOL)footerRefresh {
    __weak typeof(self) wSelf = self;
    self.tableView.mj_header = headerRefresh ? [MJRefreshHeader headerWithRefreshingBlock:^{
        [wSelf netWorkWithType:BaseTableViewRefreshHeader];
    }] : nil;
    self.tableView.mj_footer = footerRefresh ? [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [wSelf netWorkWithType:BaseTableViewRefreshFooter];
    }] : nil;
}

- (void)netWorkWithType:(BaseTableViewRefreshType)refreshType{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%d行",(short)indexPath.row];
    return cell;
}

- (void)tableView:(BaseTableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.autoEndEdit) [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoEndEdit) [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (!self.needCellAnimation) return;
    view.alpha = 0;
    [UIView animateWithDuration:.5 animations:^{
        view.alpha = 1;
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.needCellAnimation) return;
    cell.alpha = 0;
    cell.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:.5 animations:^{
        cell.alpha = 1;
    } completion:^(BOOL finished) {
        cell.userInteractionEnabled = YES;
    }];
}

#pragma mark - setter&getter

- (void)setTableView:(BaseTableView *)tableView{
    _tableView = tableView;
}

- (BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:kScreenBounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.size = kScreenSize;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
