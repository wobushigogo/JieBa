//
//  ScanViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/27.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "ScanViewController.h"
#import "ZBarSDK.h"
#import "NavView.h"

@interface ScanViewController ()<ZBarReaderViewDelegate>
@property (nonatomic, strong) NavView *navView;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    
    //初始化照相机窗口
    ZBarReaderView *readview = [ZBarReaderView new];
    //自定义大小
    readview.frame = CGRectMake(10, 100, 300, 300);
    //自定义添加相关指示.........发挥各自的APP的想象力
    //此处省略美化10000行代码...................
    //………………………..
    // 好进入正题—— 接着设置好代理
    readview.readerDelegate = self;
    //将其照相机拍摄视图添加到要显示的视图上
    [self.view addSubview:readview];
    //二维码/条形码识别设置
    ZBarImageScanner *scanner = readview.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    //启动，必须启动后，手机摄影头拍摄的即时图像菜可以显示在readview上
    [readview start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"扫描";
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
        break;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *text = symbol.data;
    NSLog(@"===>%@",text);
}

-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image{
    ZBarSymbol *symbol = nil;
    
    for(symbol in symbols)
        break;
    
    NSString *text = symbol.data;
    NSLog(@"===>%@",text);
}
@end
