//
//  RTFriendDetailRequest.m
//  RTHealth
//
//  Created by cheng on 14/12/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFriendDetailRequest.h"

@implementation RTFriendDetailRequest

+ (void)friendInfoWith:(FriendsInfo*)friendInfo success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:userinfo.userid,@"userid",userinfo.usertoken,@"usertoken",friendInfo.friendid,@"friendid", nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIEND_INFO];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:param success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                @try{
                //存储数据
                    if (![RTUtil isEmpty:[response objectForKey:@"data"]]) {
                    
                    
                    NSDictionary *dictionary = [response objectForKey:@"data"];
                    
                    friendInfo.friendname = [RTUtil isEmpty:[dictionary objectForKey:@"username"]]?@"":[dictionary objectForKey:@"username"];
                    friendInfo.friendnickname = [RTUtil isEmpty:[dictionary objectForKey:@"nickname"]]?@" ":[dictionary objectForKey:@"nickname"];
                    friendInfo.friendphoto = [RTUtil isEmpty:[dictionary objectForKey:@"userheadportrait"]]?@"":[dictionary objectForKey:@"userheadportrait"];
                    friendInfo.friendsex = [RTUtil isEmpty:[dictionary objectForKey:@"usersex"]]?@"":[dictionary objectForKey:@"usersex"];
                    friendInfo.friendbirthday = [RTUtil isEmpty:[dictionary objectForKey:@"userbirthday"]]?nil:[dictionary objectForKey:@"userbirthday"];
                    friendInfo.friendheight = [RTUtil isEmpty:[dictionary objectForKey:@"userheight"]]?@"":[dictionary objectForKey:@"userheight"];
                    friendInfo.friendweight = [RTUtil isEmpty:[dictionary objectForKey:@"userweight"]]?@"":[dictionary objectForKey:@"userweight"];
                    friendInfo.friendintroduce = [RTUtil isEmpty:[dictionary objectForKey:@"userintroduce"]]?@"":[dictionary objectForKey:@"userintroduce"];
                    friendInfo.friendfavoritesports = [RTUtil isEmpty:[dictionary objectForKey:@"sports"]]?@"":[dictionary objectForKey:@"sports"];
                    friendInfo.friendfansnumber = [RTUtil isEmpty:[dictionary objectForKey:@"count_fans"]]?nil:[NSNumber numberWithInt:[[dictionary objectForKey:@"count_fans"] intValue]];
                    friendInfo.friendactivitynumber = [RTUtil isEmpty:[dictionary objectForKey:@"count_activity"]]?@"":[dictionary objectForKey:@"count_activity"];
                    friendInfo.friendattentionnumber = [RTUtil isEmpty:[dictionary objectForKey:@"count_follow"]]?@"":[dictionary objectForKey:@"count_follow"];
                    friendInfo.friendflag = [RTUtil isEmpty:[dictionary objectForKey:@"flag"]]?@"1":[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"flag"]];
                    
                    HealthPlan *plan = [HealthPlan MR_createEntity];
                    //存储数据
                    if (![RTUtil isEmpty:[response objectForKey:@"plandata"]]){
                        NSDictionary *temp = [response objectForKey:@"plandata"];
                        
                        NSDictionary *planDic = [temp objectForKey:@"plan"];
                        plan.planid = [planDic objectForKey:@"id"];
                        plan.plancontent = [RTUtil isEmpty:[planDic objectForKey:@"content"]]?@"":[planDic objectForKey:@"content"];
                        plan.plancreatetime = [RTUtil isEmpty:[planDic objectForKey:@"created_time"]]?nil:[planDic objectForKey:@"created_time"];
                        plan.plancycledayValue = [[planDic objectForKey:@"cycleDay"] integerValue];
                        plan.plancyclenumberValue = [[planDic objectForKey:@"cycleRound"] integerValue];
                        plan.plantitle = [RTUtil isEmpty:[planDic objectForKey:@"title"]]?nil:[planDic objectForKey:@"title"];
                        plan.plantype = [RTUtil isEmpty:[planDic objectForKey:@"type"]]?@"0":[planDic objectForKey:@"type"];
                        plan.planlevel = [RTUtil isEmpty:[planDic objectForKey:@"level"]]?@"":[planDic objectForKey:@"level"];
                        plan.planpublic = [RTUtil isEmpty:[planDic objectForKey:@"planpublic"]]?@"1":[planDic objectForKey:@"planpublic"];
                        plan.planflag = [RTUtil isEmpty:[planDic objectForKey:@"flag"]]?@"1":[planDic objectForKey:@"flag"];
                        plan.plannumber = [NSNumber numberWithInt:[RTUtil isEmpty:[planDic objectForKey:@"recommend_num"]]?1:[[planDic objectForKey:@"recommend_num"] intValue]];
                        plan.plancreateuserid = [RTUtil isEmpty:[planDic objectForKey:@"recommend_userid"]]?nil:[planDic objectForKey:@"recommend_userid"];
                        plan.planbegindate = [RTUtil isEmpty:[planDic objectForKey:@"starttime"]]?[NSDate date]:[CustomDate getDate:[planDic objectForKey:@"starttime"]];
                        
                        NSMutableArray *array = [[NSMutableArray alloc]init];
                        NSArray *tempArray = [temp objectForKey:@"plansub"];
                        //存储数据
                        if ( ![RTUtil isEmpty:[temp objectForKey:@"plansub"]]) {
                            
                            for (NSDictionary *tempDic in tempArray) {
                                SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
                                
                                smallPlan.smallplanid = [RTUtil isEmpty:[tempDic objectForKey:@"id"]]?nil:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"id"]];
                                smallPlan.smallplanbegintime = [RTUtil isEmpty:[tempDic objectForKey:@"startTime"]]?nil:[tempDic objectForKey:@"startTime"];
                                smallPlan.smallplanendtime = [RTUtil isEmpty:[tempDic objectForKey:@"endTime"]]?nil:[tempDic objectForKey:@"endTime"];
                                smallPlan.smallplanmark = [RTUtil isEmpty:[tempDic objectForKey:@"mark"]]?@"":[tempDic objectForKey:@"mark"];
                                smallPlan.smallplancontent = [RTUtil isEmpty:[tempDic objectForKey:@"content"]]?nil:[tempDic objectForKey:@"content"];
                                smallPlan.smallplancost = [RTUtil isEmpty:[tempDic objectForKey:@"introduce"]]?nil:[tempDic objectForKey:@"introduce"];
                                smallPlan.smallplantype = [RTUtil isEmpty:[tempDic objectForKey:@"type"]]?nil:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"type"]];
                                smallPlan.smallplansequence = [RTUtil isEmpty:[tempDic objectForKey:@"sequence"]]?nil:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"sequence"]];
                                smallPlan.smallplancycle = [RTUtil isEmpty:[tempDic objectForKey:@"cycleRound"]]?nil:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"cycleRound"]];
                                smallPlan.smallplanstateflag = [RTUtil isEmpty:[tempDic objectForKey:@"flag"]]?nil:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"flag"]];
                                
                                [array addObject:smallPlan];
                            }
                            plan.smallhealthplan = [[NSSet alloc]initWithArray:array];
                            
                            friendInfo.healthplan = plan;
                        }
                    }
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                }
                }
                @catch (NSException *exception){
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

+ (void)friendPlanWith:(FriendsInfo*)friendInfo success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userInfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userInfo.userid forKey:@"userid"];
    [parameter setObject:userInfo.usertoken forKey:@"usertoken"];
    [parameter setObject:friendInfo.friendid forKey:@"friendid"];
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIEND_PLAN];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            
                @try{
                    //存储数据
                    if (![RTUtil isEmpty:[response objectForKey:@"startdata"]]) {
                        
                        NSDictionary *startDictionary = [response objectForKey:@"startdata"];
                        NSDictionary *planDictionary = [startDictionary objectForKey:@"plan"];
                        NSArray *smallPlanArray = [startDictionary objectForKey:@"plansub"];
                        if ([RTUtil isEmpty:planDictionary]) {
                        }else{
                            HealthPlan *startPlan = [HealthPlan MR_createEntity];
                            startPlan.planid = [RTUtil isEmpty:[planDictionary objectForKey:@"id"]]?nil:[NSString stringWithFormat:@"%@",[planDictionary objectForKey:@"id"]];
                            startPlan.planbegindate = [RTUtil isEmpty:[planDictionary objectForKey:@"starttime"]]?nil:[CustomDate getDate:[planDictionary objectForKey:@"starttime"]];
                            startPlan.plancreatetime = [RTUtil isEmpty:[planDictionary objectForKey:@"created_time"]]?nil:[planDictionary objectForKey:@"created_time"];
                            startPlan.plancontent = [RTUtil isEmpty:[planDictionary objectForKey:@"content"]]?nil:[planDictionary objectForKey:@"content"];
                            startPlan.plancreateuserid = [RTUtil isEmpty:[planDictionary objectForKey:@"recommend_userid"]]?nil:[NSString stringWithFormat:@"%@",[planDictionary objectForKey:@"recommend_userid"]];
                            startPlan.plancycleday = [RTUtil isEmpty:[planDictionary objectForKey:@"cycleDay"]]?nil:[NSNumber numberWithInt:[[planDictionary objectForKey:@"cycleDay"] intValue]];
                            startPlan.plancyclenumber = [RTUtil isEmpty:[planDictionary objectForKey:@"cycleRound"]]?nil:[NSNumber numberWithInt:[[planDictionary objectForKey:@"cycleRound"] intValue]];
                            startPlan.planflag = [RTUtil isEmpty:[planDictionary objectForKey:@"flag"]]?nil:[NSString stringWithFormat:@"%@",[planDictionary objectForKey:@"flag"]];
                            startPlan.planlevel = [RTUtil isEmpty:[planDictionary objectForKey:@"level"]]?nil:[NSString stringWithFormat:@"%@",[planDictionary objectForKey:@"level"]];
                            startPlan.plantitle = [RTUtil isEmpty:[planDictionary objectForKey:@"title"]]?nil:[NSString stringWithFormat:@"%@",[planDictionary objectForKey:@"title"]];
                            startPlan.plantype = [RTUtil isEmpty:[planDictionary objectForKey:@"type"]]?nil:[NSString stringWithFormat:@"%@",[planDictionary objectForKey:@"type"]];
                            NSMutableArray *array = [[NSMutableArray alloc]init];
                            for (NSDictionary *dictionary in smallPlanArray) {
                                SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
                                smallPlan.smallplanbegintime = [RTUtil isEmpty:[dictionary objectForKey:@"startTime"]]?nil:[dictionary objectForKey:@"startTime"];
                                smallPlan.smallplancontent = [RTUtil isEmpty:[dictionary objectForKey:@"content"]]?nil:[dictionary objectForKey:@"content"];
                                smallPlan.smallplancost = [RTUtil isEmpty:[dictionary objectForKey:@"introduce"]]?nil:[dictionary objectForKey:@"introduce"];
                                smallPlan.smallplanendtime = [RTUtil isEmpty:[dictionary objectForKey:@"endTime"]]?nil:[dictionary objectForKey:@"endTime"];
                                smallPlan.smallplanid = [RTUtil isEmpty:[dictionary objectForKey:@"id"]]?nil:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"id"]];
                                smallPlan.smallplanmark = [RTUtil isEmpty:[dictionary objectForKey:@"mark"]]?nil:[dictionary objectForKey:@"mark"];
                                smallPlan.smallplansequence = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"sequence"]];
                                smallPlan.smallplancycle = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"cycleRound"]];
                                smallPlan.smallplanstateflag = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"state"]];
                                smallPlan.smallplantype = [RTUtil isEmpty:[dictionary objectForKey:@"type"]]?nil:[dictionary objectForKey:@"type"];
                                [array addObject:smallPlan];
                            }
                            startPlan.smallhealthplan = [[NSSet alloc]initWithArray:array];
                            friendInfo.healthplan = startPlan;
                        }
                        
                    }
                    
                    NSArray *arrayCanStart = [response objectForKey:@"weredata"];
                    if ([RTUtil isEmpty:arrayCanStart]) {
                        [friendInfo.canstartplanSet removeAllObjects];
                    }else{
                        NSMutableArray *arrayPlan = [[NSMutableArray alloc]init];
                        for (NSDictionary *canStartDictionary in arrayCanStart) {
                            
                            HealthPlan *canstartPlan = [HealthPlan MR_createEntity];
                            canstartPlan.planid = [canStartDictionary objectForKey:@"id"];
                            canstartPlan.plancreatetime = [canStartDictionary objectForKey:@"created_time"];
                            canstartPlan.plancontent = [RTUtil isEmpty:[canStartDictionary objectForKey:@"content"]]?nil:[canStartDictionary objectForKey:@"content"];
                            canstartPlan.plancreateuserid = [RTUtil isEmpty:[canStartDictionary objectForKey:@"recommend_userid"]]?nil:[canStartDictionary objectForKey:@"recommend_userid"];
                            canstartPlan.plancycleday = [NSNumber numberWithInt:[[canStartDictionary objectForKey:@"cycleDay"] intValue]];
                            canstartPlan.plancyclenumber = [NSNumber numberWithInt:[[canStartDictionary objectForKey:@"cycleRound"] intValue]];
                            canstartPlan.planflag = [RTUtil isEmpty:[canStartDictionary objectForKey:@"flag"]]?@"0":[canStartDictionary objectForKey:@"flag"];
                            canstartPlan.planlevel = [RTUtil isEmpty:[canStartDictionary objectForKey:@"level"]]?@"":[canStartDictionary objectForKey:@"level"];
                            canstartPlan.plantitle = [RTUtil isEmpty:[canStartDictionary objectForKey:@"title"]]?nil:[canStartDictionary objectForKey:@"title"];
                            canstartPlan.plantype = [RTUtil isEmpty:[canStartDictionary objectForKey:@"type"]]?nil:[canStartDictionary objectForKey:@"type"];
                            [arrayPlan addObject:canstartPlan];
                            
                        }
                        [friendInfo.canstartplanSet removeAllObjects];
                        [friendInfo.canstartplanSet addObjectsFromArray:arrayPlan];
                    }
                    
                    
                    NSArray *arrayFinish = [response objectForKey:@"enddata"];
                    if ([RTUtil isEmpty:arrayFinish]) {
                        [friendInfo.finishplanSet removeAllObjects];
                    }else{
                        NSMutableArray *arrayPlanFinish = [[NSMutableArray alloc]init];
                        for (NSDictionary *finishplanDictionary in arrayFinish) {
                            
                            HealthPlan *finishPlan = [HealthPlan MR_createEntity];
                            finishPlan.planid = [finishplanDictionary objectForKey:@"id"];
                            finishPlan.plancreatetime = [finishplanDictionary objectForKey:@"created_time"];
                            finishPlan.plancontent = [RTUtil isEmpty:[finishplanDictionary objectForKey:@"content"]]?nil:[finishplanDictionary objectForKey:@"content"];
                            finishPlan.plancreateuserid = [RTUtil isEmpty:[finishplanDictionary objectForKey:@"recommend_userid"]]?nil:[finishplanDictionary objectForKey:@"recommend_userid"];
                            finishPlan.plancycleday = [NSNumber numberWithInt:[[finishplanDictionary objectForKey:@"cycleDay"] intValue]];
                            finishPlan.plancyclenumber = [NSNumber numberWithInt:[[finishplanDictionary objectForKey:@"cycleRound"] intValue]];
                            finishPlan.planflag = [RTUtil isEmpty:[finishplanDictionary objectForKey:@"flag"]]?@"0":[finishplanDictionary objectForKey:@"flag"];
                            finishPlan.planlevel = [RTUtil isEmpty:[finishplanDictionary objectForKey:@"level"]]?@"":[finishplanDictionary objectForKey:@"level"];
                            finishPlan.plantitle = [RTUtil isEmpty:[finishplanDictionary objectForKey:@"title"]]?nil:[finishplanDictionary objectForKey:@"title"];
                            finishPlan.plantype = [RTUtil isEmpty:[finishplanDictionary objectForKey:@"type"]]?nil:[finishplanDictionary objectForKey:@"type"];
                            [arrayPlanFinish addObject:finishPlan];
                            
                        }
                        [friendInfo.finishplanSet removeAllObjects];
                        [friendInfo.finishplanSet addObjectsFromArray:arrayPlanFinish];
                    }
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                }
                @catch (NSException *exception){
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


+ (void)friendfansWith:(FriendsInfo*)friendInfo success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:userinfo.userid,@"userid",userinfo.usertoken,@"usertoken",friendInfo.friendid,@"friendid", nil];
    if (friendInfo.friendfansSet.count == 0) {
        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[friendInfo.friendfans allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        FriendsInfo *friendInfo = [array lastObject];
        [parameter setObject:friendInfo.friendcreatetime forKey:@"time"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIEND_FANS];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                
                @try {
                    
                    NSArray *temp = [response objectForKey:@"data"];
                    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                    for (NSDictionary *tempDictionary in temp) {
                        FriendsInfo *info = [FriendsInfo MR_createEntity];
                        info.friendid = [tempDictionary objectForKey:@"id"];
                        info.friendname = [RTUtil isEmpty:[tempDictionary objectForKey:@"name"]]?nil:[tempDictionary objectForKey:@"name"];
                        info.friendnickname = [RTUtil isEmpty:[tempDictionary objectForKey:@"nickname"]]?@"":[tempDictionary objectForKey:@"nickname"];
                        info.friendcreatetime = [RTUtil isEmpty:[tempDictionary objectForKey:@"created_time"]]?@"":[tempDictionary objectForKey:@"created_time"];
                        info.friendphoto = [RTUtil isEmpty:[tempDictionary objectForKey:@"headPortrait"]]?@"":[tempDictionary objectForKey:@"headPortrait"];
                        info.friendintroduce = [RTUtil isEmpty:[tempDictionary objectForKey:@"introduce"]]?@"":[tempDictionary objectForKey:@"introduce"];
                        info.friendbirthday = [RTUtil isEmpty:[tempDictionary objectForKey:@"birthday"]]?nil:[tempDictionary objectForKey:@"birthday"];
                        info.friendsex = [RTUtil isEmpty:[tempDictionary objectForKey:@"sex"]]?@"1":[tempDictionary objectForKey:@"sex"];
                        info.friendtype= [RTUtil isEmpty:[tempDictionary objectForKey:@"type"]]?@"1":[tempDictionary objectForKey:@"type"];
                        info.friendfavoritesports = [RTUtil isEmpty:[tempDictionary objectForKey:@"sportdata"]]?@"":[tempDictionary objectForKey:@"sportdata"];
                        info.friendflag = [RTUtil isEmpty:[tempDictionary objectForKey:@"flag"]]?@"1":[NSString stringWithFormat:@"%@",[tempDictionary objectForKey:@"flag"]];
                        [dataArray addObject:info];
                    }
                    
                    [friendInfo.friendfansSet addObjectsFromArray:dataArray];
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    
                }
                @catch (NSException *exception) {
                    
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


+ (void)friendAttentionWith:(FriendsInfo*)friendInfo success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:userinfo.userid,@"userid",userinfo.usertoken,@"usertoken",friendInfo.friendid,@"friendid", nil];
    
    if (friendInfo.friendattentionSet.count == 0) {
        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[friendInfo.friendattention allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        FriendsInfo *friendInfo = [array lastObject];
        [parameter setObject:friendInfo.friendcreatetime forKey:@"time"];
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIEND_ATTENTION];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            NSLog(@"response %@",response);
            
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                @try {
                    NSArray *temp = [response objectForKey:@"data"];
                    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                    for (NSDictionary *tempDictionary in temp) {
                        FriendsInfo *info = [FriendsInfo MR_createEntity];
                        info.friendid = [tempDictionary objectForKey:@"id"];
                        info.friendname = [tempDictionary objectForKey:@"name"];
                        info.friendnickname = [RTUtil isEmpty:[tempDictionary objectForKey:@"nickname"]]?@"":[tempDictionary objectForKey:@"nickname"];
                        info.friendcreatetime = [RTUtil isEmpty:[tempDictionary objectForKey:@"created_time"]]?@"":[tempDictionary objectForKey:@"created_time"];
                        info.friendphoto = [RTUtil isEmpty:[tempDictionary objectForKey:@"headPortrait"]]?@"":[tempDictionary objectForKey:@"headPortrait"];
                        info.friendintroduce = [RTUtil isEmpty:[tempDictionary objectForKey:@"introduce"]]?@"":[tempDictionary objectForKey:@"introduce"];
                        info.friendbirthday = [RTUtil isEmpty:[tempDictionary objectForKey:@"birthday"]]?nil:[tempDictionary objectForKey:@"birthday"];
                        info.friendsex = [RTUtil isEmpty:[tempDictionary objectForKey:@"sex"]]?@"1":[tempDictionary objectForKey:@"sex"];
                        info.friendtype= [RTUtil isEmpty:[tempDictionary objectForKey:@"type"]]?@"1":[tempDictionary objectForKey:@"type"];
                        info.friendfavoritesports = [RTUtil isEmpty:[tempDictionary objectForKey:@"sportdata"]]?@"":[tempDictionary objectForKey:@"sportdata"];
                        info.friendflag = [RTUtil isEmpty:[tempDictionary objectForKey:@"flag"]]?@"1":[NSString stringWithFormat:@"%@",[tempDictionary objectForKey:@"flag"]];
                        [dataArray addObject:info];
                    }
                    
                    [friendInfo.friendattentionSet addObjectsFromArray:dataArray];
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    
                    
                }
                @catch (NSException *exception) {
                    
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
@end
