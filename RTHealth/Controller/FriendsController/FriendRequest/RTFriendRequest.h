//
//  RTFriendRequest.h
//  RTHealth
//
//  Created by cheng on 14/12/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTFriendRequest : NSObject

/*
 * 粉丝列表接口
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getFansSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 关注的人列表接口
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getAttentionSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 附件的人列表接口
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getNearBySuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 达人列表接口
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getPopularSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 教练列表接口
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getTearcherSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 关注别人接口
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)fansCreateFriend:(FriendsInfo*)friendInfo Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 取消关注别人接口
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)fansDeleteFriend:(FriendsInfo*)friendInfo Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

@end
