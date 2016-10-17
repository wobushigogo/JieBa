//
//  MainViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MainViewController.h"
#import "ZWAdView.h"
#import "MainButtonCell.h"
#import "InvitationCell.h"
#import "HomeApi.h"
#import "BannerModel.h"
#import "LocationView.h"
#import "BannerViewController.h"

@interface MainViewController ()<ZWAdViewDelagate>
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIButton *scanBtn;
@property(nonatomic,strong)ZWAdView *zwAdView;
@property(nonatomic,strong)LocationView *loactionView;
@property(nonatomic,strong)NSMutableArray *bannerModels;
@property(nonatomic,strong)NSMutableArray *invitationModels;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:0 maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
    [self loadBanner];
    [self loadCarlife];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return HeightXiShu(196);
    }
    return HeightXiShu(133);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1){
        return HeightXiShu(22);
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat const height = [self tableView:tableView heightForHeaderInSection:section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    view.backgroundColor = AllBackLightGratColor;
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(4), WidthXiShu(2), HeightXiShu(14))];
    cutLine.backgroundColor = ButtonColor;
    [view addSubview:cutLine];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(27), 0, WidthXiShu(60), height)];
    typeLabel.font = HEITI(HeightXiShu(15));
    typeLabel.text = @"我与借吧";
    typeLabel.textColor = TitleColor;
    typeLabel.font = HEITI(HeightXiShu(12));
    [view addSubview:typeLabel];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(92), 0, WidthXiShu(80), height);
    [moreBtn setTitle:@"查看更多》" forState:UIControlStateNormal];
    [moreBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
    moreBtn.titleLabel.font = HEITI(HeightXiShu(10));
    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [view addSubview:moreBtn];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        MainButtonCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MainButtonCell"];
        if (!cell) {
            cell=[[MainButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainButtonCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        InvitationCell* cell=[tableView dequeueReusableCellWithIdentifier:@"InvitationCell"];
        if (!cell) {
            cell=[[InvitationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InvitationCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.modelsArr = self.invitationModels;
        return cell;
    }
}

#pragma mark - 页面元素
-(UIView *)headView{
    if(!_headView){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(295))];
        ZWAdView *zwAdView=[[ZWAdView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , HeightXiShu(295))];
        zwAdView.delegate=self;
        /**广告链接*/
        //AdDataModel * dataModel = [AdDataModel adDataModelWithImageName];
        //_zwAdView.adDataArray=[NSMutableArray arrayWithArray:dataModel.imageNameArray];
        //_zwAdView.pageControlPosition=ZWPageControlPosition_BottomCenter;/**设置圆点的位置*/
        //_zwAdView.hidePageControl=NO;/**设置圆点是否隐藏*/
        zwAdView.adAutoplay=YES;/**自动播放*/
        zwAdView.adPeriodTime=4.0;/**时间间隔*/
        zwAdView.pageControlPosition=ZWPageControlPosition_BottomCenter;
        //_zwAdView.placeImageSource=@"banner_mobile_3";/**设置默认广告*/
        //[_zwAdView loadAdDataThenStart];
        [headView addSubview:zwAdView];
        
        LocationView *locationView = [[LocationView alloc] initWithFrame:CGRectMake(WidthXiShu(113), HeightXiShu(30), kScreenWidth-WidthXiShu(226), HeightXiShu(23))];
        [headView addSubview:locationView];
        
        UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        scanBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(12)-WidthXiShu(22), HeightXiShu(30), WidthXiShu(22), HeightXiShu(22));
        [scanBtn setImage:[GetImagePath getImagePath:@"homePage_scan"] forState:UIControlStateNormal];
        [headView addSubview:scanBtn];
        
        _zwAdView = zwAdView;
        _headView = headView;
        _loactionView = locationView;
        _scanBtn = scanBtn;
    }
    return _headView;
}

#pragma mark - ZWAdViewDelagate
-(void)adView:(ZWAdView *)adView didDeselectAdAtNum:(NSInteger)num{
    BannerModel *model = self.bannerModels[num];
    BannerViewController *view = [[BannerViewController alloc] init];
    view.webUrl = model.htmlUrl;
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 接口
-(void)loadBanner{
    [HomeApi bannerListWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            self.bannerModels = array;
            NSMutableArray *urls = [NSMutableArray array];
            [self.bannerModels enumerateObjectsUsingBlock:^( BannerModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [urls addObject:obj.bannerUrl];
            }];
            
            self.zwAdView.adDataArray = urls;
            
            if(urls.count == 0 || urls.count == 1){
                self.zwAdView.adScrollView.scrollEnabled = NO;
                self.zwAdView.adAutoplay=NO;/**自动播放*/
                self.zwAdView.hidePageControl=YES;/**设置圆点是否隐藏*/
            }else{
                self.zwAdView.adScrollView.scrollEnabled = YES;
                self.zwAdView.adAutoplay=YES;/**自动播放*/
                self.zwAdView.hidePageControl=NO;/**设置圆点是否隐藏*/
            }
            
            [self.zwAdView loadAdDataThenStart];
        }
    } dic:[@{@"_cmd_":@"banner"} mutableCopy] noNetWork:nil];
}

-(void)loadCarlife{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"carlife" forKey:@"_cmd_"];
    [dic setObject:@"list" forKey:@"type"];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"10" forKey:@"number"];
    [dic setObject:@"1" forKey:@"is_cream"];
    [HomeApi carlifeListWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            self.invitationModels = array;
            [self.tableView reloadData];
        }
    } dic:dic noNetWork:nil];
}
@end
