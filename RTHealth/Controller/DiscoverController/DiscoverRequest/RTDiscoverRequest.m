//
//  RTDiscoverRequest.m
//  RTHealth
//
//  Created by cheng on 14/11/25.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTDiscoverRequest.h"

@implementation RTDiscoverRequest

+ (void)getPlanWithTime:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PLAN_GETIMPORT];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
                if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                    RTUserInfo *userData = [RTUserInfo getInstance];
                    UserInfo *user = userData.userData;
                    
                    NSMutableArray *array = [[NSMutableArray alloc]init];
                    //存储数据
                    NSArray *tempArray = [response objectForKey:@"data"];
                    for (NSDictionary *tempDic in tempArray) {
                        
                        HealthPlan *plan = [HealthPlan MR_createEntity];
                        plan.planid = [tempDic objectForKey:@"id"];
                        plan.plancontent = [RTUtil isEmpty:[tempDic objectForKey:@"content"]]?@"":[tempDic objectForKey:@"content"];
                        plan.plancreatetime = [tempDic objectForKey:@"created_time"];
                        plan.plancycleday =  [NSNumber numberWithInt:[[tempDic objectForKey:@"cycleDay"] intValue]];
                        plan.plancyclenumber = [NSNumber numberWithInt:[[tempDic objectForKey:@"cycleRound"] intValue]];
                        plan.planflag = [RTUtil isEmpty:[tempDic objectForKey:@"flag"]]?@"0":[tempDic objectForKey:@"flag"];
                        plan.planlevel = [RTUtil isEmpty:[tempDic objectForKey:@"level"]]?@"":[tempDic objectForKey:@"level"];
                        plan.plannumber = [NSNumber numberWithInt:[[tempDic objectForKey:@"recommend_num"] intValue]];
                        plan.planpublic = [tempDic objectForKey:@"planpublic"];
                        plan.plantitle = [tempDic objectForKey:@"title"];
                        plan.plantype = [tempDic objectForKey:@"type"];
                        
                        [array addObject:plan];
                    }
                    [user.importplantimeSet addObjectsFromArray:array];
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


+ (void)getPlanWithPopular:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PLAN_GETIMPORT];
    NSLog(@"url %@",url);
    NSLog(@"parameter %@",parameter);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
                if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                    //存储数据
                    
                    RTUserInfo *userData = [RTUserInfo getInstance];
                    UserInfo *user = userData.userData;
                    
                    NSMutableArray *array = [[NSMutableArray alloc]init];
                    //存储数据
                    NSArray *tempArray = [response objectForKey:@"data"];
                    for (NSDictionary *tempDic in tempArray) {
                        
                        HealthPlan *plan = [HealthPlan MR_createEntity];
                        plan.planid = [tempDic objectForKey:@"id"];
                        plan.plancontent = [RTUtil isEmpty:[tempDic objectForKey:@"content"]]?@"":[tempDic objectForKey:@"content"];
                        plan.plancreatetime = [tempDic objectForKey:@"created_time"];
                        plan.plancycleday =  [NSNumber numberWithInt:[[tempDic objectForKey:@"cycleDay"] intValue]];
                        plan.plancyclenumber = [NSNumber numberWithInt:[[tempDic objectForKey:@"cycleRound"] intValue]];
                        plan.planflag = [RTUtil isEmpty:[tempDic objectForKey:@"flag"]]?@"0":[tempDic objectForKey:@"flag"];
                        plan.planid = [tempDic objectForKey:@"id"];
                        plan.planlevel = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"level"]];
                        plan.plannumber = [NSNumber numberWithInt:[[tempDic objectForKey:@"recommend_num"] intValue]];
                        plan.planpublic = [tempDic objectForKey:@"planpublic"];
                        plan.plantitle = [tempDic objectForKey:@"title"];
                        plan.plantype = [tempDic objectForKey:@"type"];
                        
                        [array addObject:plan];
                    }
                    [user.importplanrenqiSet addObjectsFromArray:array];
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

+ (void)getSearchWithArray:(NSMutableArray*)array Key:(NSString*)key success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *user = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:user.userid forKey:@"userid"];
    [parameter setObject:user.usertoken forKey:@"usertoken"];
    [parameter setObject:key forKey:@"searchkey"];
    
    if (array.count == 0) {
        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        FriendsInfo *friendInfo = [array lastObject];
        [parameter setObject:friendInfo.friendcreatetime forKey:@"time"];
        [parameter setObject:friendInfo.friendfansnumber forKey:@"fansnumber"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_SEARCH];
    NSLog(@"url %@",url);
    NSLog(@"parameter %@",parameter);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
                if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                    //存储数据
                    if (![RTUtil isEmpty:[response objectForKey:@"data"]]) {
                        
                        NSArray *temp = [response objectForKey:@"data"];
                        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                        for (NSDictionary *tempDictionary in temp) {
                            FriendsInfo *info = [FriendsInfo MR_createEntity];
                            info.friendid = [tempDictionary objectForKey:@"id"];
                            info.friendname = [RTUtil isEmpty:[tempDictionary objectForKey:@"name"]]?@"":[tempDictionary objectForKey:@"name"];
                            info.friendnickname = [RTUtil isEmpty:[tempDictionary objectForKey:@"nickname"]]?@" ":[tempDictionary objectForKey:@"nickname"];
                            info.friendcreatetime = [RTUtil isEmpty:[tempDictionary objectForKey:@"created_time"]]?@"":[tempDictionary objectForKey:@"created_time"];
                            info.friendphoto = [RTUtil isEmpty:[tempDictionary objectForKey:@"headPortrait"]]?@"":[tempDictionary objectForKey:@"headPortrait"];
                            info.friendintroduce = [RTUtil isEmpty:[tempDictionary objectForKey:@"introduce"]]?@"":[tempDictionary objectForKey:@"introduce"];
                            info.friendbirthday = [RTUtil isEmpty:[tempDictionary objectForKey:@"birthday"]]?nil:[tempDictionary objectForKey:@"birthday"];
                            info.friendsex = [RTUtil isEmpty:[tempDictionary objectForKey:@"sex"]]?@"1":[tempDictionary objectForKey:@"sex"];
                            info.friendtype= [RTUtil isEmpty:[tempDictionary objectForKey:@"type"]]?@"1":[tempDictionary objectForKey:@"type"];
                            info.friendfavoritesports = [RTUtil isEmpty:[tempDictionary objectForKey:@"sportdata"]]?@"":[tempDictionary objectForKey:@"sportdata"];
                            info.friendflag = [RTUtil isEmpty:[tempDictionary objectForKey:@"flag"]]?@"":[tempDictionary objectForKey:@"flag"];
                            info.friendfansnumber = [RTUtil isEmpty:[tempDictionary objectForKey:@"fansnumber"]]?[NSNumber numberWithInt:0]:[NSNumber numberWithInt:[[tempDictionary objectForKey:@"fansnumber"] intValue]];
                            [dataArray addObject:info];
                        }
                        
                        [array addObjectsFromArray:dataArray];
                        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                        
                    }
                    
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
