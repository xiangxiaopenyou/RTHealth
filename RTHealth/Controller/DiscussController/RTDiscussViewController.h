//
//  RTDiscussViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/11.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RTCommentViewDelegate<NSObject>
@optional
- (void)commentSuccess;
@end

@interface RTDiscussViewController : UIViewController

@property (nonatomic, strong) NSString *ownerString;
@property (nonatomic, strong) NSString *discussString;
@property (nonatomic, strong) NSString *trendID;
//@property (nonatomic, strong) NSString *trendUserID;

@property (nonatomic, strong) id<RTCommentViewDelegate>delegate;

@end
