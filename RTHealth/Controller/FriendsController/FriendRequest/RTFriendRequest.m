//
//  RTFriendRequest.m
//  RTHealth
//
//  Created by cheng on 14/12/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFriendRequest.h"

@implementation RTFriendRequest

+ (void)getFansSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    
    if (userinfo.fansofmySet.count == 0) {
        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[userinfo.fansofmy allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        FriendsInfo *friendInfo = [array lastObject];
        [parameter setObject:friendInfo.friendcreatetime forKey:@"time"];
    }
    
    NSLog(@"%@",parameter);
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIENDS_FANS];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            @try {
                
                if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                    //存储数据
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
                        info.friendflag = [RTUtil isEmpty:[tempDictionary objectForKey:@"flag"]]?@"":[tempDictionary objectForKey:@"flag"];
                        [dataArray addObject:info];
                    }
                    
                    [userinfo.fansofmySet addObjectsFromArray:dataArray];
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    
                }else{
                    //错误信息
                }
                
            }
            @catch (NSException *exception) {
                
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getAttentionSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    
    if (userinfo.attentionuser.count == 0) {
        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[userinfo.attentionuser allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        FriendsInfo *friendInfo = [array lastObject];
        [parameter setObject:friendInfo.friendcreatetime forKey:@"time"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIENDS_ATTENTION];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            NSLog(@"response %@",response);
            @try {
                
                if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                    //存储数据
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
                        info.friendflag = [RTUtil isEmpty:[tempDictionary objectForKey:@"flag"]]?@"":[tempDictionary objectForKey:@"flag"];
                        [dataArray addObject:info];
                    }
                    
                    [userinfo.attentionuserSet addObjectsFromArray:dataArray];
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
+ (void)getNearBySuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:[NSString stringWithFormat:@"%f",userData.latitude ]forKey:@"positionX"];
    [parameter setObject:[NSString stringWithFormat:@"%f",userData.longitude ]forKey:@"positionY"];
    [parameter setObject:[NSString stringWithFormat:@"20"]forKey:@"distance"];
//    if (userinfo.nearbyuser.count == 0) {
//        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
//    }else{
//        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[userinfo.nearbyuser allObjects]];
//        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
//        [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
//        FriendsInfo *friendInfo = [array lastObject];
//        [parameter setObject:friendInfo.friendcreatetime forKey:@"time"];
//    }
    NSLog(@"params%@",parameter);
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIENDS_NEARBY];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            NSLog(@"response %@",response);
            @try {
                
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据if
                if (![RTUtil isEmpty:[response objectForKey:@"data"]]) {
                    
                NSArray *temp = [response objectForKey:@"data"];
                NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                for (NSDictionary *tempDictionary in temp) {
                    FriendsInfo *info = [FriendsInfo MR_createEntity];
                    info.friendid = [tempDictionary objectForKey:@"id"];
                    info.friendname = [RTUtil isEmpty:[tempDictionary objectForKey:@"name"]]?@"":[tempDictionary objectForKey:@"name"];
                    info.friendnickname = [RTUtil isEmpty:[tempDictionary objectForKey:@"nickname"]]?@"":[tempDictionary objectForKey:@"nickname"];
                    info.friendcreatetime = [RTUtil isEmpty:[tempDictionary objectForKey:@"created_time"]]?@"":[tempDictionary objectForKey:@"created_time"];
                    info.friendphoto = [RTUtil isEmpty:[tempDictionary objectForKey:@"headPortrait"]]?@"":[tempDictionary objectForKey:@"headPortrait"];
                    info.friendintroduce = [RTUtil isEmpty:[tempDictionary objectForKey:@"introduce"]]?@"":[tempDictionary objectForKey:@"introduce"];
                    info.friendbirthday = [RTUtil isEmpty:[tempDictionary objectForKey:@"birthday"]]?nil:[tempDictionary objectForKey:@"birthday"];
                    info.friendsex = [RTUtil isEmpty:[tempDictionary objectForKey:@"sex"]]?@"1":[tempDictionary objectForKey:@"sex"];
                    info.friendtype= [RTUtil isEmpty:[tempDictionary objectForKey:@"type"]]?@"1":[tempDictionary objectForKey:@"type"];
                    info.friendfavoritesports = [RTUtil isEmpty:[tempDictionary objectForKey:@"sportdata"]]?@"":[tempDictionary objectForKey:@"sportdata"];
                    info.friendflag = [RTUtil isEmpty:[tempDictionary objectForKey:@"flag"]]?@"":[tempDictionary objectForKey:@"flag"];
                    [dataArray addObject:info];
                    info.frienddistance = [RTUtil isEmpty:[tempDictionary objectForKey:@"distance"]]?nil:[NSNumber numberWithFloat:[[tempDictionary objectForKey:@"distance"] floatValue]];
                    [dataArray addObject:info];
                }
                
                [userinfo.nearbyuserSet addObjectsFromArray:dataArray];
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

+ (void)getPopularSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    
    if (userinfo.popularityuser.count == 0) {
        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[userinfo.popularityuser allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendfansnumber" ascending:NO];
        NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"friendcreatetime" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1, nil]];
        FriendsInfo *friendInfo = [array lastObject];
        [parameter setObject:friendInfo.friendcreatetime forKey:@"time"];
        [parameter setObject:friendInfo.friendfansnumber forKey:@"fansnumber"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIENDS_POPULAR];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            NSLog(@"response %@",response);
            @try {
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                NSArray *temp = [response objectForKey:@"data"];
                NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                for (NSDictionary *tempDictionary in temp) {
                    FriendsInfo *info = [FriendsInfo MR_createEntity];
                    info.friendid = [tempDictionary objectForKey:@"id"];
                    info.friendname = [RTUtil isEmpty:[tempDictionary objectForKey:@"nickname"]]?@"":[tempDictionary objectForKey:@"name"];
                    info.friendnickname = [RTUtil isEmpty:[tempDictionary objectForKey:@"nickname"]]?@"":[tempDictionary objectForKey:@"nickname"];
                    info.friendcreatetime = [RTUtil isEmpty:[tempDictionary objectForKey:@"created_time"]]?@"":[tempDictionary objectForKey:@"created_time"];
                    info.friendphoto = [RTUtil isEmpty:[tempDictionary objectForKey:@"headPortrait"]]?@"":[tempDictionary objectForKey:@"headPortrait"];
                    info.friendintroduce = [RTUtil isEmpty:[tempDictionary objectForKey:@"introduce"]]?@"":[tempDictionary objectForKey:@"introduce"];
                    info.friendbirthday = [RTUtil isEmpty:[tempDictionary objectForKey:@"birthday"]]?nil:[tempDictionary objectForKey:@"birthday"];
                    info.friendsex = [RTUtil isEmpty:[tempDictionary objectForKey:@"sex"]]?@"1":[tempDictionary objectForKey:@"sex"];
                    info.friendtype= [RTUtil isEmpty:[tempDictionary objectForKey:@"type"]]?@"1":[tempDictionary objectForKey:@"type"];
                    info.friendfavoritesports = [RTUtil isEmpty:[tempDictionary objectForKey:@"sportdata"]]?@"":[tempDictionary objectForKey:@"sportdata"];
                    info.friendflag = [RTUtil isEmpty:[tempDictionary objectForKey:@"flag"]]?@"":[tempDictionary objectForKey:@"flag"];
                    info.friendfansnumber = [RTUtil isEmpty:[tempDictionary objectForKey:@"fansnumber"]]?nil:[NSNumber numberWithInt:[[tempDictionary objectForKey:@"fansnumber"] intValue]];
                    [dataArray addObject:info];
                }
                
                [userinfo.popularityuserSet addObjectsFromArray:dataArray];
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

+ (void)getTearcherSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    
    if (userinfo.teacheruser.count == 0) {
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[userinfo.teacheruser allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendpoint" ascending:NO];
        NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"friendcreatetime" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1, nil]];
        [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        FriendsInfo *friendInfo = [array lastObject];
        [parameter setObject:friendInfo.friendcreatetime forKey:@"time"];
        [parameter setObject:friendInfo.friendpoint forKey:@"fansnumber"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIENDS_TEACHER];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            NSLog(@"response %@",response);
            @try {
                if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                    //存储数据
                    NSArray *temp = [response objectForKey:@"data"];
                    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                    for (NSDictionary *tempDictionary in temp) {
                        FriendsInfo *info = [FriendsInfo MR_createEntity];
                        info.friendid = [tempDictionary objectForKey:@"id"];
                        info.friendname = [RTUtil isEmpty:[tempDictionary objectForKey:@"name"]]?@"":[tempDictionary objectForKey:@"name"];
                        info.friendnickname = [RTUtil isEmpty:[tempDictionary objectForKey:@"nickname"]]?@"":[tempDictionary objectForKey:@"nickname"];
                        info.friendcreatetime = [RTUtil isEmpty:[tempDictionary objectForKey:@"created_time"]]?@"":[tempDictionary objectForKey:@"created_time"];
                        info.friendphoto = [RTUtil isEmpty:[tempDictionary objectForKey:@"headPortrait"]]?@"":[tempDictionary objectForKey:@"headPortrait"];
                        info.friendintroduce = [RTUtil isEmpty:[tempDictionary objectForKey:@"introduce"]]?@"":[tempDictionary objectForKey:@"introduce"];
                        info.friendbirthday = [RTUtil isEmpty:[tempDictionary objectForKey:@"birthday"]]?nil:[tempDictionary objectForKey:@"birthday"];
                        info.friendsex = [RTUtil isEmpty:[tempDictionary objectForKey:@"sex"]]?@"1":[tempDictionary objectForKey:@"sex"];
                        info.friendtype= [RTUtil isEmpty:[tempDictionary objectForKey:@"type"]]?@"1":[tempDictionary objectForKey:@"type"];
                        info.friendfavoritesports = [RTUtil isEmpty:[tempDictionary objectForKey:@"sportdata"]]?@"":[tempDictionary objectForKey:@"sportdata"];
                        info.friendflag = [RTUtil isEmpty:[tempDictionary objectForKey:@"flag"]]?@"":[tempDictionary objectForKey:@"flag"];
                        [dataArray addObject:info];
                        info.friendpoint = [RTUtil isEmpty:[tempDictionary objectForKey:@"fansnumber"]]?@"0":[tempDictionary objectForKey:@"fansnumber"];
                    }
                    
                    [userinfo.teacheruserSet addObjectsFromArray:dataArray];
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

+ (void)fansCreateFriend:(FriendsInfo*)friendInfo Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:friendInfo.friendid forKey:@"fansid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIENDS_FANSCREATE];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            NSLog(@"response %@",response);
            
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
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

+ (void)fansDeleteFriend:(FriendsInfo*)friendInfo Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:friendInfo.friendid forKey:@"fansid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_FRIENDS_FANSDELETE];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            NSLog(@"response %@",response);
            
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                friendInfo.friendflag = @"1";
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

@end
