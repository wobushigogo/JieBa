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
#import "HomeApi.h"
#import "QuestionViewController.h"
#import "BorrowInfoViewController.h"
#import "MyCenterApi.h"
#import "AddCashViewController.h"
#import "CreditSignViewController.h"
#import "CreditRepayViewController.h"

@interface RentViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UILabel *lowMoney;
@property(nonatomic,strong)UILabel *mostMoney;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)CreditModel *creditModel;
@property(nonatomic,strong)UIButton *questionBtn;
@property(nonatomic,strong)UIButton *phoneBtn;
@property(nonatomic,strong)UIView *btnView;
@property(nonatomic,strong)UIView *detailView;
@property(nonatomic,strong)NSString *totalMoney;
@property(nonatomic,strong)NSString *totalPeople;
@property(nonatomic,strong)UILabel *totalMoneyLabel;
@property(nonatomic,strong)UILabel *totalPeopleLabel;
@property(nonatomic,copy)NSMutableDictionary *urlDic;
@end

@implementation RentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self contentView];
    [self submitBtn];
    [self btnView];
    [self questionBtn];
    [self phoneBtn];
    [self loadH5];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"reloadData" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.isHide){
        self.tabBarController.tabBar.hidden = NO;
    }else{
        self.tabBarController.tabBar.hidden = YES;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadData" object:nil];
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"信用贷";
        navView.leftBtn.hidden = self.isHide;
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [navView.rightBtn setTitle:@"借款记录" forState:UIControlStateNormal];
        [navView.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)contentView{
    if(!_contentView){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, HeightXiShu(333))];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(283))];
        imageView.image = [GetImagePath getImagePath:@"credit_banner"];
        [contentView addSubview:imageView];
        
        UILabel *lowMoney = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(60), WidthXiShu(120), HeightXiShu(30))];
        lowMoney.textColor = ButtonColor;
        lowMoney.text = @"￥0";
        lowMoney.font = [UIFont boldSystemFontOfSize:HeightXiShu(28)];
        [contentView addSubview:lowMoney];
        
        UILabel *mostMoney = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(15)-WidthXiShu(120), HeightXiShu(135), WidthXiShu(120), HeightXiShu(30))];
        mostMoney.textColor = ButtonColor;
        mostMoney.text = @"￥0";
        mostMoney.font = [UIFont boldSystemFontOfSize:HeightXiShu(28)];
        [contentView addSubview:mostMoney];
        
        UILabel *totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), imageView.maxY+HeightXiShu(18), WidthXiShu(185), HeightXiShu(20))];
        totalMoneyLabel.textColor = TitleColor;
        totalMoneyLabel.font = HEITI(HeightXiShu(14));
        [contentView addSubview:totalMoneyLabel];
        
        UILabel *totalPeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(175),imageView.maxY+HeightXiShu(18), WidthXiShu(175), HeightXiShu(20))];
        totalPeopleLabel.textColor = TitleColor;
        totalPeopleLabel.font = HEITI(HeightXiShu(14));
        totalPeopleLabel.textAlignment = NSTextAlignmentRight;
        [contentView addSubview:totalPeopleLabel];
        
        [self.view addSubview:contentView];
        _totalMoneyLabel = totalMoneyLabel;
        _totalPeopleLabel = totalPeopleLabel;
        _contentView = contentView;
        _lowMoney = lowMoney;
        _mostMoney = mostMoney;
    }
    return _contentView;
}

-(UIButton *)submitBtn{
    if(!_submitBtn){
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(WidthXiShu(12), self.contentView.maxY, kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        submitBtn.backgroundColor = ButtonColor;
        submitBtn.titleLabel.font = HEITI(HeightXiShu(19));
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn setTitle:@"去借钱" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:submitBtn];
        
        _submitBtn = submitBtn;
    }
    return _submitBtn;
}

-(UIView *)btnView{
    if(!_btnView){
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.maxY, kScreenWidth, HeightXiShu(50))];
        UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        signBtn.frame = CGRectMake(WidthXiShu(10), 0, WidthXiShu(200), HeightXiShu(50));
        signBtn.backgroundColor = ButtonColor;
        [signBtn setTitle:@"去签约" forState:UIControlStateNormal];
        signBtn.layer.masksToBounds = YES;
        signBtn.layer.cornerRadius = HeightXiShu(5);
        [signBtn addTarget:self action:@selector(signAction) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:signBtn];
        
        UIButton *giveUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        giveUpBtn.frame = CGRectMake(signBtn.maxX+WidthXiShu(14), 0, kScreenWidth-WidthXiShu(10)-(signBtn.maxX+WidthXiShu(14)), HeightXiShu(50));
        giveUpBtn.backgroundColor = ButtonColor;
        [giveUpBtn setTitle:@"放弃订单" forState:UIControlStateNormal];
        giveUpBtn.layer.masksToBounds = YES;
        giveUpBtn.layer.cornerRadius = HeightXiShu(5);
        [giveUpBtn addTarget:self action:@selector(giveUpAction) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:giveUpBtn];
        
        [self.view addSubview:btnView];
        _btnView = btnView;
    }
    return _btnView;
}

-(UIButton *)questionBtn{
    if(!_questionBtn){
        UIButton *questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        questionBtn.frame = CGRectMake((kScreenWidth-WidthXiShu(60))/2, self.submitBtn.maxY+HeightXiShu(100), WidthXiShu(60), HeightXiShu(20));
        questionBtn.titleLabel.font = HEITI(HeightXiShu(15));
        [questionBtn addTarget:self action:@selector(questionAction) forControlEvents:UIControlEventTouchUpInside];
        [questionBtn setTitle:@"常见问题" forState:UIControlStateNormal];
        [questionBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
        [self.view addSubview:questionBtn];
        
        _questionBtn = questionBtn;
    }
    return _questionBtn;
}

-(UIButton *)phoneBtn{
    if(!_phoneBtn){
        UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        phoneBtn.frame = CGRectMake((kScreenWidth-WidthXiShu(100))/2, self.questionBtn.maxY+HeightXiShu(3), WidthXiShu(100), HeightXiShu(20));
        phoneBtn.titleLabel.font = HEITI(HeightXiShu(13));
        [phoneBtn addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
        [phoneBtn setTitle:@"400-663-9066" forState:UIControlStateNormal];
        [phoneBtn setTitleColor:PlaceholderColor forState:UIControlStateNormal];
        [self.view addSubview:phoneBtn];
        
        _phoneBtn = phoneBtn;
    }
    return _phoneBtn;
}

#pragma mark - setter
-(void)setTotalMoney:(NSString *)totalMoney{
    _totalMoney = totalMoney;
    NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"贷款总额：%@元",totalMoney]];
    [attStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(5, totalMoney.length)];
    self.totalMoneyLabel.attributedText = attStr;
}

-(void)setTotalPeople:(NSString *)totalPeople{
    _totalPeople = totalPeople;
    NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"正在申请：%@人",totalPeople]];
    [attStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(5, totalPeople.length)];
    self.totalPeopleLabel.attributedText = attStr;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    CreditListViewController *view = [[CreditListViewController alloc] init];
    view.urlDic = self.urlDic;
    view.money = self.creditModel.loanmoney;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)submitAction{
    switch (self.creditModel.order_status) {
        case 1:
        {
            BorrowInfoViewController *view = [[BorrowInfoViewController alloc] init];
            view.model = self.creditModel;
            view.urlDic = self.urlDic;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 3:
        {
            CreditRepayViewController *view = [[CreditRepayViewController alloc] init];
            if(self.creditModel.is_late == 0){
                view.repayOrOverdue = repay;
            }else{
                view.repayOrOverdue = overdue;
            }
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)signAction{
    CreditSignViewController *view = [[CreditSignViewController alloc] init];
    view.urlDic = self.urlDic;
    view.money = self.creditModel.loanmoney;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)giveUpAction{
    __block typeof(self)wSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定放弃订单吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wSelf giveUpOrder];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:NULL];
}

-(void)questionAction{
    QuestionViewController *view = [[QuestionViewController alloc] init];
    view.webUrl = self.urlDic[@"help"];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)phoneAction{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"拨打客服电话：400 663 9066" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *serviceAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *telStr = [@"tel://" stringByAppendingString:@"4006639066"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
    }];
    [alertControl addAction:serviceAction];
    [alertControl addAction:phoneAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

-(void)reloadData{
    [self loadCreditInfo];
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
            self.totalMoney = model.credit_total_money;
            self.totalPeople = model.credit_total_num;
            switch (model.order_status) {
                case 1:
                {
                    if([self.creditModel.minMoney integerValue] == 0 && [self.creditModel.maxMoney integerValue] == 0 ){
                        [self.submitBtn setTitle:@"去借钱" forState:UIControlStateNormal];
                        self.submitBtn.backgroundColor = MessageColor;
                        self.submitBtn.enabled = NO;
                    }else{
                        [self.submitBtn setTitle:@"去借钱" forState:UIControlStateNormal];
                        self.submitBtn.backgroundColor = ButtonColor;
                        self.submitBtn.enabled = YES;
                    }
                    self.btnView.hidden = YES;
                    self.submitBtn.hidden = NO;
                }
                    break;
                case 2:
                {
                    [self.submitBtn setTitle:@"审核中请等待" forState:UIControlStateNormal];
                    self.submitBtn.backgroundColor = MessageColor;
                    self.submitBtn.enabled = NO;
                    self.btnView.hidden = YES;
                }
                    break;
                case 3:
                {
                    if(self.creditModel.is_late == 0){
                        [self.submitBtn setTitle:@"去还款" forState:UIControlStateNormal];
                        self.submitBtn.backgroundColor = ButtonColor;
                        self.submitBtn.enabled = YES;
                    }else{
                        [self.submitBtn setTitle:@"逾期，去还钱" forState:UIControlStateNormal];
                        self.submitBtn.backgroundColor = ButtonColor;
                        self.submitBtn.enabled = YES;
                    }
                    self.btnView.hidden = YES;
                    self.submitBtn.hidden = NO;
                }
                    break;
                case 4:
                {
                    self.submitBtn.hidden = YES;
                    self.btnView.hidden = NO;
                }
                    break;
                case 5:
                {
                    [self.submitBtn setTitle:@"已签约等待打款" forState:UIControlStateNormal];
                    self.submitBtn.backgroundColor = MessageColor;
                    self.submitBtn.enabled = NO;
                    self.btnView.hidden = YES;
                    self.submitBtn.hidden = NO;
                }
                    break;
                default:
                    break;
            }
        }
    } dic:dic noNetWork:nil];
}

-(void)loadH5{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"banner" forKey:@"_cmd_"];
    [dic setObject:@"credit" forKey:@"type"];
    
    [HomeApi html5WithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            self.urlDic = dict;
        }
    } dic:dic noNetWork:nil];
}

-(void)giveUpOrder{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"credit" forKey:@"_cmd_"];
    [dic setObject:@"give_up_order" forKey:@"type"];
    
    [CreditApi giveUpCreditWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            [self loadCreditInfo];
        }
    } dic:dic noNetWork:nil];
}
@end
