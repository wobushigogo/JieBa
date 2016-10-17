//
//  BaseViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = AllBackLightGratColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.autoEndEdit = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.autoEndEdit) [self.view endEditing:YES];
}

-(UIView *)statusBar{
    if(!_statusBar){
        UIView *statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        statusBar.backgroundColor = NavColor;
        [self.view addSubview:statusBar];
        
        _statusBar = statusBar;
    }
    return _statusBar;
}

@end
