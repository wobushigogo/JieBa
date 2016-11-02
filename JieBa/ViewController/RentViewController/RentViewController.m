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
    self.tabBarController.tabBar.hidden = NO;
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
        imageView.image = [GetImagePath getImagePath:@"credit_banner"];
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
        
        _submitBtn = submitBtn;
    }
    return _submitBtn;
}

-(UIView *)btnView{
    if(!_btnView){
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.maxY+HeightXiShu(30), kScreenWidth, HeightXiShu(50))];
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
        questionBtn.frame = CGRectMake((kScreenWidth-WidthXiShu(60))/2, self.submitBtn.maxY+HeightXiShu(130), WidthXiShu(60), HeightXiShu(20));
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

#pragma mark - 事件
-(void)rightAction{
    CreditListViewController *view = [[CreditListViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)submitAction{
    [self loadNameStatus:^(NSDictionary *dict) {
        if(dict[@"fuyou_login_id"]){
        
        }
    }];
    BorrowInfoViewController *view = [[BorrowInfoViewController alloc] init];
    view.model = self.creditModel;
    view.urlDic = self.urlDic;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)signAction{
    
}

-(void)giveUpAction{
    
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

-(void)loadNameStatus:(void(^)(NSDictionary *dict))block{
    __block typeof(self)wSelf = self;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_changeuserinfo" forKey:@"_cmd_"];
    [dic setObject:@"member_info" forKey:@"type"];
    [MyCenterApi getUserInfoWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
            if([dict[@"openFuyouStatus"] integerValue] == 1){
                if(block){
                    block(dict);
                }
            }else{
                [wSelf isBindCard];
            }
        }
    } dic:dic noNetWork:nil];
}

-(void)isBindCard{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"cash" forKey:@"_cmd_"];
    [dic setObject:@"1" forKey:@"money"];
    [dic setObject:@"cash_in" forKey:@"type"];
    
    [MyCenterApi addCashWithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            AddCashViewController *view = [[AddCashViewController alloc] init];
            view.webUrl = dict[@"jumpurl"];
            view.dic = dict;
            [self.navigationController pushViewController:view animated:YES];
        }
    } dic:dic noNetWork:nil];
}
@end
