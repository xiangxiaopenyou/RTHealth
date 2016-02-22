//
//  RTChatViewController.h
//  RTHealth
//
//  Created by cheng on 14/11/12.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "JSMessagesViewController.h"

@interface RTChatViewController : JSMessagesViewController

@property (nonatomic,strong) NSString *friendID;
@property (nonatomic,strong) FriendsInfo *friendInfo;

@end
