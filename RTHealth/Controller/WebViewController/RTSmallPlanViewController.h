//
//  RTSmallPlanViewController.h
//  RTHealth
//
//  Created by cheng on 15/1/6.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTWebModelViewController.h"

@interface RTSmallPlanViewController : RTWebModelViewController

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) SmallHealthPlan *smallPlan;
@property (nonatomic,strong) HealthPlan *plan;

@end
