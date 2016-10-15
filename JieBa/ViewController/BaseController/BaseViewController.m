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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
