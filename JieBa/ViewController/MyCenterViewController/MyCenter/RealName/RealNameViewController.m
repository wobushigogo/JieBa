//
//  RealNameViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/20.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RealNameViewController.h"
#import "NavView.h"
#import "CustomCameraViewController.h"
#import <TVFaceAuthFramework/TVFaceAuthFramework.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import "RealWithUsViewController.h"

@interface RealNameViewController ()<TVFaceAuthProtocol>
@property(nonatomic,strong)NavView *navView;
@end

@implementation RealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    [TVFaceAuthFramework tvFaceAuthCtrl:self faceAuthProtocol:self];
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
        navView.titleLabel.text = @"身份证识别";
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

#pragma mark - TVFaceAuthProtocol
- (void)didFaceAuthSuccess:(NSString*)serviceId evidenceId:(NSString*)evidenceId name:(NSString*)name idno:(NSString*)idno {
    NSString* log = [NSString stringWithFormat:@"face auth success serviceId : %@ evidenceId : %@ name : %@ idno : %@\n", serviceId, evidenceId, name, idno];
    [self log:log];
}

- (void)didFaceAuthFail:(NSString*)serviceId {
    NSString* log = [NSString stringWithFormat:@"face auth fail serviceId %@\n", serviceId];
    [self log:log];
}

- (void)didFaceAuthOcrFail:(NSError*)error {
    NSString* log = [NSString stringWithFormat:@"face auth ocr fail 3 times, last error : %@\n", error];
    
    RealWithUsViewController *view = [[RealWithUsViewController alloc] init];
    view.isReal = self.isReal;
    view.realName = self.realName;
    view.certiNumber = self.certiNumber;
    [self.navigationController pushViewController:view animated:YES];

    
    [self log:log];
}

- (BOOL)checkAccountInfo:(NSString*)name idno:(NSString*)idno {
    NSString* log = [NSString stringWithFormat:@"face auth back account info %@ %@，", name, idno];
    [self log:log];
    
    //自定义判断逻辑
//    if([_nameField.text length] > 0 && [_idnoField.text length] > 0) {
//        if([_nameField.text isEqualToString:name] && [_idnoField.text isEqualToString:idno]) {
//            NSLog(@"校验通过。");
//            return YES;
//        }
//        NSLog(@"校验不通过");
//        return NO;
//    }
    
    NSLog(@"不做校验");
    //默认返回
    return YES;
}

- (void)didFaceAuthCancel {
    NSString* log = @"cancel face auth\n";
    [self log:log];
}

- (void)log:(NSString*)log {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss:SSS"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString* logStr = [NSString stringWithFormat:@"%@ %@", dateStr, log];
    NSLog(@"%@", logStr);
}
@end
