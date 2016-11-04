//
//  TVFaceAuthProtocol.h
//  TVFaceAuthLib
//
//  Created by wz on 16/8/4.
//  Copyright © 2016年 Timevale. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TVFaceAuthProtocol <NSObject>

@optional

/**
 *  比对成功，返回必要信息
 *  serviceId    请求id
 *  evidenceId   举证id
 *  name         姓名
 *  idno         身份证号
 */
- (void)didFaceAuthSuccess:(NSString*)serviceId evidenceId:(NSString*)evidenceId name:(NSString*)name idno:(NSString*)idno;

/**
 *  比对失败，返回必要信息
 *  serviceId    请求id
 */
- (void)didFaceAuthFail:(NSString*)serviceId;

/**
 *  ocr连续失败三次返回，并提供最后一次错误信息
 *  error    最后一次请求错误信息
 */
- (void)didFaceAuthOcrFail:(NSError*)error;

/**
 *  如果实现该回调，在用户确认信息时返回，回调YES继续进行人脸识别，回调NO终止人脸识别，不实现继续进行人脸识别
 *  name    姓名
 *  idno    身份证
 */
- (BOOL)checkAccountInfo:(NSString*)name idno:(NSString*)idno;

/**
 *  用户取消人脸识别
 */
- (void)didFaceAuthCancel;

@end
