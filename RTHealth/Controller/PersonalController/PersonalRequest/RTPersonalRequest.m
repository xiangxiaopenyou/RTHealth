//
//  RTPersonalRequest.m
//  RTHealth
//
//  Created by cheng on 14/11/19.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPersonalRequest.h"
#import "RTNominate.h"

@implementation RTPersonalRequest

+ (void)userInfoWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PERSONAL_INFO];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                NSDictionary *tempDictionary = [response objectForKey:@"data"];
                
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                
                user.usernickname = [RTUtil isEmpty:[tempDictionary objectForKey:@"nickname"]]?@"":[tempDictionary objectForKey:@"nickname"];
                user.userphoto = [RTUtil isEmpty:[tempDictionary objectForKey:@"userheadportrait"]]?nil:[tempDictionary objectForKey:@"userheadportrait"];
                user.usersex = [RTUtil isEmpty:[tempDictionary objectForKey:@"usersex"]]?@"1":[tempDictionary objectForKey:@"usersex"];
                
                user.userweight = [RTUtil isEmpty:[tempDictionary objectForKey:@"userweight"]]?nil:[tempDictionary objectForKey:@"userweight"];
                user.userbirthday = [RTUtil isEmpty:[tempDictionary objectForKey:@"userbirthday"]]?nil:[tempDictionary objectForKey:@"userbirthday"];
                user.usergeopoint = [RTUtil isEmpty:[tempDictionary objectForKey:@"usergeopoint"]]?nil:[tempDictionary objectForKey:@"usergeopoint"];
                user.userheight = [RTUtil isEmpty:[tempDictionary objectForKey:@"userheight"]]?nil:[tempDictionary objectForKey:@"userheight"];
                user.userheightpublic = [RTUtil isEmpty:[tempDictionary objectForKey:@"heightpublic"]]?[NSNumber numberWithInt:1]:[NSNumber numberWithInt:[[tempDictionary objectForKey:@"heightpublic"] intValue]];
                user.userweightpublic = [RTUtil isEmpty:[tempDictionary objectForKey:@"weightpublic"]]?[NSNumber numberWithInt:1]:[NSNumber numberWithInt:[[tempDictionary objectForKey:@"weightpublic"] intValue]];
                user.userintroduce = [RTUtil isEmpty:[tempDictionary objectForKey:@"userintroduce"]]?nil:[tempDictionary objectForKey:@"userintroduce"];
                user.userfavoritesports = [RTUtil isEmpty:[tempDictionary objectForKey:@"sports"]]?nil:[tempDictionary objectForKey:@"sports"];
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


+ (void)userOtherInfoWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PERSONAL_FANSNUMBER];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                NSDictionary *tempDictionary = [response objectForKey:@"data"];
                
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                
                user.userfansnumber = [NSString stringWithFormat:@"%@",[tempDictionary objectForKey:@"fansnumber"]];
                user.userattentionnumber = [NSString stringWithFormat:@"%@",[tempDictionary objectForKey:@"interestnumber"]];
                user.useractivitynumber = [NSString stringWithFormat:@"%@",[tempDictionary objectForKey:@"activitynumber"]];
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


+ (void)userPlanWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PERSONAL_PLAN];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                NSDictionary *tempDictionary = [response objectForKey:@"data"];
                
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
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

+ (void)modifyUserInfoWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    if (![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:@"正在发送..."];
    }
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PERSONAL_MODIFY];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                [JDStatusBarNotification showWithStatus:@"个人信息修改成功"];
            }else{
                //错误信息
                [JDStatusBarNotification showWithStatus:@"个人信息修改失败"];
            }
            success(response);
        }
        [JDStatusBarNotification dismiss];
    }failure:^(NSError *error){
        if (failure) {
            [JDStatusBarNotification showWithStatus:@"网络失败"];
            [JDStatusBarNotification dismiss];
            failure(error);
        }
    }];
}
+ (void)modifyHeadInfoWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    if (![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:@"正在发送..."];
    }
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PERSOANL_HEADPHOTO];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                [JDStatusBarNotification showWithStatus:@"个人信息修改成功"];
            }else{
                //错误信息
                [JDStatusBarNotification showWithStatus:@"个人信息修改失败"];
            }
            success(response);
        }
        [JDStatusBarNotification dismiss];
    }failure:^(NSError *error){
        if (failure) {
            [JDStatusBarNotification showWithStatus:@"网络失败"];
            [JDStatusBarNotification dismiss];
            failure(error);
        }
    }];
}
+ (void)uploadImage:(NSDictionary*)parameter imageparams:(UIImage*)imageparams success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@",URL_UPLOADIMAGE];
    NSLog(@"url %@ %@",url,parameter);
    
    [RTNetWork postMulti:url params:parameter imageparams:imageparams success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)uploadImage:(UIImage*)image success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
        if (image) {
            NSString *filename = [NSString stringWithFormat:@"%@",[CustomDate getFileNameString:[NSDate date]]];
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager POST:URL_GETTOKEN parameters:[NSDictionary dictionaryWithObjectsAndKeys:filename,@"key", nil] success:^(AFHTTPRequestOperation *operation,id responseObj){
                
                NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:filename,@"key",operation.responseString,@"token", nil];
                [RTPersonalRequest uploadImage:dictionary imageparams:image success:^(id response){
                    
                }failure:^(NSError *error){
                    
                }];
                NSLog(@"%@",operation.responseString);
            } failure:^(AFHTTPRequestOperation *operation,NSError *error){
                
                NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:filename,@"key",operation.responseString,@"token", nil];
                [RTPersonalRequest uploadImage:dictionary imageparams:image success:^(id response){
                    
                }failure:^(NSError *error){
                    
                }];
                NSLog(@"%@",operation.responseString);
            }];

    }
}


+ (void)finishedSmallPlan:(NSDictionary*)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PERSONAL_FINISHEDSMALLPLAN];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:params success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
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

+ (void)getNominate:(NSMutableArray*)array success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_HOME_NOMINATE];
    NSLog(@"url %@",url);
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                if ([RTUtil isEmpty:[response objectForKey:@"data"]]) {
                    return ;
                }
                if (array == nil) {
                    return;
                }
                [array removeAllObjects];
                NSArray *tempArray = [response objectForKey:@"data"];
                for (NSDictionary *tempDictionary in tempArray) {
                    
                    if ([RTUtil isEmpty:[tempDictionary objectForKey:@"date"]]) {
                        return;
                    }
                    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
                    NSArray *dateArray = [tempDictionary objectForKey:@"data"];
                    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                    for (NSDictionary *nominates in dateArray) {
                        
                        RTNominate *nominate = [[RTNominate alloc]init];
                        nominate.content = [RTUtil isEmpty:[nominates objectForKey:@"content"]]?nil:[nominates objectForKey:@"content"];
                        nominate.photourl = [RTUtil isEmpty:[nominates objectForKey:@"photo"]]?nil:[nominates objectForKey:@"photo"];
                        nominate.title = [RTUtil isEmpty:[nominates objectForKey:@"title"]]?nil:[nominates objectForKey:@"title"];
                        nominate.url = [RTUtil isEmpty:[nominates objectForKey:@"url"]]?nil:[nominates objectForKey:@"url"];
                        [dataArray addObject:nominate];
                    }
                    [dictionary setObject:[tempDictionary objectForKey:@"date"] forKey:@"date"];
                    [dictionary setObject:dateArray forKey:@"data"];
                    
                    [array addObject:dictionary];
                }
                //存储数据
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

+ (void)checkUpdateSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_CHECK_UPDATE];
    NSLog(@"url %@",url);
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:AppVersion forKey:@"version"];
//    [parameter setObject:@"1" forKey:@"isappstore"];
    
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
                if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                    //存储数据
                    
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

+ (void)setDeviceTokenSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PUSH_TOKEN];
    NSLog(@"url %@",url);
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:userData.deviceToken forKey:@"devicetoken"];
    
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
                if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                    //存储数据
                    NSLog(@"devicetoken success");
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
