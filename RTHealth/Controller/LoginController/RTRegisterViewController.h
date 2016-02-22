//
//  RTRegisterViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/10/23.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTRegisterViewController : UIViewController
{
    NSString *identify;
}

@property (strong, nonatomic) IBOutlet UITextField *telephoneText;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordText;
@property (strong, nonatomic) IBOutlet UITextField *telephoneIdentifyText;
@property (strong, nonatomic) IBOutlet UIButton *getIdentifyButton;
@property (strong, nonatomic) IBOutlet UILabel *getIdentifyLabel;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)getIdentityButtonAction:(id)sender;
- (IBAction)registerClick:(id)sender;

@end
