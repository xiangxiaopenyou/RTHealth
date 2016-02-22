//
//  RTChoosePositionViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/12/16.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RTChoosePositionDelegate<NSObject>
@optional
- (void)clickDeleteAddress;
- (void)clickSubmit;
- (void)clickTableViewCell;
@end

@interface RTChoosePositionViewController : UIViewController

@property (nonatomic, strong) UITextField *addressTextField;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UITableView *addressTableView;
@property (nonatomic, strong) UIButton *deleteAddressButton;

@property (nonatomic, strong) id<RTChoosePositionDelegate> delegate;
@property (nonatomic, strong) NSString *addressString;

@end
