//
//  AppDelegate.m
//  JieBa
//
//  Created by 汪洋 on 16/10/13.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "BaseNavigationController.h"
#import "MyCenterViewController.h"
#import "RentViewController.h"
#import "LoanViewController.h"
#import "LoginViewController.h"
#import "LoginApi.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [LoginSqlite opensql];
    
    MainViewController *main = [[MainViewController alloc] init];
    [main.tabBarItem setImageInsets:UIEdgeInsetsMake(7.0, 0.0, -7.0, 0.0)];
    main.tabBarItem.image = [[UIImage imageNamed:@"tabbar_home_gary"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    main.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *mainNav = [[BaseNavigationController alloc] initWithRootViewController:main];
    mainNav.navigationBarHidden = YES;
    
    LoanViewController *loan = [[LoanViewController alloc] init];
    [loan.tabBarItem setImageInsets:UIEdgeInsetsMake(7.0, 0.0, -7.0, 0.0)];
    loan.tabBarItem.image = [[UIImage imageNamed:@"tabbar_loan_gary"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    loan.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_loan_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *loannav = [[BaseNavigationController alloc] initWithRootViewController:loan];
    loannav.navigationBarHidden = YES;
    
    RentViewController *rent = [[RentViewController alloc] init];
    [rent.tabBarItem setImageInsets:UIEdgeInsetsMake(7.0, 0.0, -7.0, 0.0)];
    rent.tabBarItem.image = [[UIImage imageNamed:@"tabbar_rent_gary"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rent.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_rent_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *rentNav = [[BaseNavigationController alloc] initWithRootViewController:rent];
    rentNav.navigationBarHidden = YES;
    
    MyCenterViewController *myCenter = [[MyCenterViewController alloc] init];
    [myCenter.tabBarItem setImageInsets:UIEdgeInsetsMake(7.0, 0.0, -7.0, 0.0)];
    myCenter.tabBarItem.image = [[UIImage imageNamed:@"tabbar_myCenter_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myCenter.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_myCenter_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *myCenterNav = [[BaseNavigationController alloc] initWithRootViewController:myCenter];
    myCenterNav.navigationBarHidden = YES;
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    tabbar.delegate = self;
    //    tabbar.viewControllers = @[plannav,magazinenav,detailedListnav,personalnav];
    tabbar.viewControllers = @[mainNav,loan,rent,myCenter];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tabbar.tabBar.height)];
    bgView.backgroundColor = RGBCOLOR(16, 16, 16);
//    self.dianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-5-WidthXiShu(26), WidthXiShu(7.5), 6, 6)];
//    self.dianImageView.backgroundColor = RGBCOLOR(255, 100, 64);
//    self.dianImageView.hidden = YES;
//    self.dianImageView.layer.cornerRadius = 3;
//    self.dianImageView.layer.masksToBounds = YES;
//    [bgView addSubview:self.dianImageView];
//    [tabbar.tabBar insertSubview:bgView atIndex:0];
    tabbar.tabBar.opaque = YES;
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"login" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    btn.frame = CGRectMake(100, 100, 50, 50);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:btn];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"logout" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor blackColor];
    btn2.frame = CGRectMake(200, 100, 50, 50);
    [btn2 addTarget:self action:@selector(btnAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:btn2];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)btnAction{
    LoginViewController *view = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    nav.navigationBarHidden = YES;
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}
-(void)btnAction2{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_logout" forKey:@"_cmd_"];
    [dic setObject:[LoginSqlite getdata:@"token"] forKey:@"token"];
    [LoginApi logoutWithBlock:^(NSString *string, NSError *error) {
        if(!error){
            NSLog(@"%@",string);
        }
    } dic:dic noNetWork:nil];
}
@end
