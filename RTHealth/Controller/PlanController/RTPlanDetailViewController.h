//
//  RTPlanDetailViewController.h
//  RTHealth
//
//  Created by cheng on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface RTPlanDetailViewController : UIViewController{
//    UserInfo *userinfo;
//    UITableView *tableview;
//    NSInteger type;
//}
//
//@property (nonatomic,strong) HealthPlan *plan;
//
//
//- (id)initWith:(HealthPlan*)healthPlan Type:(NSInteger)index;
//
//@end
#import "RTWebModelViewController.h"

@interface RTPlanDetailViewController : RTWebModelViewController{
    UserInfo *userinfo;
    NSInteger type;
}

@property (nonatomic,strong) HealthPlan *plan;

- (id)initWith:(HealthPlan*)healthPlan Type:(NSInteger)index;

@end