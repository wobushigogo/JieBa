//
//  CreditDetailViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/24.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CreditDetailViewController.h"
#import "NavView.h"
#import "CreditApi.h"
#import "AgreeMentViewController.h"
#import "CreditRepayViewController.h"

@interface CreditDetailViewController ()
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)CreditDetailModel *creditDetailModel;
@property(nonatomic,strong)UIView *auditView;
@property(nonatomic,strong)UIView *endView;
@property(nonatomic,strong)UIView *endDetailView;
@property(nonatomic,strong)UIView *useView;
@property(nonatomic,strong)UIView *overdueView;
@end

@implementation CreditDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self loadDetail];
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
        navView.titleLabel.text = @"借款详情";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

//审核中
-(UIView *)auditView{
    if(!_auditView){
        UIView *auditView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, HeightXiShu(152))];
        auditView.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(25), kScreenWidth, HeightXiShu(20))];
        title.textColor = TitleColor;
        title.text = @"审核中金额（元）";
        title.textAlignment = NSTextAlignmentCenter;
        title.font = HEITI(HeightXiShu(20));
        [auditView addSubview:title];
        
        UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(0, title.maxY+HeightXiShu(25), kScreenWidth, HeightXiShu(20))];
        money.textColor = ButtonColor;
        money.text = self.creditDetailModel.loanmoney;
        money.textAlignment = NSTextAlignmentCenter;
        money.font = HEITI(HeightXiShu(24));
        [auditView addSubview:money];
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, money.maxY+HeightXiShu(25), kScreenWidth, HeightXiShu(20))];
        message.textColor = MessageColor;
        message.text = @"请等待审核结果";
        message.textAlignment = NSTextAlignmentCenter;
        message.font = HEITI(HeightXiShu(15));
        [auditView addSubview:message];
        
        [self.view addSubview:auditView];
        _auditView = auditView;
    }
    return _auditView;
}

-(UIView *)endView{
    if(!_endView){
        UIView *endView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, HeightXiShu(125))];
        endView.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(25), kScreenWidth, HeightXiShu(20))];
        title.textColor = TitleColor;
        title.text = @"已还款金额（元）";
        title.textAlignment = NSTextAlignmentCenter;
        title.font = HEITI(HeightXiShu(20));
        [endView addSubview:title];
        
        UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(0, title.maxY+HeightXiShu(25), kScreenWidth, HeightXiShu(20))];
        money.textColor = ButtonColor;
        money.text = self.creditDetailModel.loanmoney;
        money.textAlignment = NSTextAlignmentCenter;
        money.font = HEITI(HeightXiShu(24));
        [endView addSubview:money];
        
        [self.view addSubview:endView];
        _endView = endView;
    }
    
    return _endView;
}

-(UIView *)endDetailView{
    if(!_endDetailView){
        UIView *endDetailView = [[UIView alloc] init];
        if(self.creditDetailModel.credit_order_status == 1){
            endDetailView.frame = CGRectMake(0, self.useView.maxY+HeightXiShu(10), kScreenWidth, HeightXiShu(137));
        }else if(self.creditDetailModel.credit_order_status == 4){
            endDetailView.frame = CGRectMake(0, self.endView.maxY+HeightXiShu(10), kScreenWidth, HeightXiShu(137));
        }else{
            endDetailView.frame = CGRectMake(0, self.overdueView.maxY+HeightXiShu(10), kScreenWidth, HeightXiShu(137));
        }
        endDetailView.backgroundColor = [UIColor whiteColor];
        
        CGFloat topMargin = HeightXiShu(18);
        CGFloat margin = HeightXiShu(10);
        
        NSArray *titleArr = @[@"借款金额",@"合同期限",@"还款方式",@"借款合同"];
        NSArray *detailArr = @[self.creditDetailModel.loanmoney,[NSString stringWithFormat:@"%@至%@",self.creditDetailModel.pay_time,self.creditDetailModel.back_date],@"先息后本"];
        
        [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), idx*(margin+HeightXiShu(16))+topMargin, kScreenWidth/2-WidthXiShu(12), HeightXiShu(16))];
            title.text = obj;
            title.textColor = MessageColor;
            title.font = HEITI(HeightXiShu(15));
            [endDetailView addSubview:title];
        }];
        
        [detailArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, idx*(margin+HeightXiShu(16))+topMargin, kScreenWidth/2-WidthXiShu(12), HeightXiShu(16))];
            detail.text = obj;
            detail.textColor = MessageColor;
            detail.font = HEITI(HeightXiShu(15));
            detail.textAlignment = NSTextAlignmentRight;
            [endDetailView addSubview:detail];
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(30), endDetailView.height-topMargin-HeightXiShu(20), WidthXiShu(30), HeightXiShu(20));
        [btn setTitle:@"查看" forState:UIControlStateNormal];
        btn.titleLabel.font = HEITI(HeightXiShu(15));
        [btn setTitleColor:ButtonColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
        [endDetailView addSubview:btn];
        
        [self.view addSubview:endDetailView];
        _endDetailView = endDetailView;
    }
    
    return _endDetailView;
}

-(UIView *)useView{
    if(!_useView){
        UIView *useView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, HeightXiShu(175))];
        useView.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(25), kScreenWidth, HeightXiShu(20))];
        title.textColor = TitleColor;
        title.text = @"使用中金额（元）";
        title.textAlignment = NSTextAlignmentCenter;
        title.font = HEITI(HeightXiShu(20));
        [useView addSubview:title];
        
        UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(0, title.maxY+HeightXiShu(25), kScreenWidth, HeightXiShu(20))];
        money.textColor = ButtonColor;
        money.text = self.creditDetailModel.loanmoney;
        money.textAlignment = NSTextAlignmentCenter;
        money.font = HEITI(HeightXiShu(24));
        [useView addSubview:money];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(125), kScreenWidth, .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [useView addSubview:cutLine];
        
        UILabel *btnLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(125), kScreenWidth, HeightXiShu(50))];
        btnLabel.text = @"去还款";
        btnLabel.textColor = TitleColor;
        btnLabel.font = HEITI(HeightXiShu(15));
        [useView addSubview:btnLabel];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(8), HeightXiShu(18.5)+HeightXiShu(125), WidthXiShu(8), HeightXiShu(13))];
        arrowImageView.image = [GetImagePath getImagePath:@"myCenter_arrow"];
        [useView addSubview:arrowImageView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, HeightXiShu(125), kScreenWidth, HeightXiShu(50));
        [btn addTarget:self action:@selector(repayAction) forControlEvents:UIControlEventTouchUpInside];
        [useView addSubview:btn];
        
        [self.view addSubview:useView];
        _useView = useView;
    }
    return _useView;
}

-(UIView *)overdueView{
    if(!_overdueView){
        UIView *overdueView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, HeightXiShu(225))];
        overdueView.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(25), kScreenWidth, HeightXiShu(20))];
        title.textColor = TitleColor;
        title.text = @"使用中金额（元）";
        title.textAlignment = NSTextAlignmentCenter;
        title.font = HEITI(HeightXiShu(20));
        [overdueView addSubview:title];
        
        UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(0, title.maxY+HeightXiShu(25), kScreenWidth, HeightXiShu(20))];
        money.textColor = ButtonColor;
        money.text = self.creditDetailModel.loanmoney;
        money.textAlignment = NSTextAlignmentCenter;
        money.font = HEITI(HeightXiShu(24));
        [overdueView addSubview:money];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(125), kScreenWidth, .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [overdueView addSubview:cutLine];
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12),HeightXiShu(125) , WidthXiShu(50), HeightXiShu(50))];
        message.text = @"滞纳金";
        message.textColor = TitleColor;
        message.font = HEITI(HeightXiShu(15));
        [overdueView addSubview:message];
        
        UILabel *overdueFine = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3, HeightXiShu(125), kScreenWidth/3, HeightXiShu(50))];
        overdueFine.font = HEITI(HeightXiShu(15));
        overdueFine.textAlignment = NSTextAlignmentCenter;
        overdueFine.textColor = TitleColor;
        NSMutableAttributedString *overdueFineAttStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",self.creditDetailModel.late_fee]];
        [overdueFineAttStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(0,self.creditDetailModel.late_fee.length)];
        overdueFine.attributedText = overdueFineAttStr;
        [overdueView addSubview:overdueFine];
        
        UILabel *overdueDate = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3*2, HeightXiShu(125), kScreenWidth/3, HeightXiShu(50))];
        overdueDate.font = HEITI(HeightXiShu(15));
        overdueDate.textAlignment = NSTextAlignmentCenter;
        overdueDate.textColor = TitleColor;
        NSMutableAttributedString *overdueDateAttStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已逾期%@天",self.creditDetailModel.late_days]];
        [overdueDateAttStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(3,self.creditDetailModel.late_days.length)];
        overdueDate.attributedText = overdueDateAttStr;
        [overdueView addSubview:overdueDate];
        
        UIImageView *cutLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(175), kScreenWidth, .5)];
        cutLine2.backgroundColor = AllLightGrayColor;
        [overdueView addSubview:cutLine2];
        
        UILabel *btnLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(175), kScreenWidth, HeightXiShu(50))];
        btnLabel.text = @"去还款";
        btnLabel.textColor = TitleColor;
        btnLabel.font = HEITI(HeightXiShu(15));
        [overdueView addSubview:btnLabel];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(8), HeightXiShu(18.5)+HeightXiShu(175), WidthXiShu(8), HeightXiShu(13))];
        arrowImageView.image = [GetImagePath getImagePath:@"myCenter_arrow"];
        [overdueView addSubview:arrowImageView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, HeightXiShu(175), kScreenWidth, HeightXiShu(50));
        [btn addTarget:self action:@selector(repayAction) forControlEvents:UIControlEventTouchUpInside];
        [overdueView addSubview:btn];
        
        [self.view addSubview:overdueView];
        _overdueView = overdueView;
    }
    return _overdueView;
}

-(void)addSubView{
    if(self.creditDetailModel.credit_order_status == 1){
        [self useView];
        [self endDetailView];
    }else if(self.creditDetailModel.credit_order_status == 2){
        [self auditView];
    }else if (self.creditDetailModel.credit_order_status == 4){
        [self endView];
        [self endDetailView];
    }else{
        [self overdueView];
        [self endDetailView];
    }
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showAction{
    __block typeof(self)wSelf = self;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *loaclAction = [UIAlertAction actionWithTitle:@"个人借款协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AgreeMentViewController *view = [[AgreeMentViewController alloc] init];
        view.webUrl = self.urlDic[@"creditagreement"];
        view.money = self.money;
        [wSelf.navigationController pushViewController:view animated:YES];
    }];
    UIAlertAction *takeAction = [UIAlertAction actionWithTitle:@"居间服务协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AgreeMentViewController *view = [[AgreeMentViewController alloc] init];
        view.webUrl = self.urlDic[@"creditagreement2"];
        view.money = self.money;
        [wSelf.navigationController pushViewController:view animated:YES];
    }];
    [alertControl addAction:cancelAction];
    [alertControl addAction:loaclAction];
    [alertControl addAction:takeAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

-(void)repayAction{
    CreditRepayViewController *view = [[CreditRepayViewController alloc] init];
    if(self.creditDetailModel.credit_order_status == 1){
        view.repayOrOverdue = repay;
    }else if (self.creditDetailModel.credit_order_status == 5){
        view.repayOrOverdue = overdue;
    }
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 接口
-(void)loadDetail{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"orderListDetail" forKey:@"type"];
    [dic setObject:self.orderId forKey:@"id"];
    
    [CreditApi creditDetailWithBlock:^(CreditDetailModel *model, NSError *error) {
        if(!error){
            self.creditDetailModel = model;
            [self addSubView];
        }
    } dic:dic noNetWork:nil];
}
@end
