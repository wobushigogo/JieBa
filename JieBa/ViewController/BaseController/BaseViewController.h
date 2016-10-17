//
//  BaseViewController.h
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property(nonatomic,strong)UIView *statusBar;
@property (nonatomic, assign) BOOL autoEndEdit;//default is YES
@end
