//
//  ChangePhoneViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/20.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"

@interface ChangePhoneViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *headView;
@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(60), HeightXiShu(50))];
    title.text = @"手     机";
    title.font = HEITI(HeightXiShu(15));
    title.textColor = TitleColor;
    [cell.contentView addSubview:title];
    
    NSString *mobile = [LoginSqlite getdata:@"phone"];
    mobile = [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(title.maxX+WidthXiShu(22), 0, kScreenWidth-(title.maxX+WidthXiShu(22))-WidthXiShu(30), HeightXiShu(50))];
    phoneLabel.font = HEITI(HeightXiShu(14));
    phoneLabel.textColor = TitleColor;
    phoneLabel.text = mobile;
    [cell.contentView addSubview:phoneLabel];
    return cell;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"修改手机号";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)headView{
    if(!_headView){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(62))];
        
        UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(24), WidthXiShu(19), HeightXiShu(19))];
        smallImageView.image = [GetImagePath getImagePath:@"register_select"];
        [headView addSubview:smallImageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12)+smallImageView.maxX, HeightXiShu(24), WidthXiShu(155), HeightXiShu(20))];
        title.text = @"已认证，如需修改请联系";
        title.textColor = TitleColor;
        title.font = HEITI(HeightXiShu(14));
        [headView addSubview:title];
        
        UIButton *serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        serviceBtn.frame = CGRectMake(title.maxX, HeightXiShu(24), WidthXiShu(60), HeightXiShu(20));
        [serviceBtn setTitle:@"客服" forState:UIControlStateNormal];
        [serviceBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
        serviceBtn.titleLabel.font = HEITI(HeightXiShu(14));
        serviceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [serviceBtn addTarget:self action:@selector(serviceAction) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:serviceBtn];
        _headView = headView;
    }
    return _headView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)serviceAction{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *serviceAction = [UIAlertAction actionWithTitle:@"在线客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:@"客服电话：400 663 9066" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *telStr = [@"tel://" stringByAppendingString:@"4006639066"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertControl addAction:serviceAction];
    [alertControl addAction:phoneAction];
    [alertControl addAction:cancelAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}
@end
