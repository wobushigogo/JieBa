//
//  MessageDetailViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/28.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "NavView.h"
#import <WebKit/WebKit.h>
#import "MyCenterApi.h"
#import "MessageModel.h"

@interface MessageDetailViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)MessageModel *messageModel;
@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    //[self webView];
    [self loadInfo];
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, kScreenHeight - self.navView.maxY)];
    [self.view addSubview:self.webView];
    
    
    //[self.webView loadHTMLString:htmls baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(WKWebView *)webView{
    if(!_webView){
        WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
        WKPreferences * prefer = [[WKPreferences alloc]init];
        prefer.javaScriptEnabled = YES;
        prefer.minimumFontSize = 20;
        prefer.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = prefer;
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, kScreenHeight - self.navView.maxY) configuration:configuration];
        webView.navigationDelegate = self;
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"详细信息";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

#pragma mark - 事件
-(void)backAction{
    if(self.backBlock){
        self.backBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 接口
-(void)loadInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"system" forKey:@"_cmd_"];
    [dic setObject:@"list_info" forKey:@"type"];
    [dic setObject:self.messageId forKey:@"id"];
    
    [MyCenterApi systemMessageInfoWithBlock:^(MessageModel *model, NSError *error) {
        if(!error){
            self.messageModel = model;
            
            NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "<style type=\"text/css\"> \n"
                               "body {font-size:15px;}\n"
                               "</style> \n"
                               "</head> \n"
                               "<body>"
                               "<script type=‘text/javascript‘>"
                               "window.onload = function(){\n"
                               "var $img = document.getElementsByTagName(‘img‘);\n"
                               "for(var p in  $img){\n"
                               " $img[p].style.width = ‘100%%‘;\n"
                               "$img[p].style.height =‘auto‘\n"
                               "}\n"
                               "}"
                               "</script><div>%@"
                               "</div><br><div style='color:rgb(180,180,180)'>%@"
                               "</div><br>%@"
                               "</body>"
                               "</html>",model.title,model.timeadd,model.content];
             [self.webView loadHTMLString:htmls baseURL:nil];
        }
    } dic:dic noNetWork:nil];
}
@end
