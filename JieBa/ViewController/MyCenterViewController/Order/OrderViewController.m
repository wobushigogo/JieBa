//
//  OrderViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/19.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "OrderViewController.h"
#import "NavView.h"
#import "StageChooseView.h"
#import "OrderAllViewController.h"
#import "OrderFailViewController.h"
#import "OrderSuccessViewController.h"
#import "OrderUnderwayViewController.h"

@interface OrderViewController ()<StageChooseViewDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)StageChooseView *stageChooseView;
@property(nonatomic,strong)OrderAllViewController *allViewController;
@property(nonatomic,strong)OrderUnderwayViewController *underwayViewController;
@property(nonatomic,strong)OrderFailViewController *failViewController;
@property(nonatomic,strong)OrderSuccessViewController *successViewController;
@property(nonatomic,strong)NSMutableArray *controllersArr;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self.stageChooseView setMinY:self.navView.maxY];
    
    self.controllersArr = [[NSMutableArray alloc] init];
    [self.controllersArr addObject:self.allViewController];
    [self.controllersArr addObject:self.underwayViewController];
    [self.controllersArr addObject:self.failViewController];
    [self.controllersArr addObject:self.successViewController];
    
    [self selectStage:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"我的订单";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (StageChooseView *)stageChooseView {
    if (!_stageChooseView) {
        _stageChooseView = [StageChooseView stageChooseViewWithStages:@[@"全部",@"审核中",@"交易失败",@"交易成功"] numbers:nil delegate:self underLineIsWhole:YES normalColor:ButtonColor highlightColor:ButtonColor height:HeightXiShu(40)];
        [_stageChooseView hideVerticalLine];
        [self.view addSubview:_stageChooseView];
    }
    return _stageChooseView;
}

-(OrderAllViewController *)allViewController{
    if(!_allViewController){
        _allViewController = [[OrderAllViewController alloc] init];
    }
    return _allViewController;
}

-(OrderUnderwayViewController *)underwayViewController{
    if(!_underwayViewController){
        _underwayViewController = [[OrderUnderwayViewController alloc] init];
    }
    return _underwayViewController;
}

-(OrderFailViewController *)failViewController{
    if(!_failViewController){
        _failViewController = [[OrderFailViewController alloc] init];
    }
    return _failViewController;
}

-(OrderSuccessViewController *)successViewController{
    if(!_successViewController){
        _successViewController = [[OrderSuccessViewController alloc] init];
    }
    return _successViewController;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectStage:(NSInteger)index{
    UIViewController *controller = self.controllersArr[index];
    controller.view.frame = CGRectMake(0, self.stageChooseView.maxY, kScreenWidth, kScreenHeight-self.stageChooseView.maxY);
    
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@",[controller class]] object:self userInfo:nil];
}

#pragma mark - StageChooseViewDelegate
- (void)stageBtnClickedWithNumber:(NSInteger)stageNumber {
    [self selectStage:stageNumber];
}
@end
