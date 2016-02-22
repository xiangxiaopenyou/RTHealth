//
//  RTMoreRequest.h
//  RTHealth
//
//  Created by cheng on 14/12/30.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMoreRequest : NSObject


/*
 * 获取朋友信息 接口
 *
 * @params parameter 登陆信息id token friendid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)upWeightWith:(NSDictionary *)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

@end
