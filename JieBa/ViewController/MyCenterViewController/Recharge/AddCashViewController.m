//
//  AddCashViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/25.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "AddCashViewController.h"
#import <WebKit/WebKit.h>
#import "NavView.h"
#import "JSONKit.h"

@interface AddCashViewController ()<WKNavigationDelegate,UIWebViewDelegate>
@property (nonatomic, strong) NavView *navView;

@end

@implementation AddCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    NSLog(@"%@",self.dic);
    
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc] init];
    [bodyDic setObject:self.dic[@"mchnt_cd"] forKey:@"mchnt_cd"];
    [bodyDic setObject:self.dic[@"mchnt_txn_ssn"] forKey:@"mchnt_txn_ssn"];
    [bodyDic setObject:self.dic[@"cust_nm"] forKey:@"cust_nm"];
    //[bodyDic setObject:self.dic[@"certif_tp"] forKey:@"certif_tp"];
    [bodyDic setObject:self.dic[@"certif_id"] forKey:@"certif_id"];
    [bodyDic setObject:self.dic[@"mobile_no"] forKey:@"mobile_no"];
    [bodyDic setObject:@"" forKey:@"email"];
    [bodyDic setObject:self.dic[@"city_id"] forKey:@"city_id"];
    [bodyDic setObject:self.dic[@"parent_bank_id"] forKey:@"parent_bank_id"];
    [bodyDic setObject:self.dic[@"bank_nm"] forKey:@"bank_nm"];
    //[bodyDic setObject:@"" forKey:@"capAcntNm"];
    [bodyDic setObject:self.dic[@"capAcntNo"] forKey:@"capAcntNo"];
    //[bodyDic setObject:@"" forKey:@"password"];
    //[bodyDic setObject:@"" forKey:@"lpassword"];
    //[bodyDic setObject:@"" forKey:@"rem"];
    [bodyDic setObject:self.dic[@"signature"] forKey:@"signature"];
    [bodyDic setObject:@"" forKey:@"back_notify_url"];
    [bodyDic setObject:self.dic[@"page_notify_url"] forKey:@"page_notify_url"];
    [bodyDic setObject:self.dic[@"user_id_from"] forKey:@"user_id_from"];
    [bodyDic setObject:self.dic[@"ver"] forKey:@"ver"];
    [bodyDic setObject:self.dic[@"form_url"] forKey:@"form_url"];
    
    NSMutableString *string = [[NSMutableString alloc] init];
    [bodyDic.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendString:[NSString stringWithFormat:@"%@=%@&",obj,bodyDic[obj]]];
    }];
    
    NSString *newStr = [string substringToIndex:([string length]-1)];
    NSLog(@"===>%@",newStr);
    
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)newStr, NULL, (CFStringRef)@"+",  kCFStringEncodingUTF8 ));
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, kScreenHeight - self.navView.maxY)];
    webView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.webUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[encodedString dataUsingEncoding: NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];//请求头
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",response);
    }];
    
    [webView loadRequest: request];
    [self.view addSubview:webView];
    
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, kScreenHeight - self.navView.maxY)];
//    webView.navigationDelegate = self;
//    NSURL* url = [NSURL URLWithString:self.webUrl];
//    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
//    [request setHTTPMethod:@"POST"];//POST请求
//    [request setHTTPBody:bodyData];//body 数据
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];//请求头
//    [webView loadRequest:request];
//    [self.view addSubview:webView];
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
        navView.titleLabel.text = @"充值";
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

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"%@", [request allHTTPHeaderFields]);
    NSLog(@"%@", [[request HTTPBody] objectFromJSONData]);
    
    NSHTTPURLResponse *response = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSLog(@"%@", [data objectFromJSONData]);
    return YES;
}
@end
