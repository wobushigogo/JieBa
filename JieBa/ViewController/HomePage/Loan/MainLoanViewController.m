//
//  MainLoanViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/25.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MainLoanViewController.h"
#import <WebKit/WebKit.h>
#import "NavView.h"
#import "LoanViewController.h"

@interface MainLoanViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) NavView *navView;

@end

@implementation MainLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, kScreenHeight - self.navView.maxY)];
    webView.navigationDelegate = self;
    NSURL* url = [NSURL URLWithString:self.webUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *url = navigationAction.request.URL.absoluteString;
    
    NSLog(@"url = %@",url);
    BOOL toProduct = [url containsString:@"jieba=cdb"];
    
    WKNavigationActionPolicy allow = WKNavigationActionPolicyAllow;
    
        if (toProduct) {
            LoanViewController *view = [[LoanViewController alloc] init];
            view.isHide = NO;
            [self.navigationController pushViewController:view animated:YES];
            allow = WKNavigationActionPolicyCancel;
        }
    if (decisionHandler) {
        decisionHandler(allow);
    }
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"车贷宝流程";
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
