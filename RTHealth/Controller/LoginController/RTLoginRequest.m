//
//  RTLoginRequest.m
//  RTHealth
//
//  Created by cheng on 14-10-17.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTLoginRequest.h"
#import "RTNetWork.h"
#import "URLConstant.h"

@implementation RTLoginRequest

+ (void)loginWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_LOGIN];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            
            @try {
            
                
                if ([[response objectForKey:@"state"] intValue] == URL_NORMAL) {
                    NSDictionary *tempDictionary = [response objectForKey:@"data"];
                    
                    NSString *userid = [NSString stringWithFormat:@"%@",[tempDictionary objectForKey:@"userid"]];
                    NSString *usertoken = [NSString stringWithFormat:@"%@",[tempDictionary objectForKey:@"usertoken"]];
                    NSString *isNewUser = [RTUtil isEmpty:[tempDictionary objectForKey:@"isNewUser"]]?@"0":[tempDictionary objectForKey:@"isNewUser"];
                    
                    NSArray *array = [UserInfo MR_findByAttribute:@"userid" withValue:userid];
                    UserInfo *user;
                    if ([RTUtil isEmpty:array]||array.count == 0) {
                        
                        user = [UserInfo MR_createEntity];
                    }else{
                        user = [array objectAtIndex:0];
                    }
                    user.isnewuser = isNewUser;
                    user.userid = userid;
                    user.usertoken = usertoken;
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userid"];
                    [[NSUserDefaults standardUserDefaults]setObject:userid forKey:@"userid"];
                    
                    //存储数据
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
+ (void)registerWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_REGISTER];
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //解析返回的数据
            //返回controller，然后在UI线程上进行更新
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}

+(void)getidentifyWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_GETIDENTIFY];
    NSLog(@"%@",url);
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

+(void)verifyWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_VERIFY];
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

+ (void)upPasswordWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE, URL_FINDPASSWORD];
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

+ (void)changePasswordWith:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_CHANGEPASSWORD];
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

+ (void)registerThirdWith:(NSDictionary*)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE, URL_THIRDLOGIN];
    [RTNetWork post:url params:parameter success:^(id response) {
        if (success) {
            if ([[response objectForKey:@"state"] intValue] == URL_NORMAL) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userid"];
                NSDictionary *tempDictionary = [response objectForKey:@"data"];
                NSString *userid = [NSString stringWithFormat:@"%@",[tempDictionary objectForKey:@"userid"]];
                NSString *usertoken = [NSString stringWithFormat:@"%@",[tempDictionary objectForKey:@"usertoken"]];
                NSString *isNewUser = [tempDictionary objectForKey:@"isNewUser"];
                NSArray *array = [UserInfo MR_findByAttribute:@"userid" withValue:userid];
                UserInfo *user;
                if (array.count > 0) {
                    user = [array objectAtIndex:0];
                    
                }else{
                    user = [UserInfo MR_createEntity];
                }
                
                user.userid = userid;
                user.usertoken = usertoken;
                user.isnewuser = isNewUser;
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userid"];
                [[NSUserDefaults standardUserDefaults]setObject:userid forKey:@"userid"];
                
                NSLog(@"userid %@",userid);
                //存储数据
            }
            success(response);
        }else{
            //错误信息
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
