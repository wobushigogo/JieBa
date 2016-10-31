//
//  HelpCenterViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/31.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "HelpCenterViewController.h"
#import <WebKit/WebKit.h>
#import "NavView.h"

@interface HelpCenterViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) NavView *navView;
@end

@implementation HelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, kScreenHeight - self.navView.maxY)];
    webView.navigationDelegate = self;
    NSURL* url = [NSURL URLWithString:self.webUrl];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
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
        navView.titleLabel.text = @"帮助中心";
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
