//
//  RTActivityDetailViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/7.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTActivityDetailViewController : UIViewController

@property (nonatomic, strong) Activity *activity;
@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) NSString *idString;

@property (nonatomic, strong) NSMutableArray *joinMemberArray;

- (id)initWithActivityId:(NSString*)activityId;
@end
