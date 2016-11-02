//
//  BorrowInfoViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BorrowInfoViewController.h"
#import "NavView.h"
#import "AgreeMentViewController.h"
#import "CreditYzmViewController.h"

@interface BorrowInfoViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSMutableArray *contentArr;
@property(nonatomic,strong)UIButton *agreementBtn;
@property(nonatomic,strong)UILabel *agreeLabel;
@end

@implementation BorrowInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentArr = [[NSMutableArray alloc] initWithObjects:@"",@"7元",@"先息后本",@"0.00元",@"25.00元",@"00.00元",@"25.00元", nil];
    [self statusBar];
    [self navView];
    
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.scrollEnabled = NO;
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, WidthXiShu(80), HeightXiShu(50))];
    title.font = HEITI(HeightXiShu(15));
    title.textColor = TitleColor;
    title.text = @[@"借多少",@"借多久",@"怎么还",@"周利息",@"手续费",@"平台管理费",@"总利息"][indexPath.row];
    [cell.contentView addSubview:title];
    
    if(indexPath.row == 0){
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(200), 0, WidthXiShu(200), HeightXiShu(50))];
        self.textField.placeholder = [NSString stringWithFormat:@"最多可借款%@元",self.model.maxMoney];
        self.textField.font = HEITI(HeightXiShu(14));
        self.textField.delegate = self;
        self.textField.textColor = TitleColor;
        self.textField.returnKeyType = UIReturnKeyDone;
        self.textField.textAlignment = NSTextAlignmentRight;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.text = self.contentArr[indexPath.row];
        [self.textField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [cell.contentView addSubview:self.textField];
    }else{
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(200), 0, WidthXiShu(200), HeightXiShu(50))];
        content.textAlignment = NSTextAlignmentRight;
        content.font = HEITI(HeightXiShu(15));
        content.textColor = MessageColor;
        if(indexPath.row == 1){
            NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:self.contentArr[indexPath.row]];
            [attStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(0, 1)];
            [attStr addAttribute:NSFontAttributeName value:HEITI(HeightXiShu(24)) range:NSMakeRange(0, 1)];
            content.attributedText = attStr;
        }else{
            content.text = self.contentArr[indexPath.row];
            if(indexPath.row == 2){
                content.textColor = ButtonColor;
            }
        }
        [cell.contentView addSubview:content];
    }
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(49), kScreenWidth-WidthXiShu(12), .5)];
    cutLine.backgroundColor = AllLightGrayColor;
    [cell.contentView addSubview:cutLine];
    return cell;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"信用贷";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [navView.rightBtn setImage:[GetImagePath getImagePath:@"credit_question"] forState:UIControlStateNormal];
        [navView.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.tableView.height-HeightXiShu(350))];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(20), HeightXiShu(15), WidthXiShu(160), HeightXiShu(20))];
        label1.text = @"可提前还款，手续费25/笔";
        label1.font = HEITI(HeightXiShu(13));
        label1.textColor = MessageColor;
        [footerView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(20), label1.maxY+HeightXiShu(2), WidthXiShu(27), HeightXiShu(20))];
        label2.text = @"同意";
        label2.font = HEITI(HeightXiShu(13));
        label2.textColor = MessageColor;
        label2.hidden = YES;
        [footerView addSubview:label2];
        _agreeLabel = label2;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(label2.maxX, label2.minY, WidthXiShu(80), HeightXiShu(20));
        [btn setTitle:@"贷款相关合同" forState:UIControlStateNormal];
        [btn setTitleColor:ButtonColor forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleLabel.font = HEITI(HeightXiShu(13));
        btn.hidden = YES;
        [btn addTarget:self action:@selector(contractAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
        _agreementBtn = btn;
        
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(WidthXiShu(12), btn.maxY+HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        submitBtn.titleLabel.font = HEITI(HeightXiShu(19));
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        submitBtn.backgroundColor = ButtonColor;
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:submitBtn];
        
        UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        phoneBtn.frame = CGRectMake((kScreenWidth-WidthXiShu(100))/2, footerView.height-HeightXiShu(20)-HeightXiShu(20), WidthXiShu(100), HeightXiShu(20));
        phoneBtn.titleLabel.font = HEITI(HeightXiShu(13));
        [phoneBtn addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
        [phoneBtn setTitle:@"400-663-9066" forState:UIControlStateNormal];
        [phoneBtn setTitleColor:PlaceholderColor forState:UIControlStateNormal];
        [footerView addSubview:phoneBtn];
        
        _footerView = footerView;
    }
    return _footerView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    
}

-(void)contractAction{
    __block typeof(self)wSelf = self;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *loaclAction = [UIAlertAction actionWithTitle:@"个人借款协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AgreeMentViewController *view = [[AgreeMentViewController alloc] init];
        view.webUrl = self.urlDic[@"creditagreement"];
        view.money = self.textField.text;
        [wSelf.navigationController pushViewController:view animated:YES];
    }];
    UIAlertAction *takeAction = [UIAlertAction actionWithTitle:@"居间服务协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AgreeMentViewController *view = [[AgreeMentViewController alloc] init];
        view.webUrl = self.urlDic[@"creditagreement2"];
        view.money = self.textField.text;
        [wSelf.navigationController pushViewController:view animated:YES];
    }];
    [alertControl addAction:cancelAction];
    [alertControl addAction:loaclAction];
    [alertControl addAction:takeAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

-(void)submitAction{
    if([self.textField.text isEqualToString:@""]){
        [self addAlertView:@"借款金额不能为空" block:nil];
        return;
    }
    
    CreditYzmViewController *view = [[CreditYzmViewController alloc] init];
    view.money = self.textField.text;
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

-(void)changeMoneyWithMoney:(NSString *)string{
    if([string floatValue] > [self.model.maxMoney floatValue]){
        [self addAlertView:[NSString stringWithFormat:@"金额不能大于%@",self.model.maxMoney] block:nil];
        return;
    }
    
    [self.contentArr replaceObjectAtIndex:0 withObject:string];
    NSString *money = string;
    if(![money isEqualToString:@""]){
        double val = [money intValue]*0.006;
        [self.contentArr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@元",[NSString stringWithFormat:@"%@",[StringTool roundFloat:val]]]];
        double newMoney =  [money intValue]*0.03;
        [self.contentArr replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%@元",[NSString stringWithFormat:@"%@",[StringTool roundFloat:newMoney]]]];
        double allMoney = [[StringTool roundFloat:val] floatValue] + [[StringTool roundFloat:newMoney] floatValue] +25;
        [self.contentArr replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%@元",[StringTool roundFloat:allMoney]]];
        self.agreementBtn.hidden = NO;
        self.agreeLabel.hidden = NO;
    }else{
        self.agreementBtn.hidden = YES;
        self.agreeLabel.hidden = YES;
    }
    [self.tableView reloadData];
}

#pragma  mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self changeMoneyWithMoney:textField.text];
}
@end
