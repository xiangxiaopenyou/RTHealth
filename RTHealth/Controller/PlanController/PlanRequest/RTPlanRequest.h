//
//  RTPlanRequest.h
//  RTHealth
//
//  Created by cheng on 14/11/21.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTPlanRequest : NSObject

/*
 * 新建计划
 *
 * @params parameter 登陆信息id token plan
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)addPlanWith:(NSDictionary*)parameter Plan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 计划详情
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)detailWithPlan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 导入计划
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)importWithPlan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/*
 * 开始计划
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)startWithPlan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
/*
 * 删除计划
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)deleteWithPlan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
/*
 * 停止计划
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)stopWithPlan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/*
 * 我的计划
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)getMyPlan:(NSDictionary*)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
+ (void)addStartPlan:(NSDictionary*)response;
+ (void)addEndPlan:(NSDictionary *)response;
+ (void)addImportPlan:(NSDictionary*)response;



/*
 * 系统推荐计划
 *
 * @params parameter 登陆信息id token planid
 * @params success 成功返回信息
 * @params failture 失败返回信息
 */
+ (void)systemPlan:(NSDictionary*)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

@end
