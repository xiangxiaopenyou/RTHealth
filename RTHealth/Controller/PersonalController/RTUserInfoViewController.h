//
//  RTUserInfoViewController.h
//  RTHealth
//
//  Created by cheng on 14/10/23.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTUserInfoViewController : RTViewController{
    UITableView *tableview;
    
    
}

@property (nonatomic,strong) UIActivityIndicatorView *activity;
@property (nonatomic,strong) UserInfo *userinfo;
@end
