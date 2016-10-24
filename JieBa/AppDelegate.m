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
#import "MyCenterViewController.h"
#import <TVFaceAuthFramework/TVFaceAuthFramework.h>
#import "MyCenterApi.h"
#import "RealWithUsViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [TVFaceAuthFramework setAppProjectId:@"1111563517" projectSecret:@"95439b0863c241c63a861b87d1e647b7" serverEnviroment:2];
    [TVFaceAuthFramework setSignatureType:@"SHA" signatureKey:@"95439b0863c241c63a861b87d1e647b7"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAgain) name:@"loginAgain" object:nil];
    
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
    BaseNavigationController *loanNav = [[BaseNavigationController alloc] initWithRootViewController:loan];
    loanNav.navigationBarHidden = YES;
    
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
    tabbar.viewControllers = @[mainNav,loanNav,rentNav,myCenterNav];
    
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

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if(![StringTool isLogin]){
        if(tabBarController.viewControllers[0] == viewController){
            return YES;
        }else if (tabBarController.viewControllers[1] == viewController){
            [self loginAction];
            return NO;
        }else if (tabBarController.viewControllers[2] == viewController){
            [self loginAction];
            return NO;
        }else if (tabBarController.viewControllers[3] == viewController){
            [self loginAction];
            return NO;
        }else{
            return NO;
        }
    }else {
        if([self loadUserInfo:tabBarController viewController:viewController]){
            return YES;
        }else{
            return NO;
        }
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"%@",[viewController class]);
    if(tabBarController.viewControllers[0] == viewController){
//        UINavigationController *navigationctr = (UINavigationController *)viewController;
//        MainViewController *secvc = (MainViewController *)navigationctr.topViewController;
//        [secvc loadUserInfo];
    }else if (tabBarController.viewControllers[1] == viewController){
        UINavigationController *navigationctr = (UINavigationController *)viewController;
        LoanViewController *secvc = (LoanViewController *)navigationctr.topViewController;
        [secvc loadLoanInfo];
    }else if (tabBarController.viewControllers[2] == viewController){
        UINavigationController *navigationctr = (UINavigationController *)viewController;
        RentViewController *secvc = (RentViewController *)navigationctr.topViewController;
        [secvc loadCreditInfo];
    }else{
        UINavigationController *navigationctr = (UINavigationController *)viewController;
        MyCenterViewController *secvc = (MyCenterViewController *)navigationctr.topViewController;
        [secvc loadUserInfo];
    }
}

-(void)loginAction{
    if([LoginViewController openLogin]){
        return;
    }
}

-(void)loginAgain{
    
}

-(BOOL)loadUserInfo:(UITabBarController *)tabBarController viewController:(UIViewController *)viewController{
    UINavigationController *navigationctr = (UINavigationController *)tabBarController.viewControllers[0];
    MainViewController *secvc = (MainViewController *)navigationctr.topViewController;
    __block BOOL isReal = NO;
    __block typeof(self)wSelf = self;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_changeuserinfo" forKey:@"_cmd_"];
    [dic setObject:@"member_info" forKey:@"type"];
    [MyCenterApi getUserInfoWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
            if([dict[@"nameStatus"] integerValue] == 1){
                tabBarController.selectedViewController = viewController;
                [self tabBarController:tabBarController didSelectViewController:viewController];
                isReal = YES;
            }else{
                isReal = NO;
                UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否实名认证" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                UIAlertAction *agreeAction = [UIAlertAction actionWithTitle:@"马上认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    RealWithUsViewController *realView = [[RealWithUsViewController alloc] init];
                    [secvc.navigationController pushViewController:realView animated:YES];
                }];
                [alertControl addAction:cancelAction];
                [alertControl addAction:agreeAction];
                [wSelf.window.rootViewController presentViewController:alertControl animated:YES completion:nil];
            }
        }
    } dic:dic noNetWork:nil];
    
    return isReal;
}
@end
