//
//  RTWeightRecordViewController.h
//  RTHealth
//
//  Created by cheng on 14/12/30.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTWeightRecordViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *weightLabel;
@property (nonatomic,strong) IBOutlet UILabel *markLabel;
@property (nonatomic,strong) IBOutlet UIPickerView *floatPick;
@property (nonatomic,strong) IBOutlet UIPickerView *intPick;
@property (nonatomic,strong) IBOutlet UILabel *bmiLabel;

- (IBAction)clickSure:(id)sender;
- (IBAction)clickCancel:(id)sender;
- (IBAction)clickBMI:(id)sender;

@end
