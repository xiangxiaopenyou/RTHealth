//
//  RTImportPlanViewController.h
//  RTHealth
//
//  Created by cheng on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTImportPlanViewController : UIViewController<UIScrollViewDelegate, EGORefreshTableHeaderDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableHeaderView *_refreshHeaderView_time;
    BOOL _reloading;
    BOOL _reloading_time;
    BOOL _isloading;
    BOOL _isloading_time;
}

@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) UIButton *button;

- (IBAction)clickSelect:(id)sender;

@end
