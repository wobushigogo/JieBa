//
//  RepaySuccessViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/3.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RepaySuccessViewController.h"
#import "NavView.h"

@interface RepaySuccessViewController ()
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)UIView *contentView;
@end

@implementation RepaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self contentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"借款结果";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [navView.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [navView.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)contentView{
    if(!_contentView){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, HeightXiShu(201))];
        contentView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-WidthXiShu(70))/2, HeightXiShu(28), WidthXiShu(70), HeightXiShu(70))];
        imageView.image = [GetImagePath getImagePath:@"credit_success"];
        [contentView addSubview:imageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.maxY+HeightXiShu(12), kScreenWidth, HeightXiShu(30))];
        title.text = @"还款成功";
        title.textColor = ButtonColor;
        title.font = HEITI(HeightXiShu(28));
        title.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:title];
        
        UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, title.maxY+HeightXiShu(19), kScreenWidth, HeightXiShu(30))];
        moneyLabel.text = [NSString stringWithFormat:@"%@元",self.money];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.font = HEITI(HeightXiShu(28));
        moneyLabel.textColor = TitleColor;
        [contentView addSubview:moneyLabel];
        
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil userInfo:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
