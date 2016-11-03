//
//  CreditRepayViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/3.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CreditRepayViewController.h"
#import "NavView.h"
#import "CreditApi.h"
#import "RechargeViewController.h"
#import "RepaySuccessViewController.h"

@interface CreditRepayViewController ()
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)NSMutableArray *contentArr;
@property(nonatomic,strong)NSString *detailStr;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic)BOOL balance_allow;
@end

@implementation CreditRepayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentArr = [[NSMutableArray alloc] initWithObjects:@"0.00",@"0.00", nil];
    self.detailStr = @"0.00";
    self.time = @"0";
    self.balance_allow = YES;
    [self statusBar];
    [self navView];
    
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = self.footerView;
    
    [self loadInfo];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.repayOrOverdue == repay){
        return 1;
    }else{
        return 2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return HeightXiShu(10);
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0){
        return HeightXiShu(30);
    }else{
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(30))];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, kScreenWidth-WidthXiShu(24), HeightXiShu(30))];
    title.textColor = MessageColor;
    title.text = @"还款金额将从金账户余额扣除";
    title.font = HEITI(HeightXiShu(14));
    [view addSubview:title];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if(indexPath.section == 0){
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, WidthXiShu(80), HeightXiShu(50))];
        title.font = HEITI(HeightXiShu(15));
        title.textColor = TitleColor;
        title.text = @[@"还款金额",@"金账户余额"][indexPath.row];
        [cell.contentView addSubview:title];
        
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(title.maxX+WidthXiShu(33), 0, kScreenWidth, HeightXiShu(50))];
        detail.font = HEITI(HeightXiShu(15));
        detail.textColor = ButtonColor;
        if(self.balance_allow){
            NSString *detailStr = self.contentArr[indexPath.row];
            NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",detailStr]];
            [attStr addAttribute:NSForegroundColorAttributeName value:TitleColor range:NSMakeRange(detailStr.length, 1)];
            detail.attributedText = attStr;
        }else{
            NSString *detailStr = self.contentArr[indexPath.row];
            if(indexPath.row == 0){
                NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",detailStr]];
                [attStr addAttribute:NSForegroundColorAttributeName value:TitleColor range:NSMakeRange(detailStr.length, 1)];
                detail.attributedText = attStr;
            }else{
                detail.text = detailStr;
            }
        }
        [cell.contentView addSubview:detail];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(49), kScreenWidth-WidthXiShu(12), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [cell.contentView addSubview:cutLine];
    }else{
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, WidthXiShu(80), HeightXiShu(50))];
        title.font = HEITI(HeightXiShu(15));
        title.textColor = TitleColor;
        title.text = @"滞纳金";
        [cell.contentView addSubview:title];
        
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(title.maxX+WidthXiShu(33), 0, kScreenWidth, HeightXiShu(50))];
        detail.font = HEITI(HeightXiShu(15));
        detail.textColor = ButtonColor;
        NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",self.detailStr]];
        [attStr addAttribute:NSForegroundColorAttributeName value:TitleColor range:NSMakeRange(self.detailStr.length, 1)];
        detail.attributedText = attStr;
        [cell.contentView addSubview:detail];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(80), 0, WidthXiShu(80), HeightXiShu(50))];
        timeLabel.textColor = TitleColor;
        timeLabel.font = HEITI(HeightXiShu(15));
        timeLabel.textAlignment = NSTextAlignmentRight;
        NSMutableAttributedString* timeAttStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已逾期%@天",self.time]];
        [timeAttStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(3, self.time.length)];
        timeLabel.attributedText = timeAttStr;
        [cell.contentView addSubview:timeLabel];
    }
    return cell;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        if(self.repayOrOverdue == repay){
            navView.titleLabel.text = @"还款";
        }else{
            navView.titleLabel.text = @"逾期还款";
        }
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)footerView{
    if(!_footerView){
        CGFloat height = 0;
        if(self.repayOrOverdue == repay){
            height = self.tableView.height - HeightXiShu(140);
        }else{
            height = self.tableView.height - HeightXiShu(190);
        }
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth,height)];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(10), kScreenWidth-WidthXiShu(24), HeightXiShu(30))];
        title.textColor = MessageColor;
        title.text = @"滞纳金收取1%/天";
        title.font = HEITI(HeightXiShu(15));
        if(self.repayOrOverdue == repay){
            title.hidden = YES;
        }else{
            title.hidden = NO;
        }
        [footerView addSubview:title];
        
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if(self.repayOrOverdue == repay){
            submitBtn.frame = CGRectMake(WidthXiShu(12), HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        }else{
            submitBtn.frame = CGRectMake(WidthXiShu(12), title.maxY+HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        }
        [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        submitBtn.backgroundColor = ButtonColor;
        submitBtn.titleLabel.font = HEITI(HeightXiShu(19));
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:submitBtn];
        _submitBtn = submitBtn;
        
        _footerView = footerView;
    }
    return _footerView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitAction{
    if(self.balance_allow){
        [self repayMoney];
    }else{
        RechargeViewController *view = [[RechargeViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark - 接口
-(void)loadInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"repayment_info" forKey:@"type"];
    
    [CreditApi repayInfoWithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            self.detailStr = dict[@"late_fee"];
            self.time = dict[@"late_days"];
            [self.contentArr replaceObjectAtIndex:0 withObject:dict[@"back_money"]];
            if([dict[@"balance_allow"] integerValue] == 1){
                [self.contentArr replaceObjectAtIndex:1 withObject:dict[@"ca_balance"]];
                self.balance_allow = YES;
            }else{
                [self.contentArr replaceObjectAtIndex:1 withObject:@"余额不足请去充值"];
                self.balance_allow = NO;
            }
            [self.tableView reloadData];
        }
    } dic:dic noNetWork:nil];
}

-(void)repayMoney{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"repayment" forKey:@"type"];
    self.submitBtn.enabled = NO;
    [CreditApi repayMoneyWithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            RepaySuccessViewController *view = [[RepaySuccessViewController alloc] init];
            view.money = self.contentArr[0];
            [self.navigationController pushViewController:view animated:YES];
        }
        self.submitBtn.enabled = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil userInfo:nil];
    } dic:dic noNetWork:nil];
}
@end
