//
//  CommentListViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/27.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CommentListViewController.h"
#import "NavView.h"
#import "StageChooseView.h"
#import "CarlifeApi.h"
#import "CommentCell.h"
#import "CarlifeModel.h"

@interface CommentListViewController ()<StageChooseViewDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)StageChooseView *stageChooseView;
@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;
@property(nonatomic,strong)NSString *is_cream;
@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.is_cream = @"1";
    [self statusBar];
    [self navView];
    [self.stageChooseView setMinY:self.navView.maxY];
    [self.stageChooseView stageLabelClickedWithSequence:1];
    
    [self.tableView setMinY:self.stageChooseView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
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
    return self.modelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarlifeModel *model = self.modelArr[indexPath.row];
    return [CommentCell carculateCellHeightWithString:model.content];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CarlifeModel *model = self.modelArr[indexPath.row];
    cell.model = model;
    return cell;
}
#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"我与借吧";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (StageChooseView *)stageChooseView {
    if (!_stageChooseView) {
        _stageChooseView = [StageChooseView stageChooseViewWithStages:@[@"精华",@"全部"] numbers:nil delegate:self underLineIsWhole:YES normalColor:ButtonColor highlightColor:ButtonColor height:HeightXiShu(40)];
        [_stageChooseView hideVerticalLine];
        [self.view addSubview:_stageChooseView];
    }
    return _stageChooseView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - StageChooseViewDelegate
- (void)stageBtnClickedWithNumber:(NSInteger)stageNumber {
    self.startIndex = 1;
    if(stageNumber == 0){
        self.is_cream = @"";
    }else{
        self.is_cream = @"1";
    }
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
}

#pragma mark - 接口
-(void)netWorkWithType:(BaseTableViewRefreshType)refreshType{
    BOOL isHeaderRefresh = (refreshType == BaseTableViewRefreshFirstLoad || refreshType == BaseTableViewRefreshHeader);
    NSInteger startIndex = isHeaderRefresh ? 1 : (self.startIndex + 1);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"carlife" forKey:@"_cmd_"];
    [dic setObject:@"list" forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:startIndex] forKey:@"page"];
    [dic setObject:self.is_cream forKey:@"is_cream"];
    [dic setObject:@"10" forKey:@"number"];
    [dic setObject:@"1" forKey:@"is_list"];
    
    [CarlifeApi carlifeListWithBlock:^(NSMutableArray *array, NSError *error) {
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
