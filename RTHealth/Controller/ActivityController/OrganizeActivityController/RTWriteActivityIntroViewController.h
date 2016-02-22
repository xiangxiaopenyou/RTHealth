//
//  RTWriteActivityIntroViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/12/5.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTWriteActivityIntroViewDelegate <NSObject>
@optional

- (void)clickFinishButton;

@end

@interface RTWriteActivityIntroViewController : UIViewController

@property (nonatomic, strong) UITextView *introTextView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) id<RTWriteActivityIntroViewDelegate> delegate;
@property (nonatomic, strong) NSString *introString;
//@property (nonatomic, strong) NSString

@end
