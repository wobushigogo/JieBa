//
//  RentViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RentViewController.h"
#import "NavView.h"
#import "CreditApi.h"
#import "CreditModel.h"
#import "CreditListViewController.h"

@interface RentViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UILabel *lowMoney;
@property(nonatomic,strong)UILabel *mostMoney;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)CreditModel *creditModel;
@end

@implementation RentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self contentView];
    [self submitBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"信用贷";
        navView.leftBtn.hidden = YES;
        [navView.rightBtn setTitle:@"借款记录" forState:UIControlStateNormal];
        [navView.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)contentView{
    if(!_contentView){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, HeightXiShu(283))];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(283))];
        imageView.image = [GetImagePath getImagePath:@"rent_banner"];
        [contentView addSubview:imageView];
        
        UILabel *lowMoney = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(80), WidthXiShu(120), HeightXiShu(30))];
        lowMoney.textColor = ButtonColor;
        lowMoney.text = @"￥0";
        lowMoney.font = [UIFont boldSystemFontOfSize:HeightXiShu(30)];
        [contentView addSubview:lowMoney];
        
        UILabel *mostMoney = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(15)-WidthXiShu(140), HeightXiShu(175), WidthXiShu(140), HeightXiShu(30))];
        mostMoney.textColor = ButtonColor;
        mostMoney.text = @"￥0";
        mostMoney.font = [UIFont boldSystemFontOfSize:HeightXiShu(30)];
        [contentView addSubview:mostMoney];
        
        [self.view addSubview:contentView];
        _contentView = contentView;
        _lowMoney = lowMoney;
        _mostMoney = mostMoney;
    }
    return _contentView;
}

-(UIButton *)submitBtn{
    if(!_submitBtn){
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(WidthXiShu(12), self.contentView.maxY+HeightXiShu(30), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        submitBtn.backgroundColor = ButtonColor;
        submitBtn.titleLabel.font = HEITI(HeightXiShu(19));
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn setTitle:@"去借钱" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}

#pragma mark - 事件
-(void)rightAction{
    CreditListViewController *view = [[CreditListViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)submitAction{

}

#pragma mark - 接口
-(void)loadCreditInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"credit_status" forKey:@"type"];
    
    [CreditApi creditWithBlock:^(CreditModel *model, NSError *error) {
        if(!error){
            self.creditModel = model;
            self.lowMoney.text = [NSString stringWithFormat:@"￥%@",self.creditModel.minMoney];
            self.mostMoney.text = [NSString stringWithFormat:@"￥%@",self.creditModel.maxMoney];
        }
    } dic:dic noNetWork:nil];
}
@end
