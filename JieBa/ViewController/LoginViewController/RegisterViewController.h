//
//  RegisterViewController.h
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController
@property(nonatomic,strong)NSString *recommendCode;
@property(nonatomic,strong)void(^backBlock)();
@end
