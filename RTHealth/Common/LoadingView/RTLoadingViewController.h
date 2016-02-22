//
//  RTLoadingViewController.h
//  RTHealth
//
//  Created by cheng on 15/1/16.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLoadingViewController : UIViewController{
    UIImageView *imageView;
}

@property (nonatomic,strong) UILabel *label;

- (void)show;
- (void)hide;

@end
