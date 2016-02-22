//
//  RTUtil.h
//  RTHealth
//
//  Created by cheng on 14/10/22.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTUtil : NSObject

+ (BOOL)matchtelphone:(NSString*)string;
+ (BOOL) isValidateMobile:(NSString *)mobile;

+ (BOOL)matchpassword:(NSString*)string;

+ (BOOL)isEmpty:(id)sender;

+ (BOOL) isBlankString:(NSString *)string;

+ (BOOL)isLogin;
//原图
+ (NSString*)urlPhoto:(NSString*)key;
//缩放图片
+ (NSString*)urlZoomPhoto:(NSString*)key;

+ (NSString*)urlWeixinPhoto:(NSString*)key;

+ (void)notificationRegister;

@end
