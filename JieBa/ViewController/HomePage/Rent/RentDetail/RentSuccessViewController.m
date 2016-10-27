//
//  RentSuccessViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/27.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RentSuccessViewController.h"
#import "NavView.h"

#define placeholderFont HEITI(HeightXiShu(15))
#define titleMargin WidthXiShu(22)
#define titleWidth WidthXiShu(80)

@interface RentSuccessViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIView *footerView;
@end

@implementation RentSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
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
    
    if(indexPath.row !=10){
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), 0, titleWidth, HeightXiShu(50))];
        title.font = placeholderFont;
        title.textColor = TitleColor;
        title.text = @[@"申 请 人",@"联系电话",@"贷款城市",@"经销商",@"车商报价",@"车辆品牌",@"车辆型号",@"借款期限",@"月需还款",@"首付金额"][indexPath.row];
        [cell.contentView addSubview:title];
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, WidthXiShu(180), HeightXiShu(50))];
        content.text = self.contentArr[indexPath.row];
        content.font = placeholderFont;
        content.textColor = TitleColor;
        [cell.contentView addSubview:content];
        
        if(indexPath.row == 8){
            UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(40), 0, WidthXiShu(40), HeightXiShu(50))];
            detail.textColor = TitleColor;
            detail.textAlignment = NSTextAlignmentRight;
            detail.text = @"元/月";
            detail.font = placeholderFont;
            [cell.contentView addSubview:detail];
        }
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(49), kScreenWidth-WidthXiShu(12), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [cell.contentView addSubview:cutLine];
    }else{
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
        title.textColor = MessageColor;
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"计算结果仅供参考，实际费用请以还款计算为准！";
        title.font = HEITI(HeightXiShu(14));
        [cell.contentView addSubview:title];
    }
    
    return cell;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)headView{
    if(!_headView){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(160))];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, HeightXiShu(10), kScreenWidth, HeightXiShu(140))];
        contentView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:contentView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(40), kScreenWidth, HeightXiShu(30))];
        title.text = @"提交成功";
        title.font = HEITI(HeightXiShu(28));
        title.textColor = ButtonColor;
        title.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:title];
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, title.maxY+HeightXiShu(10), kScreenWidth, HeightXiShu(20))];
        message.text = @"恭喜您已申请成功，我们的工作人员会尽快与您联系";
        message.textColor = MessageColor;
        message.font = HEITI(HeightXiShu(15));
        message.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:message];
        
        _headView = headView;
    }
    return _headView;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(95))];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(45), kScreenWidth, HeightXiShu(20))];
        title.text = @"如有疑问,请拨打免费客服热线";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = MessageColor;
        title.font = HEITI(HeightXiShu(14));
        [footerView addSubview:title];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kScreenWidth-WidthXiShu(100))/2, title.maxY+HeightXiShu(5), WidthXiShu(100), HeightXiShu(20));
        [btn setTitle:@"400-663-9066" forState:UIControlStateNormal];
        [btn setTitleColor:ButtonColor forState:UIControlStateNormal];
        btn.titleLabel.font = HEITI(HeightXiShu(14));
        [btn addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
        
        _footerView = footerView;
    }
    return _footerView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
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

@end
