//
//  RTMoreRequest.m
//  RTHealth
//
//  Created by cheng on 14/12/30.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTMoreRequest.h"

@implementation RTMoreRequest

+ (void)upWeightWith:(NSDictionary *)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_PERSONAL_UPWEIGHT];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:params success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
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
