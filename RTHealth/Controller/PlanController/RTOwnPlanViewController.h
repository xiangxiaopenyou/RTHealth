//
//  RTOwnPlanViewController.h
//  RTHealth
//
//  Created by cheng on 14/10/30.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTOwnPlanViewController : RTViewController<EGORefreshTableHeaderDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic,strong) UITableView *tableview;

@end
