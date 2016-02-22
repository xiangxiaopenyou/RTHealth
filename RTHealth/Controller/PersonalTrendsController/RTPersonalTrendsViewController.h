//
//  RTPersonalTrendsViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/12/19.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTPersonalTrendsViewController : UIViewController<EGORefreshTableHeaderDelegate, UIScrollViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    BOOL _isloading;
}

@property (nonatomic, strong)NSString *personalId;

- (id)initWithPersonalId:(NSString*)idString;

@end
