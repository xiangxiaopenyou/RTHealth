//
//  RTFindPasswordStepTwoViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/21.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFindPasswordStepTwoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordEnsureTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@property (strong, nonatomic) NSString *telephoneNum;

- (IBAction)backButtonClick:(id)sender;
- (IBAction)submitButtonClick:(id)sender;

@end
