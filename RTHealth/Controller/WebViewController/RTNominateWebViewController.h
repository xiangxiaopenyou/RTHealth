//
//  RTNominateWebViewController.h
//  RTHealth
//
//  Created by cheng on 15/1/6.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTWebModelViewController.h"

@interface RTNominateWebViewController : RTWebModelViewController

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *photo;

@end
