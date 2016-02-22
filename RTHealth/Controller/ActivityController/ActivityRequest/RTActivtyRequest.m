//
//  RTActivtyRequest.m
//  RTHealth
//
//  Created by 项小盆友 on 14/12/5.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTActivtyRequest.h"

@implementation RTActivtyRequest

+ (void)createActivityWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_CREATEACTIVITY];
    [RTNetWork post:url params:parameter success:^(id response) {
        if(success){
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getMyActivityWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE,URL_GETMYACTIVITY];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *userinfo = userData.userData;
                NSMutableArray *finishArray = [[NSMutableArray alloc] init];
                NSMutableArray *underwayArray = [[NSMutableArray alloc] init];
                if (![RTUtil isEmpty:[[[response objectForKey:@"data"] objectForKey:@"complete"] objectForKey:@"data"]]) {
                    NSArray *tempFinishedArray = [[[response objectForKey:@"data"] objectForKey:@"complete"] objectForKey:@"data"];
                    //NSLog(@"array %@", tempFinishedArray);
                    for (NSDictionary *tempFinishedDic in tempFinishedArray) {
                        Activity *activity = [Activity MR_createEntity];
                        //NSLog(@"%@", tempFinishedDic);
                        activity.activityid = [tempFinishedDic objectForKey:@"id"];
                        activity.activitycreatedtime = [tempFinishedDic objectForKey:@"created_time"];
                        activity.activitytitle = [tempFinishedDic objectForKey:@"title"];
                        activity.activitycontent = [tempFinishedDic objectForKey:@"content"];
                        activity.activitybegintime = [tempFinishedDic objectForKey:@"starttime"];
                        activity.activityendtime = [tempFinishedDic objectForKey:@"endtime"];
                        activity.activitylimittime = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"enrolltime"]]?@"":[tempFinishedDic objectForKey:@"enrolltime"];
                        activity.activityplace = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"address"]]?@"":[tempFinishedDic objectForKey:@"address"];
                        activity.activitylimitnumber = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"limitpeople"]]?@"":[tempFinishedDic objectForKey:@"limitpeople"];
                        activity.activitynumber = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"people"]]?@"":[tempFinishedDic objectForKey:@"people"];
                        activity.activitytelephone = [tempFinishedDic objectForKey:@"tel"];
                        activity.activityownerid = [tempFinishedDic objectForKey:@"userid"];
                        activity.activityownernickname = [tempFinishedDic objectForKey:@"username"];
                        activity.positionlatitude = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"positionX"]]?@"":[tempFinishedDic objectForKey:@"positionX"];
                        activity.positionlongitude = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"positionY"]]?@"":[tempFinishedDic objectForKey:@"positionY"];
                        activity.activitydistance = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"distance"]]?@"":[tempFinishedDic objectForKey:@"distance"];
                        //[underwayArray addObject:activity];
                        [finishArray addObject:activity];
                    }
                    [userinfo.finishedactivitySet addObjectsFromArray:finishArray];
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                }
                //NSLog(@"uderway %@", [[response objectForKey:@"data"] objectForKey:@"underway"]);
                if (![RTUtil isEmpty:[[response objectForKey:@"data"] objectForKey:@"underway"] ]) {
                    NSArray *tempUnderwayArray = [[response objectForKey:@"data"] objectForKey:@"underway"];
                    for (NSDictionary *tempUnderwayDic in tempUnderwayArray) {
                        Activity *activity = [Activity MR_createEntity];
                        activity.activityid = [tempUnderwayDic objectForKey:@"id"];
                        activity.activitycreatedtime = [tempUnderwayDic objectForKey:@"created_time"];
                        activity.activitytitle = [tempUnderwayDic objectForKey:@"title"];
                        activity.activitycontent = [tempUnderwayDic objectForKey:@"content"];
                        activity.activitybegintime = [tempUnderwayDic objectForKey:@"starttime"];
                        activity.activityendtime = [tempUnderwayDic objectForKey:@"endtime"];
                        activity.activitylimittime = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"enrolltime"]]?@"":[tempUnderwayDic objectForKey:@"enrolltime"];
                        activity.activityplace = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"address"]]?@"":[tempUnderwayDic objectForKey:@"address"];
                        activity.activitylimitnumber = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"limitpeople"]]?@"":[tempUnderwayDic objectForKey:@"limitpeople"];
                        activity.activitynumber = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"people"]]?@"":[tempUnderwayDic objectForKey:@"people"];
                        activity.activitytelephone = [tempUnderwayDic objectForKey:@"tel"];
                        activity.activityownerid = [tempUnderwayDic objectForKey:@"userid"];
                        activity.activityownernickname = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"username"]]?@"":[tempUnderwayDic objectForKey:@"username"];
                        activity.positionlatitude = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"positionX"]]?@"":[tempUnderwayDic objectForKey:@"positionX"];
                        activity.positionlongitude = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"positionY"]]?@"":[tempUnderwayDic objectForKey:@"positionY"];
                        activity.activitydistance = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"distance"]]?@"":[tempUnderwayDic objectForKey:@"distance"];
                        [underwayArray addObject:activity];
                    }
                    
                }
                [userinfo.underwayactivitySet removeAllObjects];
                [userinfo.underwayactivitySet addObjectsFromArray:underwayArray];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                
            }
                
            else{
                
            }
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getFriendActivityWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_FRIEND_ACTIVITY];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *userinfo = userData.userData;
                NSMutableArray *finishArray = [[NSMutableArray alloc] init];
                NSMutableArray *underwayArray = [[NSMutableArray alloc] init];
                if (![RTUtil isEmpty:[[[response objectForKey:@"data"] objectForKey:@"complete"] objectForKey:@"data"]]) {
                    NSArray *tempFinishedArray = [[[response objectForKey:@"data"] objectForKey:@"complete"] objectForKey:@"data"];
                    //NSLog(@"array %@", tempFinishedArray);
                    for (NSDictionary *tempFinishedDic in tempFinishedArray) {
                        Activity *activity = [Activity MR_createEntity];
                        //NSLog(@"%@", tempFinishedDic);
                        activity.activityid = [tempFinishedDic objectForKey:@"id"];
                        activity.activitycreatedtime = [tempFinishedDic objectForKey:@"created_time"];
                        activity.activitytitle = [tempFinishedDic objectForKey:@"title"];
                        activity.activitycontent = [tempFinishedDic objectForKey:@"content"];
                        activity.activitybegintime = [tempFinishedDic objectForKey:@"starttime"];
                        activity.activityendtime = [tempFinishedDic objectForKey:@"endtime"];
                        activity.activitylimittime = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"enrolltime"]]?@"":[tempFinishedDic objectForKey:@"enrolltime"];
                        activity.activityplace = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"address"]]?@"":[tempFinishedDic objectForKey:@"address"];
                        activity.activitylimitnumber = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"limitpeople"]]?@"":[tempFinishedDic objectForKey:@"limitpeople"];
                        activity.activitynumber = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"people"]]?@"":[tempFinishedDic objectForKey:@"people"];
                        activity.activitytelephone = [tempFinishedDic objectForKey:@"tel"];
                        activity.activityownerid = [tempFinishedDic objectForKey:@"userid"];
                        activity.activityownernickname = [tempFinishedDic objectForKey:@"username"];
                        activity.positionlatitude = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"positionX"]]?@"":[tempFinishedDic objectForKey:@"positionX"];
                        activity.positionlongitude = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"positionY"]]?@"":[tempFinishedDic objectForKey:@"positionY"];
                        activity.activitydistance = [RTUtil isEmpty:[tempFinishedDic objectForKey:@"distance"]]?@"":[tempFinishedDic objectForKey:@"distance"];
                        //[underwayArray addObject:activity];
                        [finishArray addObject:activity];
                    }
                    [userinfo.friendfinishedactivitySet addObjectsFromArray:finishArray];
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                }
                //NSLog(@"uderway %@", [[response objectForKey:@"data"] objectForKey:@"underway"]);
                if (![RTUtil isEmpty:[[response objectForKey:@"data"] objectForKey:@"underway"] ]) {
                    NSArray *tempUnderwayArray = [[response objectForKey:@"data"] objectForKey:@"underway"];
                    for (NSDictionary *tempUnderwayDic in tempUnderwayArray) {
                        Activity *activity = [Activity MR_createEntity];
                        activity.activityid = [tempUnderwayDic objectForKey:@"id"];
                        activity.activitycreatedtime = [tempUnderwayDic objectForKey:@"created_time"];
                        activity.activitytitle = [tempUnderwayDic objectForKey:@"title"];
                        activity.activitycontent = [tempUnderwayDic objectForKey:@"content"];
                        activity.activitybegintime = [tempUnderwayDic objectForKey:@"starttime"];
                        activity.activityendtime = [tempUnderwayDic objectForKey:@"endtime"];
                        activity.activitylimittime = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"enrolltime"]]?@"":[tempUnderwayDic objectForKey:@"enrolltime"];
                        activity.activityplace = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"address"]]?@"":[tempUnderwayDic objectForKey:@"address"];
                        activity.activitylimitnumber = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"limitpeople"]]?@"":[tempUnderwayDic objectForKey:@"limitpeople"];
                        activity.activitynumber = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"people"]]?@"":[tempUnderwayDic objectForKey:@"people"];
                        activity.activitytelephone = [tempUnderwayDic objectForKey:@"tel"];
                        activity.activityownerid = [tempUnderwayDic objectForKey:@"userid"];
                        activity.activityownernickname = [tempUnderwayDic objectForKey:@"username"];
                        activity.positionlatitude = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"positionX"]]?@"":[tempUnderwayDic objectForKey:@"positionX"];
                        activity.positionlongitude = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"positionY"]]?@"":[tempUnderwayDic objectForKey:@"positionY"];
                        activity.activitydistance = [RTUtil isEmpty:[tempUnderwayDic objectForKey:@"distance"]]?@"":[tempUnderwayDic objectForKey:@"distance"];
                        [underwayArray addObject:activity];
                    }
                    
                }
                [userinfo.friendunderwayactivitySet removeAllObjects];
                [userinfo.friendunderwayactivitySet addObjectsFromArray:underwayArray];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                
            }
            
            else{
                
            }
            success(response);

        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getActivityDetailWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_ACTIVITYDETAIL];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                NSDictionary *tempDic = [response objectForKey:@"data"];
                Activity *activity = [Activity MR_createEntity];
                activity.activityownerid = [tempDic objectForKey:@"userid"];
                activity.activitytitle = [tempDic objectForKey:@"title"];
                activity.activitycontent = [tempDic objectForKey:@"content"];
                activity.activitybegintime = [tempDic objectForKey:@"starttime"];
                activity.activityendtime = [tempDic objectForKey:@"endtime"];
                activity.activitylimittime = [RTUtil isEmpty:[tempDic objectForKey:@"enrolltime"]]?@"":[tempDic objectForKey:@"enrolltime"];
                activity.activityplace = [RTUtil isEmpty:[tempDic objectForKey:@"address"]]?@"":[tempDic objectForKey:@"address"];
                activity.activitylimitnumber = [RTUtil isEmpty:[tempDic objectForKey:@"limitpeople"]]?@"":[tempDic objectForKey:@"limitpeople"];
                activity.activitynumber = [RTUtil isEmpty:[tempDic objectForKey:@"people"]]?@"":[tempDic objectForKey:@"people"];
                activity.activitytelephone = [tempDic objectForKey:@"tel"];
                activity.activitydistance = [tempDic objectForKey:@"distance"];
                activity.positionlatitude = [RTUtil isEmpty:[tempDic objectForKey:@"positionX"]]?@"":[tempDic objectForKey:@"positionX"];
                activity.positionlongitude = [RTUtil isEmpty:[tempDic objectForKey:@"positionY"]]?@"":[tempDic objectForKey:@"positionY"];
                activity.activityid = [tempDic objectForKey:@"id"];
                activity.activityownernickname = [RTUtil isEmpty:[tempDic objectForKey:@"username"]]?@"":[tempDic objectForKey:@"username"];
                activity.activitydistance = [RTUtil isEmpty:[tempDic objectForKey:@"distance"]]?@"":[tempDic objectForKey:@"distance"];
                user.activitydetail = activity;
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
            }
            else{
                
            }
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getJoinActivityMemberWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE,URL_GETJOINACTIVITYMEMBER];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getActivityWithDistance:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_GETSYSYTEMACTIVITY];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                NSArray *tempArray = [response objectForKey:@"data"];
                for(NSDictionary *tempDic in tempArray){
                    Activity *activity = [Activity MR_createEntity];
                    activity.activityownerid = [tempDic objectForKey:@"userid"];
                    activity.activitytitle = [tempDic objectForKey:@"title"];
                    activity.activitycontent = [tempDic objectForKey:@"content"];
                    activity.activitybegintime = [tempDic objectForKey:@"starttime"];
                    activity.activityendtime = [tempDic objectForKey:@"endtime"];
                    activity.activitylimittime = [RTUtil isEmpty:[tempDic objectForKey:@"enrolltime"]]?@"":[tempDic objectForKey:@"enrolltime"];
                    activity.activityplace = [RTUtil isEmpty:[tempDic objectForKey:@"address"]]?@"":[tempDic objectForKey:@"address"];
                    activity.activitylimitnumber = [RTUtil isEmpty:[tempDic objectForKey:@"limitpeople"]]?@"":[tempDic objectForKey:@"limitpeople"];
                    activity.activitynumber = [RTUtil isEmpty:[tempDic objectForKey:@"people"]]?@"":[tempDic objectForKey:@"people"];
                    activity.activitytelephone = [tempDic objectForKey:@"tel"];
                    activity.activitydistance = [tempDic objectForKey:@"distance"];
                    activity.positionlatitude = [RTUtil isEmpty:[tempDic objectForKey:@"positionX"]]?@"":[tempDic objectForKey:@"positionX"];
                    activity.positionlongitude = [RTUtil isEmpty:[tempDic objectForKey:@"positionY"]]?@"":[tempDic objectForKey:@"positionY"];
                    activity.activityid = [tempDic objectForKey:@"id"];
                    [array addObject:activity];
                    
                    
                }
                [user.addactivitydistanceSet addObjectsFromArray:array];
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
            }
            else{
                
            }
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getActivityWtihTime:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_GETSYSYTEMACTIVITY];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                NSArray *tempArray = [response objectForKey:@"data"];
                for(NSDictionary *tempDic in tempArray){
                    Activity *activity = [Activity MR_createEntity];
                    activity.activityownerid = [tempDic objectForKey:@"userid"];
                    activity.activitytitle = [tempDic objectForKey:@"title"];
                    activity.activitycontent = [tempDic objectForKey:@"content"];
                    activity.activitybegintime = [tempDic objectForKey:@"starttime"];
                    activity.activityendtime = [tempDic objectForKey:@"endtime"];
                    activity.activitylimittime = [RTUtil isEmpty:[tempDic objectForKey:@"enrolltime"]]?@"":[tempDic objectForKey:@"enrolltime"];
                    activity.activityplace = [RTUtil isEmpty:[tempDic objectForKey:@"address"]]?@"":[tempDic objectForKey:@"address"];
                    activity.activitylimitnumber = [RTUtil isEmpty:[tempDic objectForKey:@"limitpeople"]]?@"":[tempDic objectForKey:@"limitpeople"];
                    activity.activitynumber = [RTUtil isEmpty:[tempDic objectForKey:@"people"]]?@"":[tempDic objectForKey:@"people"];
                    activity.activitytelephone = [tempDic objectForKey:@"tel"];
                    activity.activitydistance = [tempDic objectForKey:@"distance"];
                    activity.positionlatitude = [RTUtil isEmpty:[tempDic objectForKey:@"positionX"]]?@"":[tempDic objectForKey:@"positionX"];
                    activity.positionlongitude = [RTUtil isEmpty:[tempDic objectForKey:@"positionY"]]?@"":[tempDic objectForKey:@"positionY"];
                    activity.activityid = [tempDic objectForKey:@"id"];
                    [array addObject:activity];
                    
                }
                [user.addactivitytimeSet addObjectsFromArray:array];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            else{
                
            }
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)joinActivityWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE,URL_JOINACTIVITY];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)exitActivityWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE,URL_EXITACTIVITY];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)cancelActivityWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE,URL_CANCELACTIVITY];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)inviteJoinActivityWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_INVITEJOINACTIVITY];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
