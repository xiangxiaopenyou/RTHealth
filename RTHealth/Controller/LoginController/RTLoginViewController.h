//
//  RTLoginViewController.h
//  RTHealth
//
//  Created by cheng on 14-10-22.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLoginViewController : RTViewController

@property (nonatomic,strong) IBOutlet UITextField *usernameField;
@property (nonatomic,strong) IBOutlet UITextField *passwordField;
@property (nonatomic, assign) BOOL isFirstLaunched;


- (IBAction)loginClick:(id)sender;

- (IBAction)loginWithWeiChat:(id)sender;
- (IBAction)loginWithWeibo:(id)sender;
- (IBAction)loginWithqq:(id)sender;

- (IBAction)TurnToRegister:(id)sender;
- (IBAction)turnToFindPassword:(id)sender;

@end
