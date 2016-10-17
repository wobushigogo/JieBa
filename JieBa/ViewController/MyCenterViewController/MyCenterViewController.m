//
//  MyCenterViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyCenterHead.h"

@interface MyCenterViewController ()
@property(nonatomic,strong)MyCenterHead *headView;
-(UIView *)cellViewWithMainImg:(NSString *)mainImgName mainText:(NSString *)mainText subText:(NSString *)subText buttonName1:(NSString *)buttonName1 buttonName2:(NSString *)buttonName2 selector1:(SEL)selector1 selector2:(SEL)selector2 stingOrImage:(BOOL)stingOrImage;
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:0 maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0 || section == 1 || section == 2){
        return 1;
    }else if (section == 3){
        return 4;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2){
        return HeightXiShu(80);
    }
    return HeightXiShu(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 0;
    }
    return HeightXiShu(22);
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CGFloat const height = [self tableView:tableView heightForHeaderInSection:section];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
//    view.backgroundColor = AllBackLightGratColor;
//    
//    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(4), WidthXiShu(2), HeightXiShu(14))];
//    cutLine.backgroundColor = ButtonColor;
//    [view addSubview:cutLine];
//    
//    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(27), 0, WidthXiShu(60), height)];
//    typeLabel.font = HEITI(HeightXiShu(15));
//    typeLabel.text = @"我与借吧";
//    typeLabel.textColor = TitleColor;
//    typeLabel.font = HEITI(HeightXiShu(12));
//    [view addSubview:typeLabel];
//    
//    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    moreBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(92), 0, WidthXiShu(80), height);
//    [moreBtn setTitle:@"查看更多》" forState:UIControlStateNormal];
//    [moreBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
//    moreBtn.titleLabel.font = HEITI(HeightXiShu(10));
//    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [view addSubview:moreBtn];
//    return view;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2){
        NSString *imgName = @[@"myCenter_ balance",@"myCenter_ order",@"myCenter_center"][indexPath.section];
        NSString *mainText = @[@"账户余额",@"我的订单",@"个人中心"][indexPath.section];
        NSString *buttonName1 = @[@"充值",[NSString stringWithFormat:@"待评价  %d",0],@"实名认证"][indexPath.section];
        NSString *buttonName2 = @[@"体现",@"已评价",@"绑定银行卡"][indexPath.section];
        NSString *selector1 = @[@"creditAction",@"evaluateAction",@"approveAction"][indexPath.section];
        NSString *selector2 = @[@"withdrawAction",@"evaluateEndAction",@"bindAction"][indexPath.section];
        
        BOOL isString = nil;
        if(indexPath.section == 0){
            isString = YES;
        }else{
            isString = NO;
        }
        UIView *view = [self cellViewWithMainImg:imgName mainText:mainText subText:@"1000.00元" buttonName1:buttonName1 buttonName2:buttonName2 selector1:NSSelectorFromString(selector1) selector2:NSSelectorFromString(selector2) stingOrImage:isString];
        [cell addSubview:view];
    }
    return cell;
}

#pragma mark - 页面元素
-(MyCenterHead *)headView{
    if(!_headView){
        MyCenterHead *headView = [[MyCenterHead alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(210))];
        _headView = headView;
    }
    return _headView;
}

#pragma mark - 创建前3个view
-(UIView *)cellViewWithMainImg:(NSString *)mainImgName mainText:(NSString *)mainText subText:(NSString *)subText buttonName1:(NSString *)buttonName1 buttonName2:(NSString *)buttonName2 selector1:(SEL)selector1 selector2:(SEL)selector2 stingOrImage:(BOOL)stingOrImage{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(80))];
    UIView *cutLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, .5)];
    cutLine.backgroundColor = AllLightGrayColor;
    [view addSubview:cutLine];
    [cutLine setMaxX:view.width maxY:view.halfHeight];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(10), WidthXiShu(19), HeightXiShu(19))];
    imageView.image = [GetImagePath getImagePath:mainImgName];
    [view addSubview:imageView];
    
    UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(53), 0, WidthXiShu(150), HeightXiShu(40))];
    mainLabel.font = HEITI(HeightXiShu(14));
    mainLabel.text = mainText;
    mainLabel.textColor = TitleColor;
    [view addSubview:mainLabel];
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(10)-WidthXiShu(100), 0, WidthXiShu(100), HeightXiShu(40))];
    subLabel.font = HEITI(HeightXiShu(14));
    subLabel.text = subText;
    subLabel.textColor = TitleColor;
    subLabel.hidden  = !stingOrImage;
    subLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:subLabel];
    
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(16), HeightXiShu(15), WidthXiShu(6), HeightXiShu(10))];
    arrowImgView.backgroundColor = [UIColor purpleColor];
    arrowImgView.hidden  = stingOrImage;
    [view addSubview:arrowImgView];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:buttonName1 forState:UIControlStateNormal];
    [button1 setTitleColor:TitleColor forState:UIControlStateNormal];
    button1.titleLabel.font = HEITI(HeightXiShu(14));
    button1.frame = CGRectMake(0, HeightXiShu(40), kScreenWidth/2-1, HeightXiShu(40));
    [button1 addTarget:self action:selector1 forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:buttonName2 forState:UIControlStateNormal];
    [button2 setTitleColor:TitleColor forState:UIControlStateNormal];
    button2.titleLabel.font = HEITI(HeightXiShu(14));
    button2.frame = CGRectMake(kScreenWidth/2+1, HeightXiShu(40), kScreenWidth/2-1, HeightXiShu(40));
    [button2 addTarget:self action:selector2 forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    
    UIImageView *cutLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2, HeightXiShu(40), .5, HeightXiShu(40))];
    cutLine2.backgroundColor = AllLightGrayColor;
    [view addSubview:cutLine2];
    return view;
}

#pragma mark - selector
-(void)creditAction{
    NSLog(@"creditAction");
}

-(void)withdrawAction{
    NSLog(@"withdrawAction");
}

-(void)evaluateAction{
    NSLog(@"evaluateAction");
}

-(void)evaluateEndAction{
    NSLog(@"evaluateEndAction");
}

-(void)approveAction{
    NSLog(@"approveAction");
}

-(void)bindAction{
    NSLog(@"bindAction");
}
@end
