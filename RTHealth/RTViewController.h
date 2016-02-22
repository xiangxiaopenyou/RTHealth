//
//  RTViewController.h
//  RTHealth
//
//  Created by cheng on 14/10/24.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLoadingViewController.h"

@interface RTViewController : UIViewController

@property (nonatomic,strong) RTLoadingViewController *loadingView;

- (void)amplificationWithImage:(UIImage*)image;

@end
