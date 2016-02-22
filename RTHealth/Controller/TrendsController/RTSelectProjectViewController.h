//
//  RTSelectProjectViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTSelectProjectViewControllerDelegate <NSObject>
@optional

- (void)clickProjectView;

@end

@interface RTSelectProjectViewController : UIViewController

@property (nonatomic, strong) NSString *projectSelectedString;

@property (nonatomic, strong) id<RTSelectProjectViewControllerDelegate> delegate;

@end
