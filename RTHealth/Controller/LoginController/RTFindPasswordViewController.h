//
//  RTFindPasswordViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/21.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFindPasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *telephoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *identifyTextField;
@property (strong, nonatomic) IBOutlet UILabel *getIdentifyLabel;
- (IBAction)getIdentifyButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *getIdentifyButton;

@end
