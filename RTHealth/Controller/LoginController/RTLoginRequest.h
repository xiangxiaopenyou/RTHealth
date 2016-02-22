//
//  RTLoginRequest.h
//  RTHealth
//
//  Created by cheng on 14-10-17.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTLoginRequest : NSObject

/*
 * login 接口
 *
 * @params parameter 登陆信息
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)loginWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * register 接口
 *
 * @params parameter 注册信息
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)registerWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * getidentify 接口
 *
 * @params parameter 获取验证码手机信息
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getidentifyWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * verify 接口
 *
 * @params parameter 验证信息
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)verifyWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * upPassword接口
 * @params parameter 验证信息
 * @params success 成功返回信息
 * @params failture 失败返回信息
 *
 */
+ (void)upPasswordWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * changePassword接口
 * @params parameter 验证信息
 * @params success 成功返回信息
 * @params failture 失败返回信息
 *
 */
+ (void)changePasswordWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 第三方登陆接口
 * @params parameter 头像，nickname和openid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 *
 */
+ (void)registerThirdWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
@end
