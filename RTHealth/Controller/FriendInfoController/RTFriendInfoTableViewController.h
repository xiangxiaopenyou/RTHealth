//
//  RTFriendInfoTableViewController.h
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFriendInfoTableViewController : RTViewController

@property (nonatomic,strong) FriendsInfo *friendInfo;
@property (nonatomic,strong) NSString *friendid;

- (id)initWithFriendid:(NSString*)idString;

@end
