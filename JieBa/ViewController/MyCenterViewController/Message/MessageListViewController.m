//
//  MessageListViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/28.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MessageListViewController.h"
#import "NavView.h"
#import "StageChooseView.h"
#import "MessageListCell.h"
#import "MessageModel.h"
#import "MyCenterApi.h"
#import "MessageDetailViewController.h"

@interface MessageListViewController ()<StageChooseViewDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)StageChooseView *stageChooseView;
@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;
@property(nonatomic,strong)NSString *type;
@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = @"1";
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
    return HeightXiShu(80);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"MessageListCell";
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MessageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MessageModel *model = self.modelArr[indexPath.row];
    cell.model = model;
    
    if(indexPath.row == self.modelArr.count-1){
        cell.isShowCutLine = YES;
    }else{
        cell.isShowCutLine = NO;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = self.modelArr[indexPath.row];
    MessageDetailViewController *view = [[MessageDetailViewController alloc] init];
    view.messageId = model.messageId;
    __block typeof(self)wSelf = self;
    view.backBlock = ^(void){
        [wSelf netWorkWithType:BaseTableViewRefreshFirstLoad];
    };
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"系统消息";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (StageChooseView *)stageChooseView {
    if (!_stageChooseView) {
        _stageChooseView = [StageChooseView stageChooseViewWithStages:@[@"最新消息",@"全部"] numbers:nil delegate:self underLineIsWhole:YES normalColor:ButtonColor highlightColor:ButtonColor height:HeightXiShu(40)];
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
        self.type = @"0";
    }else{
        self.type = @"1";
    }
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
}

#pragma mark - 接口
-(void)netWorkWithType:(BaseTableViewRefreshType)refreshType{
    BOOL isHeaderRefresh = (refreshType == BaseTableViewRefreshFirstLoad || refreshType == BaseTableViewRefreshHeader);
    NSInteger startIndex = isHeaderRefresh ? 1 : (self.startIndex + 1);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"system" forKey:@"_cmd_"];
    [dic setObject:@"list" forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:startIndex] forKey:@"page"];
    [dic setObject:self.type forKey:@"status"];
    [dic setObject:@"10" forKey:@"number"];
    
    [MyCenterApi systemMessageListWithBlock:^(NSMutableArray *array, NSError *error) {
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
