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
#import "ScanView.h"
#import "NSString+StringKit.h"
#import "RegisterViewController.h"

@interface ScanViewController ()<ZBarReaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)ScanView *scanView;
@property(nonatomic,strong)ZBarReaderView *readview;
@property(nonatomic,strong)UILabel *messageLabel;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    //初始化照相机窗口
    self.readview = [ZBarReaderView new];
    //自定义大小
    self.readview.frame = CGRectMake((kScreenWidth-WidthXiShu(263))/2, self.navView.maxY+HeightXiShu(140), WidthXiShu(263), HeightXiShu(263));
    //自定义添加相关指示.........发挥各自的APP的想象力
    //此处省略美化10000行代码...................
    //………………………..
    // 好进入正题—— 接着设置好代理
    self.readview.readerDelegate = self;
    //将其照相机拍摄视图添加到要显示的视图上
    [self.view addSubview:self.readview];
    //二维码/条形码识别设置
    ZBarImageScanner *scanner = self.readview.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    //启动，必须启动后，手机摄影头拍摄的即时图像菜可以显示在readview上
    [self.readview start];
    
    [self scanView];
    
    [self messageLabel];
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
        [navView.rightBtn setTitle:@"相册" forState:UIControlStateNormal];
        [navView.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(ScanView *)scanView{
    if(!_scanView){
        _scanView = [[ScanView alloc] initWithFrame:self.readview.bounds];
        [_scanView startAnimationInSuperView:self.readview];
        
    }
    return _scanView;
}

-(UILabel *)messageLabel{
    if(!_messageLabel){
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.readview.maxY+HeightXiShu(15), kScreenWidth, HeightXiShu(20))];
        messageLabel.text = @"将名片二维码放入框内，即可自动扫描";
        messageLabel.textColor = TitleColor;
        messageLabel.font = HEITI(HeightXiShu(15));
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:messageLabel];
        _messageLabel = messageLabel;
    }
    return _messageLabel;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    ZBarReaderController *imagePicker = [ZBarReaderController new];
    imagePicker.delegate = self;
    
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
        break;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *text = symbol.data;
    NSLog(@"imagePickerController ===>%@",text);
    [self manageUrl:text];
}

-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image{
    ZBarSymbol *symbol = nil;
    
    for(symbol in symbols)
        break;
    
    NSString *text = symbol.data;
    NSLog(@"readerView ===>%@",text);
    [self manageUrl:text];
}

-(void)readerControllerDidFailToRead:(ZBarReaderController *)reader withRetry:(BOOL)retry{
    
    if (retry) {
        //retry == 1 选择图片为非二维码。
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"臣妾找不到啊_(:з)∠)_" delegate:self cancelButtonTitle:nil otherButtonTitles:@"朕知道了", nil];
        
        [alert show];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    return;
    
}

-(void)manageUrl:(NSString *)text{
    NSArray *arr = [text componentsSeparatedByString:@"/"];
    NSString *string = arr.lastObject;
    NSLog(@"==>%@",string);
    if([string isAllNumbers]){
        if([[StringTool stringWithNull:[LoginSqlite getdata:@"token"]] isEqualToString:@""]){
            RegisterViewController *view = [[RegisterViewController alloc] init];
            view.recommendCode = string;
            [self.navigationController pushViewController:view animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            if(self.backBlock){
                self.backBlock();
            }
        }
    }
}
@end
