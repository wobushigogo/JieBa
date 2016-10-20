//
//  TVFaceAuthFramework.h
//  TVFaceAuthFramework
//
//  Created by wz on 16/8/17.
//  Copyright © 2016年 Timevale. All rights reserved.
//

#ifndef TVFaceAuthFramework_h
#define TVFaceAuthFramework_h

#import <UIKit/UIKit.h>
#import "TVFaceAuthProtocol.h"

// 当前framework版本，仅用于标注
#define TV_FACEAUTH_IOS_FRAMEWORK_VERSION 1.0.0

@interface TVFaceAuthFramework : NSObject

/*!
 @method 设置项目配置信息
 @param  _projectId      项目编号
 @param  _projectSecret  项目密钥
 */
+ (void)setAppProjectId:(NSString*)_projectId
          projectSecret:(NSString*)_projectSecret;

/*!
 @method 设置项目配置信息
 @param  _projectId         项目编号
 @param  _projectSecret     项目密钥
 @param  _serverEnviroment  服务器环境 0-正式 1-测试 2-模拟
 */
+ (void)setAppProjectId:(NSString*)_projectId
          projectSecret:(NSString*)_projectSecret
       serverEnviroment:(NSInteger)_serverEnviroment;

/*!
 @method 设置签名方式和密钥
 @param  _signatureType    签名方式 SHA/RSA
 @param  _signatureKey     签名密钥
 */
+ (void)setSignatureType:(NSString*)_signatureType
            signatureKey:(NSString*)_signatureKey;

/*!
 @method 人脸识别实名认证
 @param  _ctrl              用于跳转视图
 @param  _faceAuthProtocol  回调
 */
+ (void)tvFaceAuthCtrl:(UIViewController*)_ctrl
      faceAuthProtocol:(id<TVFaceAuthProtocol>)_faceAuthProtocol;


@end

#endif /* TVFaceAuthFramework_h */