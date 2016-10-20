//
//  CustomCameraViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/20.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CustomCameraViewController.h"
#import "NavView.h"

@interface CustomCameraViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIImageView *scanImageView;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UIButton *scanBtn;
@property(nonatomic,strong)UIImage *photopImage;
@end

@implementation CustomCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = AllBackLightGratColor;
    [self statusBar];
    [self navView];
    [self scanImageView];
    [self makeMyCapture];
    [self messageLabel];
    [self scanBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (self.session) {
        [self.session startRunning];
    }
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    if (self.session) {
        [self.session stopRunning];
    }
}

-(void)dealloc{
    NSLog(@"CustomCameraViewController dealloc");
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"拍摄身份证   ";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIImageView *)scanImageView{
    if(!_scanImageView){
        UIImageView *scanImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-WidthXiShu(322))/2, self.navView.maxY+HeightXiShu(110), WidthXiShu(322), HeightXiShu(188))];
        scanImageView.image = [GetImagePath getImagePath:@"myCenter_scan"];
        [self.view addSubview:scanImageView];
        _scanImageView = scanImageView;
    }
    return _scanImageView;
}

-(UILabel *)messageLabel{
    if(!_messageLabel){
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scanImageView.maxY+HeightXiShu(27), kScreenWidth, HeightXiShu(20))];
        messageLabel.text = @"请将身份证正面朝上，四角对齐点击拍摄";
        messageLabel.textColor = TitleColor;
        messageLabel.font = HEITI(HeightXiShu(16));
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:messageLabel];
        _messageLabel = messageLabel;
    }
    return _messageLabel;
}

-(UIButton *)scanBtn{
    if(!_scanBtn){
        UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [scanBtn setTitle:@"拍照" forState:UIControlStateNormal];
        scanBtn.frame = CGRectMake(WidthXiShu(100), self.messageLabel.maxY+HeightXiShu(30), WidthXiShu(100), HeightXiShu(40));
        [scanBtn addTarget:self action:@selector(scanACtion) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:scanBtn];
        _scanBtn = scanBtn;
    }
    return _scanBtn;
}

#pragma mark 构造自定义相机
-(void)makeMyCapture{
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPreset640x480;
    NSError *error;
    //捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [device lockForConfiguration:nil];
    //设置闪光灯为自动
    [device setFlashMode:AVCaptureFlashModeAuto];
    [device unlockForConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResize;
    
    self.previewLayer.frame = CGRectMake(WidthXiShu(29),self.navView.maxY+HeightXiShu(112),kScreenWidth-WidthXiShu(58),HeightXiShu(184));
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.contentsScale = [UIScreen mainScreen].scale;
    self.previewLayer.backgroundColor = [[UIColor blackColor]CGColor];
    self.view.layer.masksToBounds = YES;
    
    [self.view.layer addSublayer:self.previewLayer];
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scanACtion{
    //进行拍照保存图片
    AVCaptureConnection *conntion = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!conntion) {
        NSLog(@"拍照失败!");
        return;
    }
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        self.photopImage = [UIImage imageWithData:imageData];
        self.photopImage = [self imageFromImage:[UIImage imageWithData:imageData] inRect:CGRectMake(0, self.navView.maxY+HeightXiShu(150), kScreenWidth*2, HeightXiShu(386))];
        
        [self Dophoto];
        
    }];
}

-(void)Dophoto
{
    UIView *viewb = [[UIView alloc]init];
    viewb.frame = self.view.frame;
    viewb.backgroundColor = [UIColor blackColor];
    [self.view addSubview:viewb];
    
    UIImageView *imagev = [[UIImageView alloc] initWithImage:_photopImage];
    imagev.contentMode = UIViewContentModeScaleAspectFit;
    imagev.frame = CGRectMake(0, HeightXiShu(64), kScreenWidth, kScreenHeight-HeightXiShu(104));
    [viewb addSubview:imagev];
    
    UIButton *leftbutton = [[UIButton alloc]init];
    [leftbutton setTitle:@"重拍" forState:UIControlStateNormal];
    leftbutton.tag = 1001;
    [leftbutton setTintColor:[UIColor whiteColor]];
    [viewb addSubview:leftbutton];
    leftbutton.frame = CGRectMake(WidthXiShu(30), kScreenHeight-HeightXiShu(30), WidthXiShu(60), HeightXiShu(20));
    [leftbutton addTarget:self action:@selector(hitopbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightbutton = [[UIButton alloc]init];
    [rightbutton setTitle:@"确定" forState:UIControlStateNormal];
    rightbutton.tag = 1000;
    [rightbutton setTintColor:[UIColor whiteColor]];
    [viewb addSubview:rightbutton];
    rightbutton.frame = CGRectMake(kScreenWidth-WidthXiShu(90), kScreenHeight-HeightXiShu(30), WidthXiShu(60), HeightXiShu(20));
    
    [rightbutton addTarget:self action:@selector(hitopbutton:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)hitopbutton:(UIButton *)button{
    [button.superview removeFromSuperview];
    if(button.tag == 1000){
        //        [self savePicturePath];
//        for (UIViewController*controller in [self.navigationController viewControllers])
//        {
//            if ([controller isKindOfClass:[customMainVC class]])
//            {
//                customMainVC * vc = controller;
//                vc.headImageView.image = _photopImage;
//                [self.navigationController popToViewController:vc animated:YES];
//            }
//        }
        
    }
    else{
        
        
    }
}

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    NSLog(@"===>%ld",(long)image.imageOrientation);
    
    image = [self normalizedImage:image];
    
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

- (UIImage *)normalizedImage:(UIImage *)image {
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}
@end
