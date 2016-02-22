//
//  RTActivtyRequest.h
//  RTHealth
//
//  Created by 项小盆友 on 14/12/5.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTActivtyRequest : NSObject

/*
 * 创建活动列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)createActivityWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

/*
 * 获取我的活动列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getMyActivityWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取他人活动列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getFriendActivityWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 获取活动详情 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getActivityDetailWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取参加活动人员 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getJoinActivityMemberWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 获取推荐活动距离排序列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getActivityWithDistance:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取推荐活动时间排序列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getActivityWtihTime:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 参加活动 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)joinActivityWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 退出活动 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)exitActivityWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError* error))failure;

/*
 * 取消活动 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)cancelActivityWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError* error))failure;

/*
 * 邀请参加活动 接口
 *
 * @params parameter userid usertoken friendid activityid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)inviteJoinActivityWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError* error))failure;

@end
