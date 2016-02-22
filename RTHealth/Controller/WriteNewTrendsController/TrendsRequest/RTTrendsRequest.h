//
//  RTTrendsRequest.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/25.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTTrendsRequest : NSObject

/*
 * 写动态 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)writeTrendsWith:(NSDictionary *)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取动态列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getTrendsListWith:(NSDictionary *)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取运动圈列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getSportsTrendsWith:(NSDictionary *)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取猜你喜欢列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getLikeTrendsWith:(NSDictionary *)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取动态话题 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getTrendsClassifyWith:(NSDictionary *)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取我的动态列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getMyTrendsListWith:(NSDictionary *)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
/*
 * 删除我的动态 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)deleteMyTrendWith:(NSDictionary *)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取他人的动态列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getFriendsTrendsListWith:(NSDictionary *)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 点赞 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)trendLikeWith:(NSDictionary *)parameter success:(void (^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 取消点赞 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)trendDislikeWith:(NSDictionary *)parameter success:(void (^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 评论 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)commentWith:(NSDictionary *)parameter success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/*
 * 删除评论 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)deleteCommentWith:(NSDictionary *)parameter success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/*
 * 回复 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void) replyWith:(NSDictionary *)parameter success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/*
 * 获取评论列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getCommentListWith:(NSDictionary *)parameter success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/*
 * 获取点赞列表 接口
 *
 * @params parameter userid usertoken
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getLikeListWith:(NSDictionary *)parameter success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

@end
