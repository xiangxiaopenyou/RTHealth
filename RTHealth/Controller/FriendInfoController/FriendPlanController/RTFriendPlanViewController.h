//
//  RTFriendPlanViewController.h
//  RTHealth
//
//  Created by cheng on 14/12/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFriendPlanViewController : UIViewController<EGORefreshTableHeaderDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) FriendsInfo *friendInfo;

@end
