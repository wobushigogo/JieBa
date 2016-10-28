//
//  MyCenterHead.h
//  JieBa
//
//  Created by 汪洋 on 16/10/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@protocol MyCenterHeadDelegate <NSObject>
-(void)messageClick;
-(void)QRCoedeClick;
-(void)signClick;
-(void)activeClick;
-(void)changeHeadClick;
@end

@interface MyCenterHead : UIView
@property(nonatomic,weak)id<MyCenterHeadDelegate>delegate;
@property(nonatomic,strong)UserInfoModel *model;
@property(nonatomic,strong)NSString *avatarUrl;
@end
