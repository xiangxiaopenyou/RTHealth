//
//  RTOwnActivityViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTOwnActivityViewController : UIViewController<EGORefreshTableHeaderDelegate, UIScrollViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic, strong) UITableView *activityTableView;
@property (nonatomic, strong) NSString *personalId;

- (id)initWithId:(NSString*)idString;

@end
