//
//  RTFriendDetailRequest.h
//  RTHealth
//
//  Created by cheng on 14/12/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTFriendDetailRequest : NSObject

/*
 * 获取朋友信息 接口
 *
 * @params parameter 登陆信息id token friendid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)friendInfoWith:(FriendsInfo*)friendInfo success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 获取朋友信息 接口
 *
 * @params parameter 登陆信息id token friendid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)friendPlanWith:(FriendsInfo*)friendInfo success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 获取朋友信息 接口
 *
 * @params parameter 登陆信息id token friendid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)friendfansWith:(FriendsInfo*)friendInfo success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
/*
 * 获取朋友信息 接口
 *
 * @params parameter 登陆信息id token friendid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)friendAttentionWith:(FriendsInfo*)friendInfo success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
@end
