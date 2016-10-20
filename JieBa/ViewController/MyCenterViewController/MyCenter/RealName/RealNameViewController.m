//
//  RealNameViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/20.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RealNameViewController.h"
#import "NavView.h"
#import "CustomCameraViewController.h"

@interface RealNameViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIImageView *bigImageView;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UIButton *realBtn;
@end

@implementation RealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self bigImageView];
    [self messageLabel];
    [self realBtn];
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
        navView.titleLabel.text = @"身份证识别";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIImageView *)bigImageView{
    if(!_bigImageView){
        UIImageView *bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), self.navView.maxY+HeightXiShu(45), kScreenWidth-WidthXiShu(24), HeightXiShu(220))];
        bigImageView.image = [GetImagePath getImagePath:@"myCenter_sfz"];
        [self.view addSubview:bigImageView];
        _bigImageView = bigImageView;
    }
    return _bigImageView;
}

-(UILabel *)messageLabel{
    if(!_messageLabel){
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(25)+self.bigImageView.maxY, kScreenWidth, HeightXiShu(20))];
        messageLabel.text = @"请准备好身份证，正面朝上";
        messageLabel.textColor = TitleColor;
        messageLabel.font = HEITI(HeightXiShu(16));
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:messageLabel];
        _messageLabel = messageLabel;
    }
    return _messageLabel;
}

-(UIButton *)realBtn{
    if(!_realBtn){
        UIButton *realBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        realBtn.frame = CGRectMake(WidthXiShu(12), HeightXiShu(32)+self.messageLabel.maxY, kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        [realBtn setTitle:@"开始识别" forState:UIControlStateNormal];
        realBtn.backgroundColor = ButtonColor;
        realBtn.layer.masksToBounds = YES;
        realBtn.layer.cornerRadius = HeightXiShu(5);
        [realBtn addTarget:self action:@selector(realAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:realBtn];
        _realBtn = realBtn;
    }
    return _realBtn;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)realAction{
    CustomCameraViewController *view = [[CustomCameraViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}
@end
