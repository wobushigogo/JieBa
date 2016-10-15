//
//  ViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/13.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "ViewController.h"
#import "SendRequst.h"
#import "MyCenterApi.h"
#import "InviteModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"system" forKey:@"_cmd_"];
    [dic setObject:@"list" forKey:@"type"];
    [dic setObject:@"" forKey:@"status"];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"10" forKey:@"number"];
    [MyCenterApi systemMessageListWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
        
        }
    } dic:dic noNetWork:nil];
    
    
//    [SendRequst sendRequestWithUrlString:@"" success:^(id responseDic) {
//        
//    } failure:^(NSError *error) {
//        
//    } apiName:@"" noNetWork:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
