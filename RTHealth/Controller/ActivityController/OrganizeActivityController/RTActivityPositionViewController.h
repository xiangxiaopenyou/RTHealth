//
//  RTActivityPositionViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/12/17.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RTActivityPositionDelegate<NSObject>
@optional

- (void)clickChooseButton;
@end

@interface RTActivityPositionViewController : UIViewController

@property (nonatomic, strong) NSString *addressString;
@property (nonatomic, assign) float positionX;
@property (nonatomic, assign) float positionY;

@property (nonatomic, strong) id<RTActivityPositionDelegate>delegate;

@end
