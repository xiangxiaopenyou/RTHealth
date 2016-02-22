//
//  RTActivityViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTActivityViewController : UIViewController<UIScrollViewDelegate, EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView_time;
    BOOL _reloading_time;
    BOOL _isloading_time;
    
    EGORefreshTableHeaderView *_refreshHeaderView_distance;
    BOOL _reloading_distance;
    BOOL _isloading_distance;
}

@property (nonatomic, strong) UITableView *tableView;

@end
