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
- (void)didFaceAuthSuccess:(NSString*)serviceId evidenceId:(NSString*)evidenceId;
- (void)didFaceAuthFail:(NSString*)serviceId;
- (void)didFaceAuthCancel;

@end
