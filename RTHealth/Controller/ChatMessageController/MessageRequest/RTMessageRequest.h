//
//  RTMessageRequest.h
//  RTHealth
//
//  Created by cheng on 14/12/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMessageRequest : NSObject

/*
 * 回复列表接口
 *
 * @params parameter 登陆信息id token userid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getReplyListSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
/*
 * 喜欢消息列表接口
 *
 * @params parameter 登陆信息id token userid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getFavoriteListSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
/*
 * 所有消息列表接口
 *
 * @params parameter 登陆信息id token userid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getAllMessageListSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 聊天列表接口
 *
 * @params parameter 登陆信息id token userid friend
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getChatList:(Chat*)chat Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 刷新列表接口
 *
 * @params parameter 登陆信息id token userid friend
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getFreshChatList:(Chat*)chat Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 聊天列表接口
 *
 * @params parameter 登陆信息id token userid friendid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)sendChatList:(ChatList*)chat Chat:(Chat*)chat Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 标记为已读接口
 *
 * @params parameter 登陆信息id token userid friendid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)chatReadList:(Chat*)chat Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 活动通知列表接口
 *
 * @params parameter 登陆信息id token userid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getRemindListSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

@end
