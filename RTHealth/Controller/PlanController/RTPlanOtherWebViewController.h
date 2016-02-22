//
//  RTPlanOtherWebViewController.h
//  RTHealth
//
//  Created by cheng on 15/1/7.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTWebModelViewController.h"

@interface RTPlanOtherWebViewController : RTWebModelViewController{
    UserInfo *userinfo;
    NSInteger type;
}

@property (nonatomic,strong) HealthPlan *plan;
@property (nonatomic,strong) FriendsInfo *friendInfo;
- (id)initWith:(HealthPlan*)healthPlan;


@end
