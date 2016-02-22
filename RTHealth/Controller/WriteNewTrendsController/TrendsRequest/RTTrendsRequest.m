//
//  RTTrendsRequest.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/25.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTTrendsRequest.h"

@implementation RTTrendsRequest

+ (void)writeTrendsWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE,URL_WRITETRENDS];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            success(response);
        }
        else{
            
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getTrendsClassifyWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_GETTRENDCLASSIFY];
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
+ (void)getTrendsListWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE,URL_GETTRENDSLIST];
    NSLog(@"%@", url);
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                NSMutableArray *array = [[NSMutableArray alloc] init];
                NSArray *tempArray = [response objectForKey:@"data"];
                for (NSDictionary *tempDic in tempArray) {
                    Trends *trend = [Trends MR_createEntity];
                    trend.trendcontent = [RTUtil isEmpty:[tempDic objectForKey:@"content"]]? @"":[tempDic objectForKey:@"content"];
                    trend.trendtime = [tempDic objectForKey:@"created_time"];
                    trend.usernickname = [RTUtil isEmpty:[tempDic objectForKey:@"nickname"]]?@"":[tempDic objectForKey:@"nickname"];
                    trend.trendphoto = [RTUtil isEmpty:[tempDic objectForKey:@"img"]]?@"":[tempDic objectForKey:@"img"];
                    trend.userphoto = [RTUtil isEmpty:[tempDic objectForKey:@"userheadportrait"]]?@"":[tempDic objectForKey:@"userheadportrait"];
                    trend.trendfavoritenumber = [tempDic objectForKey:@"like"];
                    trend.trendsharednumber = [tempDic objectForKey:@"download"];
                    trend.trendcommentnumber = [tempDic objectForKey:@"comments"];
                    trend.trendtype = [RTUtil isEmpty:[tempDic objectForKey:@"type"]]?@"":[tempDic objectForKey:@"type"];
                    trend.trendclassify = [RTUtil isEmpty:[tempDic objectForKey:@"label"]]?@"":[tempDic objectForKey:@"label"];
                    trend.isfavorite = [tempDic objectForKey:@"isfavorite"];
                    trend.trendid = [tempDic objectForKey:@"id"];
                    trend.usertype = [RTUtil isEmpty:[tempDic objectForKey:@"usertype"]]?@"":[tempDic objectForKey:@"usertype"];
                    trend.usersex = [RTUtil isEmpty:[tempDic objectForKey:@"sex"]]?@"":[tempDic objectForKey:@"sex"];
                    trend.userid = [tempDic objectForKey:@"userid"];
                    trend.useraddress = [RTUtil isEmpty:[tempDic objectForKey:@"address"]]?@"":[tempDic objectForKey:@"address"];
                
                    [array addObject:trend];
                    
                    
                }
                
                //[user.alltrendsSet removeAllObjects];
                [user.alltrendsSet addObjectsFromArray:array];
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

+ (void)getSportsTrendsWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_GETSPORTSTRENDS];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            if ([[response objectForKey:@"state"]  integerValue] == URL_NORMAL){
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *userinfo = userData.userData;
                NSMutableArray *array = [[NSMutableArray alloc] init];
                NSArray *tempArray = [response objectForKey:@"data"];
                for(NSDictionary *tempDic in tempArray){
                    Trends *trend = [Trends MR_createEntity];
                    trend.trendcontent = [RTUtil isEmpty:[tempDic objectForKey:@"content"]]? @"":[tempDic objectForKey:@"content"];
                    trend.trendtime = [tempDic objectForKey:@"created_time"];
                    trend.usernickname = [RTUtil isEmpty:[tempDic objectForKey:@"nickname"]]?@"":[tempDic objectForKey:@"nickname"];
                    trend.trendphoto = [RTUtil isEmpty:[tempDic objectForKey:@"img"]]?@"":[tempDic objectForKey:@"img"];
                    trend.userphoto = [RTUtil isEmpty:[tempDic objectForKey:@"userheadportrait"]]?@"":[tempDic objectForKey:@"userheadportrait"];
                    trend.trendfavoritenumber = [tempDic objectForKey:@"like"];
                    trend.trendsharednumber = [tempDic objectForKey:@"download"];
                    trend.trendcommentnumber = [tempDic objectForKey:@"comments"];
                    trend.trendtype = [RTUtil isEmpty:[tempDic objectForKey:@"type"]]?@"":[tempDic objectForKey:@"type"];
                    trend.trendclassify = [RTUtil isEmpty:[tempDic objectForKey:@"label"]]?@"":[tempDic objectForKey:@"label"];
                    trend.isfavorite = [tempDic objectForKey:@"isfavorite"];
                    trend.trendid = [tempDic objectForKey:@"id"];
                    trend.usertype = [RTUtil isEmpty:[tempDic objectForKey:@"usertype"]]?@"":[tempDic objectForKey:@"usertype"];
                    trend.usersex = [RTUtil isEmpty:[tempDic objectForKey:@"sex"]]?@"":[tempDic objectForKey:@"sex"];
                    trend.userid = [tempDic objectForKey:@"userid"];
                    trend.useraddress = [RTUtil isEmpty:[tempDic objectForKey:@"address"]]?@"":[tempDic objectForKey:@"address"];
                    [array addObject:trend];
                }
                [userinfo.sportstrendsSet addObjectsFromArray:array];
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

+ (void)getLikeTrendsWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
}

+ (void)getMyTrendsListWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_GETMYTRENDSLIST];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            if ([[response objectForKey:@"state"] integerValue] == URL_NORMAL) {
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                NSMutableArray *array = [[NSMutableArray alloc] init];
                NSArray *tempArray = [response objectForKey:@"data"];
                for (NSDictionary *tempDic in tempArray) {
                    Trends *trend = [Trends MR_createEntity];
                    trend.trendcontent = [RTUtil isEmpty:[tempDic objectForKey:@"content"]]? @"":[tempDic objectForKey:@"content"];
                    trend.trendtime = [tempDic objectForKey:@"created_time"];
                    trend.usernickname = [RTUtil isEmpty:[tempDic objectForKey:@"nickname"]]?@"":[tempDic objectForKey:@"nickname"];
                    trend.trendphoto = [RTUtil isEmpty:[tempDic objectForKey:@"img"]]?@"":[tempDic objectForKey:@"img"];
                    trend.userphoto = [RTUtil isEmpty:[tempDic objectForKey:@"userheadportrait"]]?@"":[tempDic objectForKey:@"userheadportrait"];
                    trend.trendfavoritenumber = [tempDic objectForKey:@"like"];
                    trend.trendsharednumber = [tempDic objectForKey:@"download"];
                    trend.trendcommentnumber = [tempDic objectForKey:@"comments"];
                    trend.trendtype = [RTUtil isEmpty:[tempDic objectForKey:@"type"]]?@"":[tempDic objectForKey:@"type"];
                    trend.trendclassify = [RTUtil isEmpty:[tempDic objectForKey:@"label"]]?@"":[tempDic objectForKey:@"label"];
                    trend.isfavorite = [tempDic objectForKey:@"isfavorite"];
                    trend.trendid = [tempDic objectForKey:@"id"];
                    trend.usertype = [RTUtil isEmpty:[tempDic objectForKey:@"usertype"]]?@"":[tempDic objectForKey:@"usertype"];
                    trend.usersex = [RTUtil isEmpty:[tempDic objectForKey:@"sex"]]?@"":[tempDic objectForKey:@"sex"];
                    trend.userid = [tempDic objectForKey:@"userid"];
                    trend.useraddress = [RTUtil isEmpty:[tempDic objectForKey:@"address"]]?@"":[tempDic objectForKey:@"address"];
                    trend.ispublic = [tempDic objectForKey:@"flag"];
                    NSLog(@"trendUserID %@", trend.userid);
                    
                    [array addObject:trend];
                    
                    
                }
                //[user.alltrendsSet removeAllObjects];
                [user.usertrendsSet addObjectsFromArray:array];
                NSLog(@"%@", user.usertrendsSet);
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

+ (void)deleteMyTrendWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_DELETEMYTREND];
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

+ (void)getFriendsTrendsListWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_GETFRIENDSTRENDSLIST];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            if ([[response objectForKey:@"state"] integerValue] == URL_NORMAL) {
                RTUserInfo *userData = [RTUserInfo getInstance];
                UserInfo *user = userData.userData;
                NSMutableArray *array = [[NSMutableArray alloc] init];
                NSArray *tempArray = [response objectForKey:@"data"];
                for (NSDictionary *tempDic in tempArray) {
                    Trends *trend = [Trends MR_createEntity];
                    trend.trendcontent = [RTUtil isEmpty:[tempDic objectForKey:@"content"]]? @"":[tempDic objectForKey:@"content"];
                    trend.trendtime = [tempDic objectForKey:@"created_time"];
                    trend.usernickname = [RTUtil isEmpty:[tempDic objectForKey:@"nickname"]]?@"":[tempDic objectForKey:@"nickname"];
                    trend.trendphoto = [RTUtil isEmpty:[tempDic objectForKey:@"img"]]?@"":[tempDic objectForKey:@"img"];
                    trend.userphoto = [RTUtil isEmpty:[tempDic objectForKey:@"userheadportrait"]]?@"":[tempDic objectForKey:@"userheadportrait"];
                    trend.trendfavoritenumber = [tempDic objectForKey:@"like"];
                    trend.trendsharednumber = [tempDic objectForKey:@"download"];
                    trend.trendcommentnumber = [tempDic objectForKey:@"comments"];
                    trend.trendtype = [RTUtil isEmpty:[tempDic objectForKey:@"type"]]?@"":[tempDic objectForKey:@"type"];
                    trend.trendclassify = [RTUtil isEmpty:[tempDic objectForKey:@"label"]]?@"":[tempDic objectForKey:@"label"];
                    trend.isfavorite = [tempDic objectForKey:@"isfavorite"];
                    trend.trendid = [tempDic objectForKey:@"id"];
                    trend.usertype = [RTUtil isEmpty:[tempDic objectForKey:@"usertype"]]?@"":[tempDic objectForKey:@"usertype"];
                    trend.usersex = [RTUtil isEmpty:[tempDic objectForKey:@"sex"]]?@"":[tempDic objectForKey:@"sex"];
                    trend.userid = [tempDic objectForKey:@"userid"];
                    trend.useraddress = [RTUtil isEmpty:[tempDic objectForKey:@"address"]]?@"":[tempDic objectForKey:@"address"];
                    trend.ispublic = [tempDic objectForKey:@"flag"];
                    NSLog(@"trendUserID %@", trend.userid);
                    
                    [array addObject:trend];
                    
                    
                }
                //[user.alltrendsSet removeAllObjects];
                [user.friendtrendsSet addObjectsFromArray:array];
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

+ (void)trendLikeWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_LIKE];
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

+ (void)trendDislikeWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_DISLIKE];
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

+ (void)commentWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_COMMENT];
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

+ (void)deleteCommentWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_DELETECOMMENT];
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

+ (void)replyWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_REPLY];
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

+ (void)getCommentListWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_GETCOMMENTLIST];
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

+ (void)getLikeListWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_GETLIKELIST];
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
