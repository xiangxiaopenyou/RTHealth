//
//  RTUserInfo.m
//  RTHealth
//
//  Created by cheng on 14/10/31.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTUserInfo.h"

static RTUserInfo *user;

@implementation RTUserInfo

- (id)init
{
    self = [super init];
    if (self) {
        self.favoriteNumber = [NSNumber numberWithInt:0];
        self.replyNumber = [NSNumber numberWithInt:0];
        self.systemNumber = [NSNumber numberWithInt:0];
        self.activityRemindNumber = [NSNumber numberWithInt:0];
        self.notReadChatNumber = [NSNumber numberWithInt:0];
        self.locationed = NO;
        self.longitude = 0.0;
        self.latitude = 0.0;
    }
    return self;
}


+ (RTUserInfo*)getInstance
{
    @synchronized([RTUserInfo class]){
        if (!user) {
            user = [[self alloc] init];
        }return user;
    }
    return nil;
}


@end
