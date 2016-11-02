//
//  AgreeMentViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "AgreeMentViewController.h"
#import <WebKit/WebKit.h>
#import "NavView.h"

@interface AgreeMentViewController ()
@property (nonatomic, strong) NavView *navView;
@end

@implementation AgreeMentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, kScreenHeight - self.navView.maxY)];
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@&token=%@",self.webUrl,self.money,[LoginSqlite getdata:@"token"]]];
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
        navView.titleLabel.text = @"协议";
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
