//
//  RTNetWork.m
//  RTHealth
//
//  Created by cheng on 14-10-17.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTNetWork.h"

@implementation RTNetWork

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params
        success:^(AFHTTPRequestOperation *operation,id responseObj){
            if (success) {
                if (operation.response.statusCode == 200) {
                    NSLog(@"正常");
                }
                success(responseObj);
            }
        }
         failure:^(AFHTTPRequestOperation *operation,NSError *error){
             if (failure) {
                 failure(error);
             }
         }
     ];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:params
          success:^(AFHTTPRequestOperation *operation,id responseObj){
              if (success) {
                  NSLog(@"%@",responseObj);
                  if (operation.response.statusCode == 200) {
                      NSLog(@"正常");
                  }
                  success(responseObj);
              }
          } failure:^(AFHTTPRequestOperation *operation,NSError *error){
              if (failure) {
                  NSLog(@"%@",operation.responseString);
                  NSLog(@"%@",error);
                  failure(error);
              }
          }
     ];
}

+ (void)postMulti:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        [formData appendPartWithHeaders:nil body:data];
        }
        success:^(AFHTTPRequestOperation *operation,id responseObj){
            if (success) {
                if (operation.response.statusCode == 200) {
                    NSLog(@"正常");
                }
            success(responseObj);
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        if (failure) {
            failure(error);
        }
    }
    ];

}

+ (void)postMulti:(NSString*)url params:(NSDictionary*)params imageparams:(UIImage*)imageparams success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (imageparams) {
            NSData *data = UIImagePNGRepresentation(imageparams);
            [formData appendPartWithFileData:data name:@"file" fileName:@"1.jpg" mimeType:@"image/jpeg"];
        }
    }
          success:^(AFHTTPRequestOperation *operation,NSDictionary*responseObj){
              if (success) {
                  NSLog(@"%@ %@",responseObj,operation.responseString);
                  success(responseObj);
              }
          } failure:^(AFHTTPRequestOperation *operation,NSError *error){
              if (failure) {
                  NSLog(@"error %@ %@",operation.response,operation.responseString);
                  
                  failure(error);
              }
          }
     ];
}

@end
