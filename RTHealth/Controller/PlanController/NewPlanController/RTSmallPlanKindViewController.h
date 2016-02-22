//
//  RTSmallPlanKindViewController.h
//  RTHealth
//
//  Created by cheng on 14/12/8.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnStringBlock)(NSString *kindString);

@interface RTSmallPlanKindViewController : UIViewController

@property (nonatomic, copy) ReturnStringBlock returnTextBlock;

-(void)returnString:(ReturnStringBlock)block;

@end
