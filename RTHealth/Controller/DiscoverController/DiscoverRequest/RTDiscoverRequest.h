//
//  RTDiscoverRequest.h
//  RTHealth
//
//  Created by cheng on 14/11/25.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTDiscoverRequest : NSObject


/*
 * 获取个可导入的计划 时间
 *
 * @params parameter 登陆信息id token
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getPlanWithTime:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取个可导入的计划 时间
 *
 * @params parameter 登陆信息id token
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getPlanWithPopular:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 获取个可导入的计划 时间
 *
 * @params parameter 登陆信息id token
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getSearchWithArray:(NSMutableArray*)array Key:(NSString*)key success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

@end
