//
//  LoanViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "LoanViewController.h"
#import "NavView.h"
#import "LoanTableViewCell.h"
#import "PickerView.h"

#define NoSelectButtonColor RGBCOLOR(207, 207, 207)

@interface LoanViewController ()<LoanTableViewCellDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIImageView *headView;
@property(nonatomic,strong)UIView *firstSectionView;
@property(nonatomic,strong)UIView *secondSectionView;
@property(nonatomic,strong)UIButton *personalBtn;
@property(nonatomic,strong)UIButton *companyBtn;
@property(nonatomic,strong)NSMutableArray *contentArr;
@property(nonatomic,strong)NSMutableArray *timeArr;
@property(nonatomic,strong)PickerView *pickerView;
@property(nonatomic,strong)UILabel *allMoney;
@property(nonatomic,strong)UILabel *peopleCount;
@property(nonatomic,copy)NSString *allMoneyStr;
@property(nonatomic,copy)NSString *peopleCountStr;
@end

@implementation LoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentArr = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"", nil];
    self.timeArr = [[NSMutableArray alloc] initWithObjects:@"1月",@"2月",@"3月",@"12月", nil];
    [self statusBar];
    [self navView];
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.backgroundColor = AllBackLightGratColor;
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
        navView.titleLabel.text = @"车贷宝";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIImageView *)headView{
    if(!_headView){
        UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(127))];
        headView.image = [GetImagePath getImagePath:@"loan_banner"];
        _headView = headView;
    }
    return _headView;
}

-(UIView *)firstSectionView{
    if(!_firstSectionView){
        UIView *firstSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(77))];
        firstSectionView.backgroundColor = AllBackLightGratColor;
        
        UIButton *personalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        personalBtn.frame = CGRectMake(WidthXiShu(15), HeightXiShu(23), WidthXiShu(167), HeightXiShu(42));
        [personalBtn setTitle:@"个人车" forState:UIControlStateNormal];
        personalBtn.titleLabel.font = HEITI(HeightXiShu(16));
        personalBtn.backgroundColor = ButtonColor;
        personalBtn.layer.masksToBounds = YES;
        personalBtn.layer.cornerRadius = HeightXiShu(5);
        personalBtn.tag = 0;
        [personalBtn addTarget:self action:@selector(firstSectionAction:) forControlEvents:UIControlEventTouchUpInside];
        [firstSectionView addSubview:personalBtn];
        
        UIButton *companyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        companyBtn.frame = CGRectMake(personalBtn.maxX+WidthXiShu(10), HeightXiShu(23), WidthXiShu(167), HeightXiShu(42));
        [companyBtn setTitle:@"公司车" forState:UIControlStateNormal];
        [companyBtn setTitleColor:MessageColor forState:UIControlStateNormal];
        companyBtn.titleLabel.font = HEITI(HeightXiShu(16));
        companyBtn.backgroundColor = NoSelectButtonColor;
        companyBtn.layer.masksToBounds = YES;
        companyBtn.layer.cornerRadius = HeightXiShu(5);
        companyBtn.tag = 1;
        [companyBtn addTarget:self action:@selector(firstSectionAction:) forControlEvents:UIControlEventTouchUpInside];
        [firstSectionView addSubview:companyBtn];
        
        _personalBtn = personalBtn;
        _companyBtn = companyBtn;
        _firstSectionView = firstSectionView;
    }
    return _firstSectionView;
}

-(UIView *)secondSectionView{
    if(!_secondSectionView){
        UIView *secondSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(170))];
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
        
        _allMoney = allMoney;
        _peopleCount = peopleCount;
        _secondSectionView = secondSectionView;
        
        self.allMoneyStr = @"123412342134124元";
        self.peopleCountStr = @"3000人";
    }
    return _secondSectionView;
}

-(PickerView *)pickerView{
    if(!_pickerView){
        PickerView *pickerView = [[PickerView alloc] initWithTitle:CGRectMake(0, 0, self.view.width, self.view.height) title:@"借款期限" dataArr:self.timeArr];
        __block typeof(self)wSelf = self;
        pickerView.cancelBlock = ^(void){
            [wSelf.pickerView removeFromSuperview];
            wSelf.pickerView = nil;
        };
        pickerView.finshBlock = ^(NSInteger index){
            [wSelf.pickerView removeFromSuperview];
            wSelf.pickerView = nil;
            [wSelf changeMoneyWithTime:index];
        };
        [self.view addSubview:pickerView];
        _pickerView = pickerView;
    }
    return _pickerView;
}

#pragma mark - tableView delegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 4;
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
        return HeightXiShu(77);
    }else if(section == 1){
        return HeightXiShu(170);
    }
    return HeightXiShu(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *view = self.firstSectionView;
        return view;
    }else if(section == 1){
        UIView *view = self.secondSectionView;
        return view;
    }else{
        return nil;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        static NSString* const identifier = @"LoanTableViewCell";
        LoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[LoanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        NSString *title = @[@"贷款城市",@"贷款金额",@"借款期限",@"月需还款"][indexPath.row];
        NSString *placeholder = @[@"请输入贷款城市",@"请输入贷款金额（3~50万）",@"请选择借款期限",@"0.00"][indexPath.row];
        NSString *content = self.contentArr[indexPath.row];
        cell.titleStr = title;
        cell.placeholderStr = placeholder;
        cell.contentStr = content;
        cell.indexPath = indexPath;
        if(indexPath.row == 0 || indexPath.row == 1){
            cell.isShowLabel = NO;
            if(indexPath.row == 0){
                cell.keyBoardType = stringType;
            }else{
                cell.keyBoardType = numberType;
            }
        }else{
            cell.isShowLabel = YES;
        }
        
        if(indexPath.row == 3){
            cell.isShowCutLine = NO;
            cell.isShowDetailLanel = YES;
        }else{
            cell.isShowCutLine = YES;
            cell.isShowDetailLanel = NO;
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
        NSString *imageName = @[@"",@"loan_liucheng",@"loan_city"][indexPath.section];
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(148))];
        bgImageView.image = [GetImagePath getImagePath:imageName];
        [cell.contentView addSubview:bgImageView];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 2){
            [self pickerView];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight;
    sectionHeaderHeight = HeightXiShu(170);
    if (scrollView == self.tableView) {
        //去掉UItableview的section的headerview黏性
        if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

#pragma mark - 事件
-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)firstSectionAction:(UIButton *)button{
    switch (button.tag) {
        case 0:
        {
            [self.personalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.companyBtn setTitleColor:MessageColor forState:UIControlStateNormal];
            self.personalBtn.backgroundColor = ButtonColor;
            self.companyBtn.backgroundColor = NoSelectButtonColor;
        }
            break;
        case 1:
        {
            [self.personalBtn setTitleColor:MessageColor forState:UIControlStateNormal];
            [self.companyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.personalBtn.backgroundColor = NoSelectButtonColor;
            self.companyBtn.backgroundColor = ButtonColor;
        }
            break;
        default:
            break;
    }
}

-(void)changeMoneyWithTime:(NSInteger)index{
    [self.contentArr replaceObjectAtIndex:2 withObject:self.timeArr[index]];
    NSString *money = self.contentArr[1];
    NSString *time =  self.contentArr[2];
    if(![money isEqualToString:@""] && ![time isEqualToString:@""]){
        double val = pow((1+0.006), [time intValue]);
        double newMoney =  ([money intValue]*0.006*val)/(val-1);
        [self.contentArr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@",[StringTool roundFloat:newMoney]]];
    }
    [self.tableView reloadData];
}

-(void)changeMoneyWithMoney:(NSString *)string{
    [self.contentArr replaceObjectAtIndex:1 withObject:string];
    NSString *money = self.contentArr[1];
    NSString *time =  self.contentArr[2];
    if(![money isEqualToString:@""] && ![time isEqualToString:@""]){
        double val = pow((1+0.006), [time intValue]);
        double newMoney =  ([money intValue]*0.006*val)/(val-1);
        [self.contentArr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@",[StringTool roundFloat:newMoney]]];
    }
    [self.tableView reloadData];
}

#pragma mark - LoanTableViewCellDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField indexRow:(NSInteger)indexRow{
    if(indexRow == 0){
        [self.contentArr replaceObjectAtIndex:0 withObject:textField.text];
        [self.tableView reloadData];
    }else{
        [self changeMoneyWithMoney:textField.text];
    }
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
@end
