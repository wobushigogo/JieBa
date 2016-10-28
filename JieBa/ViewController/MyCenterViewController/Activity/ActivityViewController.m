//
//  ActivityViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/28.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "ActivityViewController.h"
#import <WebKit/WebKit.h>
#import "NavView.h"

@interface ActivityViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) NavView *navView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, kScreenHeight - self.navView.maxY)];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    
    NSLog(@"===>%@",[LoginSqlite getdata:@"sign"]);
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[LoginSqlite getdata:@"sign"],[LoginSqlite getdata:@"token"]]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"活动专区";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
