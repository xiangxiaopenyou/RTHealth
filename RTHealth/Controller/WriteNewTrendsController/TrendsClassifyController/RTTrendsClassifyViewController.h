//
//  RTTrendsClassifyViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/25.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTTrendsClassifyViewControllerDelegate <NSObject>
@optional

- (void)clickCancelOrSubmitButton:(NSString *)editString;
- (void)clickClassify:(NSString*)classify;

@end

@interface RTTrendsClassifyViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *trendsTextfield;
@property (strong, nonatomic) IBOutlet UIButton *CancelOrSubmitButton;

@property (strong, nonatomic) NSString *trendsClassifyString;
@property (strong, nonatomic) NSMutableArray *classifyMutableArray;

@property (strong, nonatomic) id <RTTrendsClassifyViewControllerDelegate>delegate;

- (IBAction)CancelOrSubmitButtonClick:(id)sender;

@end
