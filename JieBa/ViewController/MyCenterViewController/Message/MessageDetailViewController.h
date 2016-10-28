//
//  MessageDetailViewController.h
//  JieBa
//
//  Created by 汪洋 on 16/10/28.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseViewController.h"

@interface MessageDetailViewController : BaseViewController
@property(nonatomic,strong)NSString *messageId;
@property(nonatomic,strong)void(^backBlock)();
@end
