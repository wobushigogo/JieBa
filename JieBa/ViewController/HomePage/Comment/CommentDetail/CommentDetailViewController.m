//
//  CommentDetailViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CommentDetailViewController.h"
#import "NavView.h"
#import "CarlifeApi.h"
#import "CarlifeModel.h"
#import "CommentHeadView.h"

@interface CommentDetailViewController ()
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)CarlifeModel *carlifeModel;
@property(nonatomic,strong)CommentHeadView *headView;
@property(nonatomic,strong)NSMutableArray *modelArr;
@property(nonatomic)NSInteger startIndex;
@end

@implementation CommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    
    [self loadInfo];
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeightXiShu(10);
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"详情";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(CommentHeadView *)headView{
    if(!_headView){
        CommentHeadView *headView = [[CommentHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _headView = headView;
        __block typeof(self)wSelf = self;
        headView.heightBlock = ^(CGFloat height){
            NSLog(@"%f",height);
            wSelf.headView.height = height;
            wSelf.tableView.tableHeaderView = wSelf.headView;
        };
    }
    return _headView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 接口
-(void)loadInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"carlife" forKey:@"_cmd_"];
    [dic setObject:@"detail" forKey:@"type"];
    [dic setObject:self.commentId forKey:@"id"];
    
    [CarlifeApi carlifeInfoWithBlock:^(CarlifeModel *model, NSError *error) {
        if(!error){
            self.carlifeModel = model;
            [self.headView setModel:model];
        }
    } dic:dic noNetWork:nil];
}

-(void)netWorkWithType:(BaseTableViewRefreshType)refreshType{
    BOOL isHeaderRefresh = (refreshType == BaseTableViewRefreshFirstLoad || refreshType == BaseTableViewRefreshHeader);
    NSInteger startIndex = isHeaderRefresh ? 1 : (self.startIndex + 1);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"carlife" forKey:@"_cmd_"];
    [dic setObject:@"evalList" forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:startIndex] forKey:@"page"];
    [dic setObject:self.commentId forKey:@"assed_id"];
    [dic setObject:@"10" forKey:@"number"];
    
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
