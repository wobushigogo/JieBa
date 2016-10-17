//
//  MyCenterViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyCenterHead.h"

@interface MyCenterViewController ()
@property(nonatomic,strong)MyCenterHead *headView;
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:0 maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0 || section == 1 || section == 2){
        return 2;
    }else if (section == 3){
        return 4;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return HeightXiShu(196);
    }
    return HeightXiShu(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1){
        return HeightXiShu(22);
    }
    return 0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CGFloat const height = [self tableView:tableView heightForHeaderInSection:section];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
//    view.backgroundColor = AllBackLightGratColor;
//    
//    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(4), WidthXiShu(2), HeightXiShu(14))];
//    cutLine.backgroundColor = ButtonColor;
//    [view addSubview:cutLine];
//    
//    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(27), 0, WidthXiShu(60), height)];
//    typeLabel.font = HEITI(HeightXiShu(15));
//    typeLabel.text = @"我与借吧";
//    typeLabel.textColor = TitleColor;
//    typeLabel.font = HEITI(HeightXiShu(12));
//    [view addSubview:typeLabel];
//    
//    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    moreBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(92), 0, WidthXiShu(80), height);
//    [moreBtn setTitle:@"查看更多》" forState:UIControlStateNormal];
//    [moreBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
//    moreBtn.titleLabel.font = HEITI(HeightXiShu(10));
//    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [view addSubview:moreBtn];
//    return view;
//}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.section == 0){
//        MainButtonCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MainButtonCell"];
//        if (!cell) {
//            cell=[[MainButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainButtonCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }else{
//        InvitationCell* cell=[tableView dequeueReusableCellWithIdentifier:@"InvitationCell"];
//        if (!cell) {
//            cell=[[InvitationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InvitationCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.modelsArr = self.invitationModels;
//        return cell;
//    }
//}

#pragma mark - 页面元素
-(MyCenterHead *)headView{
    if(!_headView){
        MyCenterHead *headView = [[MyCenterHead alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(210))];
        _headView = headView;
    }
    return _headView;
}

@end
