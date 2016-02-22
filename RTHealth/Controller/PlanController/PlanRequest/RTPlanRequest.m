 //
//  RTPlanRequest.m
//  RTHealth
//
//  Created by cheng on 14/11/21.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPlanRequest.h"

@implementation RTPlanRequest

+ (void)addPlanWith:(NSDictionary*)parameter Plan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PLAN_ADD];
    NSLog(@"url %@",url);
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userinfo.userid forKey:@"userid"];
    [parameters setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameters setObject:plan.plantype forKey:@"plantype"];
    [parameters setObject:plan.plantitle forKey:@"plantitle"];
    [parameters setObject:plan.planpublic forKey:@"planpublic"];
    [parameters setObject:plan.plancycleday forKey:@"plancycleday"];
    [parameters setObject:plan.plancyclenumber forKey:@"plancycleround"];
    [parameters setObject:plan.plancontent forKey:@"plancontent"];
    NSMutableArray *array = [[NSMutableArray alloc ]init];
    for (SmallHealthPlan *smallPlan in plan.smallhealthplan) {
        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
        [temp setValue:smallPlan.smallplanbegintime forKey:@"plandetailbegintime"];
        [temp setValue:smallPlan.smallplancontent forKey:@"plandetailcontent"];
        [temp setValue:smallPlan.smallplanendtime forKey:@"plandetailendtime"];
        [temp setValue:smallPlan.smallplantype forKey:@"plandetailtype"];
        [temp setValue:smallPlan.smallplansequence forKey:@"plandetailsequence"];
        if ([RTUtil isEmpty:smallPlan.smallplanmark]){
            [temp setValue:@"无" forKey:@"plandetailmark"];
        }else{
            [temp setValue:smallPlan.smallplanmark forKey:@"plandetailmark"];
        }
        
        [array addObject:temp];
    }
    [parameters setObject:array  forKey:@"smallplan"];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:parameters];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"新建计划");
        if (error) {
            NSLog(@"Error: %@ %@", error , response);
        } else {
            NSLog(@"Error:  %@",  responseObject);
            NSDictionary *dictionary = (NSDictionary*)responseObject;
            if ([[dictionary objectForKey:@"state"]integerValue] == URL_NORMAL) {
                
                @try {
                //存储数据
                NSDictionary *tempDictionary = [dictionary objectForKey:@"data"];
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                plan.planid = [NSString stringWithFormat:@"%@",[tempDictionary objectForKey:@"id"]];
                for (SmallHealthPlan *removeSmallPlan in plan.smallhealthplan){
                    [removeSmallPlan MR_deleteEntity];
                }
                [plan.smallhealthplanSet removeAllObjects];
                
                if (![RTUtil isEmpty:[tempDictionary objectForKey:@"smallplan"]]) {
                    NSArray *array = [tempDictionary objectForKey:@"smallplan"];
                    for (int j = 0; j < [plan.plancyclenumber intValue]; j++) {
                        for (int i = 0; i < array.count; i ++) {
                            NSDictionary *dictemp = [array objectAtIndex:i];
                            SmallHealthPlan *smallplanobj = [SmallHealthPlan MR_createEntity];
                            smallplanobj.smallplanbegintime = [dictemp objectForKey:@"startTime"];
                            smallplanobj.smallplanmark = [RTUtil isEmpty:[dictemp objectForKey:@"mark"]]?@"":[dictemp objectForKey:@"mark"];
                            smallplanobj.smallplancontent = [RTUtil isEmpty:[dictemp objectForKey:@"content"]]?@"":[dictemp objectForKey:@"content"];
                            smallplanobj.smallplancost = [dictemp objectForKey:@"introduce"];
                            smallplanobj.smallplancycle = [NSString stringWithFormat:@"%d",j];
                            smallplanobj.smallplanendtime = [dictemp objectForKey:@"endTime"];
                            smallplanobj.smallplanid = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"planid"]];
                            smallplanobj.smallplansequence = [dictemp objectForKey:@"sequence"];
                            smallplanobj.smallplanstateflag = [RTUtil isEmpty:[dictemp objectForKey:@"flag"]]?@"":[dictemp objectForKey:@"flag"];
                            smallplanobj.smallplantype = [dictemp objectForKey:@"type"];
                            [plan.smallhealthplanSet addObject:smallplanobj];
                        }
                    }
                }
                [user.canstartplanSet addObject:plan];
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    
                    
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                if (success) {
                    success(responseObject);
                }
            }else{
                //错误信息
                if (failure) {
                    failure(error);
                }
            }

        }
    }];
    [dataTask resume];
}

+ (void)detailWithPlan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:plan.planid forKey:@"planid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PLAN_DETAIL];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                NSDictionary *temp = [response objectForKey:@"data"];
                
                NSDictionary *planDic = [temp objectForKey:@"plan"];
                plan.plancontent = [planDic objectForKey:@"content"];
                plan.plancreatetime = [planDic objectForKey:@"created_time"];
                plan.plancycledayValue = [[planDic objectForKey:@"cycleDay"] integerValue];
                plan.plancyclenumberValue = [[planDic objectForKey:@"cycleRound"] integerValue];
                plan.plantitle = [planDic objectForKey:@"title"];
                plan.plantype = [planDic objectForKey:@"type"];
                plan.planlevel = [RTUtil isEmpty:[planDic objectForKey:@"level"]]?@"":[planDic objectForKey:@"level"];
                plan.planpublic = [planDic objectForKey:@"planpublic"];
                plan.planflag = [RTUtil isEmpty:[planDic objectForKey:@"flag"]]?@"":[planDic objectForKey:@"flag"];
                plan.plannumber = [NSNumber numberWithInt:[[planDic objectForKey:@"recommend_num"] intValue]];
                plan.plancreateuserid = [planDic objectForKey:@"recommend_userid"];
                plan.planstate = [planDic objectForKey:@"state"];
                
                NSMutableArray *array = [[NSMutableArray alloc]init];
                NSArray *tempArray = [temp objectForKey:@"plansub"];
                //存储数据
                if ( ![RTUtil isEmpty:[temp objectForKey:@"plansub"]]) {
                    
                    for (NSDictionary *tempDic in tempArray) {
                        SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
                        
                        smallPlan.smallplanid = [tempDic objectForKey:@"id"];
                        smallPlan.smallplanbegintime = [tempDic objectForKey:@"startTime"];
                        smallPlan.smallplanendtime = [tempDic objectForKey:@"endTime"];
                        smallPlan.smallplanmark = [RTUtil isEmpty:[tempDic objectForKey:@"mark"]]?@"":[tempDic objectForKey:@"mark"];
                        smallPlan.smallplancontent = [RTUtil isEmpty:[tempDic objectForKey:@"content"]]?@"":[tempDic objectForKey:@"content"];
                        smallPlan.smallplancost = [tempDic objectForKey:@"introduce"];
                        smallPlan.smallplantype = [tempDic objectForKey:@"type"];
                        smallPlan.smallplansequence = [tempDic objectForKey:@"sequence"];
                        smallPlan.smallplancycle = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"cycleRound"]];
                        smallPlan.smallplanstateflag = [tempDic objectForKey:@"flag"];
                        
                        [array addObject:smallPlan];
                    }
                    for (SmallHealthPlan *removeSmallPlan in plan.smallhealthplan){
                        [removeSmallPlan MR_deleteEntity];
                    }[plan.smallhealthplanSet removeAllObjects];
                    plan.smallhealthplan = [[NSSet alloc]initWithArray:array];
                }
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                
            }else{
                //错误信息
            }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)importWithPlan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    if (![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:@"正在发送..."];
    }
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:plan.planid forKey:@"planid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PLAN_IMPORT];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                plan.planimported = @"2";
                [user.canstartplanSet addObject:plan];
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                
                [JDStatusBarNotification showWithStatus:@"导入计划成功"];
            }else{
                //错误信息
                [JDStatusBarNotification showWithStatus:@"导入计划失败"];
            }
            success(response);
        }
        [JDStatusBarNotification dismiss];
    }failure:^(NSError *error){
        if (failure) {
            [JDStatusBarNotification showWithStatus:@"导入计划失败"];
            [JDStatusBarNotification dismiss];

            failure(error);
        }
    }];
}

+ (void)deleteWithPlan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    if (![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:@"正在发送..."];
    }
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:plan.planid forKey:@"planid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PLAN_DELETE];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                [plan MR_deleteEntity];
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                [JDStatusBarNotification showWithStatus:@"删除计划成功"];
                
            }else{
                //错误信息
                [JDStatusBarNotification showWithStatus:@"删除计划失败"];
            }
            success(response);
        }
        [JDStatusBarNotification dismiss];
    }failure:^(NSError *error){
        if (failure) {
            [JDStatusBarNotification showWithStatus:@"导入计划失败"];
            [JDStatusBarNotification dismiss];
            failure(error);
        }
    }];
}
+ (void)stopWithPlan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    if (![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:@"正在发送..."];
    }
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:plan.planid forKey:@"planid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PLAN_STOP];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                user.healthplan = nil;
                [user.canstartplanSet addObject:plan];
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                
                [JDStatusBarNotification showWithStatus:@"停止计划成功"];
            }else{
                //错误信息
                [JDStatusBarNotification showWithStatus:@"停止计划失败"];
            }
            success(response);
        }
        [JDStatusBarNotification dismiss];
    }failure:^(NSError *error){
        if (failure) {
            [JDStatusBarNotification showWithStatus:@"停止计划失败"];
            [JDStatusBarNotification dismiss];
            failure(error);
        }
    }];
}

+ (void)startWithPlan:(HealthPlan*)plan success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    if (![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:@"正在发送..."];
    }
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:plan.planid forKey:@"planid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PLAN_START];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
                if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                    //存储数据
                    
                    RTUserInfo *userData = [RTUserInfo getInstance];
                    UserInfo *user = userData.userData;
                    HealthPlan *removeplan = userinfo.healthplan;
                    if (![RTUtil isEmpty:removeplan]) {
                        [userinfo.canstartplanSet addObject:removeplan];
                        userinfo.healthplan = nil;
                    }
                    
                    HealthPlan *healthPlan = [HealthPlan MR_createEntity];
                    NSDictionary *temp = [response objectForKey:@"data"];
                    
                    NSDictionary *planDic = [temp objectForKey:@"plan"];
                    healthPlan.planimported = @"2";
                    healthPlan.planbegindate = [NSDate date];
                    healthPlan.planid = [planDic objectForKey:@"id"];
                    healthPlan.plancontent = [planDic objectForKey:@"content"];
                    healthPlan.plancreatetime = [planDic objectForKey:@"created_time"];
                    healthPlan.plancycledayValue = [[planDic objectForKey:@"cycleDay"] integerValue];
                    healthPlan.plancyclenumberValue = [[planDic objectForKey:@"cycleRound"] integerValue];
                    healthPlan.plantitle = [planDic objectForKey:@"title"];
                    healthPlan.plantype = [planDic objectForKey:@"type"];
                    healthPlan.planlevel = [RTUtil isEmpty:[planDic objectForKey:@"level"]]?@"":[planDic objectForKey:@"level"];
                    healthPlan.planpublic = [planDic objectForKey:@"planpublic"];
                    healthPlan.planflag = [RTUtil isEmpty:[planDic objectForKey:@"flag"]]?@"0":[planDic objectForKey:@"flag"];
                    healthPlan.plannumber = [NSNumber numberWithInt:[[planDic objectForKey:@"recommend_num"] intValue]];
                    healthPlan.plancreateuserid = [planDic objectForKey:@"recommend_userid"];
                    
                    NSMutableArray *array = [[NSMutableArray alloc]init];
                    NSArray *tempArray = [temp objectForKey:@"plansub"];
                    //存储数据
                    if ( ![RTUtil isEmpty:[temp objectForKey:@"plansub"]]) {
                        
                        for (NSDictionary *tempDic in tempArray) {
                            SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
                            
                            smallPlan.smallplanid = [tempDic objectForKey:@"id"];
                            smallPlan.smallplanbegintime = [tempDic objectForKey:@"startTime"];
                            smallPlan.smallplanendtime = [tempDic objectForKey:@"endTime"];
                            smallPlan.smallplanmark = [RTUtil isEmpty:[tempDic objectForKey:@"mark"]]?@"":[tempDic objectForKey:@"mark"];
                            smallPlan.smallplancontent = [RTUtil isEmpty:[tempDic objectForKey:@"content"]]?@"":[tempDic objectForKey:@"content"];
                            smallPlan.smallplancost = [tempDic objectForKey:@"introduce"];
                            smallPlan.smallplantype = [tempDic objectForKey:@"type"];
                            smallPlan.smallplansequence = [tempDic objectForKey:@"sequence"];
                            smallPlan.smallplancycle = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"cycleRound"]];
                            smallPlan.smallplanstateflag = [tempDic objectForKey:@"flag"];
                            
                            [array addObject:smallPlan];
                        }
                        for (SmallHealthPlan *removeSmallPlan in plan.smallhealthplan){
                            [removeSmallPlan MR_deleteEntity];
                        }
                        [plan.smallhealthplanSet removeAllObjects];
                        healthPlan.smallhealthplan = [[NSSet alloc]initWithArray:array];
                    }
                    
                    
                    user.healthplan = healthPlan;
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:REGISTERNOTIFICATION object:nil];
                    
                    
                    [JDStatusBarNotification showWithStatus:@"开始计划成功"];
                    
                }else{
                    //错误信息
                    [JDStatusBarNotification showWithStatus:@"开始计划失败"];
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            success(response);
        }
        [JDStatusBarNotification dismiss];
    }failure:^(NSError *error){
        if (failure) {
            [JDStatusBarNotification showWithStatus:@"停止计划失败"];
            [JDStatusBarNotification dismiss];
            failure(error);
        }
    }];
}


+ (void)getMyPlan:(NSDictionary*)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PERSONAL_MYPLAN];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:params success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                @try {
                    
                    [self addStartPlan:response];
                    [self addEndPlan:response];
                    [self addImportPlan:response];
                    
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
            }else{
                //错误信息
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)addStartPlan:(NSDictionary*)response{
    if ([RTUtil isEmpty:[response objectForKey:@"startdata"]]) {
        return;
    }
    
    NSDictionary *startDictionary = [response objectForKey:@"startdata"];
    if ([RTUtil isEmpty:[startDictionary objectForKey:@"plan"]]) {
        return;
    }
    NSDictionary *planDictionary = [startDictionary objectForKey:@"plan"];
    NSArray *smallPlanArray = [startDictionary objectForKey:@"plansub"];
    if ([RTUtil isEmpty:planDictionary]) {
        return;
    }
    HealthPlan *startPlan = [HealthPlan MR_createEntity];
    startPlan.planid = [planDictionary objectForKey:@"id"];
    startPlan.planbegindate = [CustomDate getDate:[planDictionary objectForKey:@"starttime"]];
    startPlan.plancreatetime = [planDictionary objectForKey:@"created_time"];
    startPlan.plancontent = [planDictionary objectForKey:@"content"];
    startPlan.plancreateuserid = [planDictionary objectForKey:@"recommend_userid"];
    startPlan.plancycleday = [NSNumber numberWithInt:[[planDictionary objectForKey:@"cycleDay"] intValue]];
    startPlan.plancyclenumber = [NSNumber numberWithInt:[[planDictionary objectForKey:@"cycleRound"] intValue]];
    startPlan.planflag = [RTUtil isEmpty:[planDictionary objectForKey:@"flag"]]?@"0":[planDictionary objectForKey:@"flag"];
    startPlan.planlevel = [RTUtil isEmpty:[planDictionary objectForKey:@"level"]]?@"0":[planDictionary objectForKey:@"level"];
    startPlan.plantitle = [planDictionary objectForKey:@"title"];
    startPlan.plantype = [planDictionary objectForKey:@"type"];
    startPlan.plannumber = [NSNumber numberWithInt:[RTUtil isEmpty:[planDictionary objectForKey:@"recommend_num"]]?0:[[planDictionary objectForKey:@"recommend_num"] intValue]];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dictionary in smallPlanArray) {
        SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
        smallPlan.smallplanbegintime = [dictionary objectForKey:@"startTime"];
        smallPlan.smallplancontent = [RTUtil isEmpty:[dictionary objectForKey:@"content"]]?@"":[dictionary objectForKey:@"content"];
        smallPlan.smallplancost = [dictionary objectForKey:@"introduce"];
        smallPlan.smallplanendtime = [dictionary objectForKey:@"endTime"];
        smallPlan.smallplanid = [dictionary objectForKey:@"id"];
        smallPlan.smallplanmark = [RTUtil isEmpty:[dictionary objectForKey:@"mark"]]?@"":[dictionary objectForKey:@"mark"];
        smallPlan.smallplansequence = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"sequence"]];
        smallPlan.smallplancycle = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"cycleRound"]];
        smallPlan.smallplanstateflag = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"flag"]];
        smallPlan.smallplantype = [dictionary objectForKey:@"type"];
        [array addObject:smallPlan];
    }
    startPlan.smallhealthplan = [[NSSet alloc]initWithArray:array];
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *user = userData.userData;
    user.healthplan = startPlan;
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:REGISTERNOTIFICATION object:nil];
}

+ (void)addImportPlan:(NSDictionary *)response
{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *user = userData.userData;
    NSArray *array = [response objectForKey:@"weredata"];
    if ([RTUtil isEmpty:array]) {
        return;
    }
    
    for (HealthPlan *removePlan in user.canstartplan) {
        for (SmallHealthPlan *removeSmallPlan in removePlan.smallhealthplan) {
            [removeSmallPlan MR_deleteEntity];
        }
        [removePlan MR_deleteEntity];
    }
    [user.canstartplanSet removeAllObjects];
    
    NSMutableArray *arrayPlan = [[NSMutableArray alloc]init];
    for (NSDictionary *planDictionary in array) {
        
        HealthPlan *startPlan = [HealthPlan MR_createEntity];
        startPlan.planid = [planDictionary objectForKey:@"id"];
        startPlan.planbegindate = [RTUtil isEmpty:[planDictionary objectForKey:@"created_time"]]?[NSDate date]:[CustomDate getDate:[planDictionary objectForKey:@"created_time"]];
        startPlan.plancreatetime = [RTUtil isEmpty:[planDictionary objectForKey:@"created_time"]]?[CustomDate getDateString:[NSDate date]]:[planDictionary objectForKey:@"created_time"];
        startPlan.plancontent = [RTUtil isEmpty:[planDictionary objectForKey:@"content"]]?@"":[planDictionary objectForKey:@"content"];
        startPlan.plancreateuserid = [RTUtil isEmpty:[planDictionary objectForKey:@"recommend_userid"]]?@"":[planDictionary objectForKey:@"recommend_userid"];
        startPlan.plancycleday = [RTUtil isEmpty:[planDictionary objectForKey:@"cycleDay"]]?[NSNumber numberWithInt:0]:[NSNumber numberWithInt:[[planDictionary objectForKey:@"cycleDay"] intValue]];
        startPlan.plancyclenumber = [RTUtil isEmpty:[planDictionary objectForKey:@"cycleRound"]]?[NSNumber numberWithInt:0]:[NSNumber numberWithInt:[[planDictionary objectForKey:@"cycleRound"] intValue]];
        startPlan.planflag = [RTUtil isEmpty:[planDictionary objectForKey:@"flag"]]?@"0":[planDictionary objectForKey:@"flag"];
        startPlan.planlevel = [RTUtil isEmpty:[planDictionary objectForKey:@"level"]]?@"0":[planDictionary objectForKey:@"level"];
        startPlan.plantitle = [RTUtil isEmpty:[planDictionary objectForKey:@"title"]]?@"":[planDictionary objectForKey:@"title"];
        startPlan.plantype = [RTUtil isEmpty:[planDictionary objectForKey:@"type"]]?@"0":[planDictionary objectForKey:@"type"];
        startPlan.plannumber = [NSNumber numberWithInt:[RTUtil isEmpty:[planDictionary objectForKey:@"recommend_num"]]?0:[[planDictionary objectForKey:@"recommend_num"] intValue]];
        [arrayPlan addObject:startPlan];
        
    }
    user.canstartplan = [[NSSet alloc]initWithArray:arrayPlan];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
}

+ (void)addEndPlan:(NSDictionary *)response
{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *user = userData.userData;
    NSArray *array = [response objectForKey:@"enddata"];
    if ([RTUtil isEmpty:array]) {
        return;
    }
    for (HealthPlan *removePlan in user.finishedplan) {
        for (SmallHealthPlan *removeSmallPlan in removePlan.smallhealthplan) {
            [removeSmallPlan MR_deleteEntity];
        }
        [removePlan MR_deleteEntity];
    }
    [user.finishedplanSet removeAllObjects];
    
    NSMutableArray *arrayPlan = [[NSMutableArray alloc]init];
    for (NSDictionary *planDictionary in array) {

        HealthPlan *startPlan = [HealthPlan MR_createEntity];
        startPlan.planid = [planDictionary objectForKey:@"id"];
        startPlan.planbegindate = [RTUtil isEmpty:[planDictionary objectForKey:@"created_time"]]?[NSDate date]:[CustomDate getDate:[planDictionary objectForKey:@"created_time"]];
        startPlan.plancreatetime = [RTUtil isEmpty:[planDictionary objectForKey:@""]]?[CustomDate getDateString:[NSDate date]]:[planDictionary objectForKey:@"created_time"];
        startPlan.plancontent = [RTUtil isEmpty:[planDictionary objectForKey:@"content"]]?@"":[planDictionary objectForKey:@"content"];
        startPlan.plancreateuserid = [RTUtil isEmpty:[planDictionary objectForKey:@"recommend_userid"]]?@"":[planDictionary objectForKey:@"recommend_userid"];
        startPlan.plancycleday = [RTUtil isEmpty:[planDictionary objectForKey:@"cycleDay"]]?[NSNumber numberWithInt:0]:[NSNumber numberWithInt:[[planDictionary objectForKey:@"cycleDay"] intValue]];
        startPlan.plancyclenumber = [RTUtil isEmpty:[planDictionary objectForKey:@"cycleRound"]]?[NSNumber numberWithInt:0]:[NSNumber numberWithInt:[[planDictionary objectForKey:@"cycleRound"] intValue]];
        startPlan.planflag = [RTUtil isEmpty:[planDictionary objectForKey:@"flag"]]?@"0":[planDictionary objectForKey:@"flag"];
        startPlan.planlevel = [RTUtil isEmpty:[planDictionary objectForKey:@"level"]]?@"0":[planDictionary objectForKey:@"level"];
        startPlan.plantitle = [RTUtil isEmpty:[planDictionary objectForKey:@"title"]]?@"":[planDictionary objectForKey:@"title"];
        startPlan.plantype = [RTUtil isEmpty:[planDictionary objectForKey:@"type"]]?@"0":[planDictionary objectForKey:@"type"];
        startPlan.plannumber = [NSNumber numberWithInt:[RTUtil isEmpty:[planDictionary objectForKey:@"recommend_num"]]?0:[[planDictionary objectForKey:@"recommend_num"] intValue]];
        [arrayPlan addObject:startPlan];
    }

    user.finishedplan = [[NSSet alloc]initWithArray:arrayPlan];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
}

+ (void)systemPlan:(NSDictionary*)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PERSONAL_SYSTEMPLAN];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:params success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                NSArray *array = [response objectForKey:@"data"];
                if ([RTUtil isEmpty:array]) {
                    
                    return;
                }
                for (HealthPlan *removePlan in user.systemplan) {
                    for (SmallHealthPlan *removeSmallPlan in removePlan.smallhealthplan) {
                        [removeSmallPlan MR_deleteEntity];
                    }
                    [removePlan MR_deleteEntity];
                }
                [user.systemplanSet removeAllObjects];
                
                NSMutableArray *arrayPlan = [[NSMutableArray alloc]init];
                for (NSDictionary *planDictionary in array) {
                    
                    HealthPlan *startPlan = [HealthPlan MR_createEntity];
                    startPlan.planid = [planDictionary objectForKey:@"id"];
                    startPlan.plancreatetime = [RTUtil isEmpty:[planDictionary objectForKey:@"created_time"]]?[CustomDate getDateString:[NSDate date]]:[planDictionary objectForKey:@"created_time"];
                    startPlan.plancontent = [RTUtil isEmpty:[planDictionary objectForKey:@"content"]]?@"":[planDictionary objectForKey:@"content"];
                    startPlan.plancreateuserid = [planDictionary objectForKey:@"recommend_userid"];
                    startPlan.plancycleday = [RTUtil isEmpty:[planDictionary objectForKey:@"cycleDay"]]?[NSNumber numberWithInt:0]:[NSNumber numberWithInt:[[planDictionary objectForKey:@"cycleDay"] intValue]];
                    startPlan.plancyclenumber = [RTUtil isEmpty:[planDictionary objectForKey:@"cycleRound"]]?[NSNumber numberWithInt:0]:[NSNumber numberWithInt:[[planDictionary objectForKey:@"cycleRound"] intValue]];
                    startPlan.planflag = [RTUtil isEmpty:[planDictionary objectForKey:@"flag"]]?@"0":[planDictionary objectForKey:@"flag"];
                    startPlan.planlevel = [RTUtil isEmpty:[planDictionary objectForKey:@"level"]]?@"0":[planDictionary objectForKey:@"level"];
                    startPlan.plantitle = [RTUtil isEmpty:[planDictionary objectForKey:@"title"]]?@"":[planDictionary objectForKey:@"title"];
                    startPlan.plantype = [RTUtil isEmpty:[planDictionary objectForKey:@"type"]]?@"":[planDictionary objectForKey:@"type"];
                    startPlan.plannumber = [NSNumber numberWithInt:[RTUtil isEmpty:[planDictionary objectForKey:@"recommend_num"]]?0:[[planDictionary objectForKey:@"recommend_num"] intValue]];
                    [arrayPlan addObject:startPlan];
                    
                }
                [user.systemplanSet addObjectsFromArray: arrayPlan];
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
            }else{
                //错误信息
            }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}

@end
