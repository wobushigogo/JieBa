//
//  OrderSuccessViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "OrderSuccessViewController.h"
#import "MyCenterApi.h"

@interface OrderSuccessViewController ()
@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;
@end

@implementation OrderSuccessViewController

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
    NSLog(@"OrderSuccessViewController dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(50);
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString* const identifier = @"CenterTableViewCell";
//    CenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[CenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    cell.title = @[@"修改用户名",@"修改手机号",@"修改密码",@"实名认证",@"绑定银行卡",@"更改邀请码"][indexPath.row];
//    cell.detail = @[@"",@"",@"",@"未认证",@"未绑定",@""][indexPath.row];
//    if(indexPath.row == 5){
//        cell.isShowCutLine = NO;
//    }else{
//        cell.isShowCutLine = YES;
//    }
//    return cell;
//}

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
    [dic setObject:@"2" forKey:@"status"];
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
