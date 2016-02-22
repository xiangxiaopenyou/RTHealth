//
//  RTPersonalRequest.h
//  RTHealth
//
//  Created by cheng on 14/11/19.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTPersonalRequest : NSObject


/*
 * 获取个人信息 接口
 *
 * @params parameter 登陆信息id token
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)userInfoWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 修改个人信息 接口
 *
 * @params parameter 登陆信息id token 个人信息
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)modifyUserInfoWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 修改个人头像 接口
 *
 * @params parameter 登陆信息id token 个人信息
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)modifyHeadInfoWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取个人其他信息 接口 粉丝数 等
 *
 * @params parameter 登陆信息id token
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)userOtherInfoWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 获取正在进行的计划
 *
 * @params parameter 登陆信息id token
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)userPlanWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


+ (void)uploadImage:(NSDictionary*)parameter imageparams:(UIImage*)imageparams success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

+ (void)uploadImage:(UIImage*)image success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;



/*
 * 标记完成子计划
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)finishedSmallPlan:(NSDictionary*)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 标记完成子计划
 *
 * @params parameter 登陆信息id token
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */

+ (void)getNominate:(NSMutableArray*)array success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 检查更新
 *
 * @params parameter version
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)checkUpdateSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 发送devicetoken
 *
 * @params parameter devicetoken userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)setDeviceTokenSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
@end
