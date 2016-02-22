//
//  RTUserInfo.h
//  RTHealth
//
//  Created by cheng on 14/10/31.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface RTUserInfo : NSObject

@property (nonatomic,strong) UserInfo *userData;
@property (nonatomic,strong) NSString *deviceToken;
@property (nonatomic,strong) HealthPlan *newplan;
@property (nonatomic,strong) NSNumber *replyNumber;
@property (nonatomic,strong) NSNumber *favoriteNumber;
@property (nonatomic,strong) NSNumber *systemNumber;
@property (nonatomic,strong) NSNumber *activityRemindNumber;
@property (nonatomic,strong) NSNumber *notReadChatNumber;
@property (nonatomic,assign) BOOL locationed;
@property (nonatomic,assign) float latitude;
@property (nonatomic,assign) float longitude;

+ (RTUserInfo*)getInstance;

@end
