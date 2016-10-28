//
//  RentApplyViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/25.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RentApplyViewController.h"
#import "NavView.h"
#import "RentApplyCell.h"
#import "PickerView.h"
#import "RentModel.h"
#import "RentApi.h"
#import "LoanDetailViewController.h"

@interface RentApplyViewController ()<RentApplyCellDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIImageView *headView;
@property(nonatomic,strong)NSMutableArray *contentArr;
@property(nonatomic,strong)UIView *secondSectionView;
@property(nonatomic,strong)UILabel *allMoney;
@property(nonatomic,strong)UILabel *peopleCount;
@property(nonatomic,strong)UILabel *rateLabel;
@property(nonatomic,copy)NSString *allMoneyStr;
@property(nonatomic,copy)NSString *peopleCountStr;
@property(nonatomic,copy)NSString *rateStr;
@property(nonatomic,strong)PickerView *dealerPickerView;
@property(nonatomic,strong)PickerView *paymentPickerView;
@property(nonatomic,strong)RentModel *rentModel;
@end

@implementation RentApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentArr = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    [self statusBar];
    [self navView];
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.backgroundColor = AllBackLightGratColor;
    [self loadRentInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 8;
    }else if (section == 1){
        return 1;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return HeightXiShu(50);
    }
    return HeightXiShu(148);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return HeightXiShu(10);
    }else if(section == 1){
        return HeightXiShu(190);
    }
    return HeightXiShu(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
        UIView *view = self.secondSectionView;
        return view;
    }else{
        return nil;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        static NSString* const identifier = @"RentApplyCell";
        RentApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[RentApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        NSString *title = @[@"贷款城市",@"经销商",@"车商报价",@"车辆品牌",@"车辆型号",@"借款期限",@"月需还款",@"首付金额"][indexPath.row];
        NSString *placeholder = @[@"请输入贷款城市",@"请选择经销商",@"请输入车商报价",@"请输入车辆品牌",@"请输入车辆型号",@"请选择借款期限",@"",@""][indexPath.row];
        NSString *content = self.contentArr[indexPath.row];
        cell.titleStr = title;
        cell.placeholderStr = placeholder;
        cell.contentStr = content;
        cell.indexPath = indexPath;
        if(indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7){
            cell.isShowLabel = YES;
        }else{
            cell.isShowLabel = NO;
            if(indexPath.row == 2){
                cell.keyBoardType = numberType;
            }else{
                cell.keyBoardType = stringType;
            }
        }
        
        if(indexPath.row == 2 || indexPath.row == 7){
            cell.detailLabelType = signType;
            cell.isShowDetailLanel = YES;
        }else if (indexPath.row == 6){
            cell.detailLabelType = doubleType;
            cell.isShowDetailLanel = YES;
        }else{
            cell.isShowDetailLanel = NO;
        }
        
        if(indexPath.row == 7){
            cell.isShowCutLine = NO;
        }else{
            cell.isShowCutLine = YES;
        }
        return cell;
    }else{
        static NSString* const identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        NSString *imageName = @[@"",@"rent_liucheng",@"rent_city"][indexPath.section];
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(148))];
        bgImageView.image = [GetImagePath getImagePath:imageName];
        [cell.contentView addSubview:bgImageView];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 1){
            [self dealerPickerView];
        }else if(indexPath.row == 5){
            [self paymentPickerView];
        }
    }
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"车租宝";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIImageView *)headView{
    if(!_headView){
        UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(131))];
        headView.image = [GetImagePath getImagePath:@"rent_banner"];
        _headView = headView;
    }
    return _headView;
}

-(UIView *)secondSectionView{
    if(!_secondSectionView){
        UIView *secondSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(190))];
        secondSectionView.backgroundColor = AllBackLightGratColor;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(20), kScreenWidth-WidthXiShu(24), HeightXiShu(15))];
        titleLabel.text = @"计算结果仅供参考，实际费用请以还款计划为准！";
        titleLabel.font = HEITI(HeightXiShu(12));
        titleLabel.textColor = MessageColor;
        [secondSectionView addSubview:titleLabel];
        
        UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        applyBtn.frame = CGRectMake(WidthXiShu(12), titleLabel.maxY+HeightXiShu(22),kScreenWidth-WidthXiShu(24) , HeightXiShu(50));
        applyBtn.backgroundColor = ButtonColor;
        [applyBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        applyBtn.layer.masksToBounds = YES;
        applyBtn.layer.cornerRadius = HeightXiShu(5);
        [applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
        [secondSectionView addSubview:applyBtn];
        
        UILabel *allMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, applyBtn.maxY+HeightXiShu(20), kScreenWidth, HeightXiShu(15))];
        allMoney.textColor = TitleColor;
        allMoney.textAlignment = NSTextAlignmentCenter;
        allMoney.font = HEITI(HeightXiShu(12));
        [secondSectionView addSubview:allMoney];
        
        UILabel *peopleCount = [[UILabel alloc] initWithFrame:CGRectMake(0, allMoney.maxY+HeightXiShu(4), kScreenWidth, HeightXiShu(15))];
        peopleCount.textColor = TitleColor;
        peopleCount.textAlignment = NSTextAlignmentCenter;
        peopleCount.font = HEITI(HeightXiShu(12));
        [secondSectionView addSubview:peopleCount];
        
        UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, peopleCount.maxY+HeightXiShu(4), kScreenWidth, HeightXiShu(15))];
        rateLabel.textColor = TitleColor;
        rateLabel.textAlignment = NSTextAlignmentCenter;
        rateLabel.font = HEITI(HeightXiShu(12));
        [secondSectionView addSubview:rateLabel];
        
        _allMoney = allMoney;
        _peopleCount = peopleCount;
        _rateLabel = rateLabel;
        _secondSectionView = secondSectionView;
    }
    return _secondSectionView;
}

-(PickerView *)paymentPickerView{
    if(!_paymentPickerView){
        PickerView *paymentPickerView = [[PickerView alloc] initWithTitle:CGRectMake(0, 0, self.view.width, self.view.height) title:@"借款期限" dataArr:self.rentModel.firstPercentArr];
        __block typeof(self)wSelf = self;
        paymentPickerView.cancelBlock = ^(void){
            [wSelf.paymentPickerView removeFromSuperview];
            wSelf.paymentPickerView = nil;
        };
        paymentPickerView.finshBlock = ^(NSInteger index){
            [wSelf.paymentPickerView removeFromSuperview];
            wSelf.paymentPickerView = nil;
            [wSelf changeMoneyWithPayment:index];
        };
        [self.view addSubview:paymentPickerView];
        _paymentPickerView = paymentPickerView;
    }
    return _paymentPickerView;
}

-(PickerView *)dealerPickerView{
    if(!_dealerPickerView){
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [self.rentModel.dealersArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arr addObject:obj[@"name"]];
        }];
        PickerView *dealerPickerView = [[PickerView alloc] initWithTitle:CGRectMake(0, 0, self.view.width, self.view.height) title:@"经销商" dataArr:arr];
        __block typeof(self)wSelf = self;
        dealerPickerView.cancelBlock = ^(void){
            [wSelf.dealerPickerView removeFromSuperview];
            wSelf.dealerPickerView = nil;
        };
        dealerPickerView.finshBlock = ^(NSInteger index){
            [wSelf.dealerPickerView removeFromSuperview];
            wSelf.dealerPickerView = nil;
            [wSelf changeDealer:index];
        };
        [self.view addSubview:dealerPickerView];
        _dealerPickerView = dealerPickerView;
    }
    return _dealerPickerView;
}

#pragma  mark - setter
-(void)setAllMoneyStr:(NSString *)allMoneyStr{
    _allMoneyStr = allMoneyStr;
    NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"贷款总额 %@",allMoneyStr]];
    [attStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(5,allMoneyStr.length)];
    self.allMoney.attributedText = attStr;
}

-(void)setPeopleCountStr:(NSString *)peopleCountStr{
    _peopleCountStr = peopleCountStr;
    NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"正在申请 %@",peopleCountStr]];
    [attStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(5, peopleCountStr.length)];
    self.peopleCount.attributedText = attStr;
}

-(void)setRateStr:(NSString *)rateStr{
    _rateStr = rateStr;
    NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"费率 %@",rateStr]];
    [attStr addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(3, rateStr.length)];
    self.rateLabel.attributedText = attStr;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)applyAction{
    if([self.contentArr[0] isEqualToString:@""]){
        [self addAlertView:@"请填写城市" block:nil];
        return;
    }
    
    if([self.contentArr[1] isEqualToString:@""]){
        [self addAlertView:@"请选择经销商" block:nil];
        return;
    }
    
    if([self.contentArr[2] isEqualToString:@""]){
        [self addAlertView:@"请填写贷款金额" block:nil];
        return;
    }
    
    if([self.contentArr[3] isEqualToString:@""]){
        [self addAlertView:@"请填写车辆品牌" block:nil];
        return;
    }
    
    if([self.contentArr[4] isEqualToString:@""]){
        [self addAlertView:@"请填写车辆型号" block:nil];
        return;
    }
    
    if([self.contentArr[5] isEqualToString:@""]){
        [self addAlertView:@"请选择贷款期限" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.contentArr[0] forKey:@"city"];
    [dic setObject:self.contentArr[1] forKey:@"dealer"];
    [dic setObject:self.contentArr[2] forKey:@"loanmoney"];
    [dic setObject:self.contentArr[3] forKey:@"car_brand"];
    [dic setObject:self.contentArr[4] forKey:@"car_class"];
    [dic setObject:self.contentArr[5] forKey:@"loanmonth"];
    [dic setObject:self.contentArr[6] forKey:@"monthMoney"];
    [dic setObject:self.contentArr[7] forKey:@"firstMoney"];
    
    LoanDetailViewController *view = [[LoanDetailViewController alloc] init];
    view.dict = dic;
    view.loanOrRent = rentType;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)changeMoneyWithPayment:(NSInteger)index{
    [self.contentArr replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%@期",self.rentModel.percentArr[index]]];
    
    NSString *money = self.contentArr[2];
    NSString *time =  self.contentArr[5];
    
    if(![money isEqualToString:@""] && ![time isEqualToString:@""]){
        //首付金额
        double firstMoney = [money intValue]*0.3;
        [self.contentArr replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%@",[StringTool roundFloat:firstMoney]]];
        
        //月需还款
        double val = [money intValue]*0.006*[time intValue]+[money intValue];
        double newMoney =  val/[time intValue];
        [self.contentArr replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%@",[StringTool roundFloat:newMoney]]];
    }
    
    [self.tableView reloadData];
}

-(void)changeMoneyWithMoney:(NSString *)string{
    if([string floatValue] < 30000){
        [self addAlertView:@"金额不能小于3万" block:nil];
        return;
    }
    
    if([string floatValue] > 500000){
        [self addAlertView:@"金额不能大于50万" block:nil];
        return;
    }
    
    [self.contentArr replaceObjectAtIndex:2 withObject:string];
    NSString *money = self.contentArr[2];
    NSString *time =  self.contentArr[5];
    
    if(![money isEqualToString:@""] && ![time isEqualToString:@""]){
        //首付金额
        double firstMoney = [money intValue]*0.3;
        [self.contentArr replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%@",[StringTool roundFloat:firstMoney]]];
        
        //月需还款
        double val = [money intValue]*0.006*[time intValue]+[money intValue];
        double newMoney =  val/[time intValue];
        [self.contentArr replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%@",[StringTool roundFloat:newMoney]]];
    }
    [self.tableView reloadData];
}

-(void)changeDealer:(NSInteger)index{
    [self.contentArr replaceObjectAtIndex:1 withObject:self.rentModel.dealersArr[index][@"name"]];
    [self.tableView reloadData];
}

#pragma mark - LoanTableViewCellDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField indexRow:(NSInteger)indexRow{
    if(indexRow == 2){
        [self changeMoneyWithMoney:textField.text];
    }else{
        [self.contentArr replaceObjectAtIndex:indexRow withObject:textField.text];
        [self.tableView reloadData];
    }
}

#pragma mark - 接口
-(void)loadRentInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"order" forKey:@"_cmd_"];
    [dic setObject:@"setting" forKey:@"type"];
    
    [RentApi rentInfoWithBlock:^(RentModel *model, NSError *error) {
        if(!error){
            self.rentModel = model;
            self.allMoneyStr = [NSString stringWithFormat:@"%@元",model.buy_money];
            self.peopleCountStr = [NSString stringWithFormat:@"%@人",model.buy_count];
            self.rateStr = [model.month_point stringByAppendingString:@"%月"];
        }
    } dic:dic noNetWork:nil];
}
@end
