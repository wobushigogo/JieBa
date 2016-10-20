//
//  CustomCameraViewController.h
//  JieBa
//
//  Created by 汪洋 on 16/10/20.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CustomCameraViewController : BaseViewController
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头））
@property (nonatomic, strong) AVCaptureSession* session;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput* videoInput;
//输出图片
@property (nonatomic, strong) AVCaptureStillImageOutput* stillImageOutput;
//图像预览层，实时显示捕获的图像
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;
@end
