//
//  RTWirteIntrduceViewController.h
//  RTHealth
//
//  Created by cheng on 14/10/30.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnTextBlock)(NSString *showText);

@interface RTWirteIntrduceViewController : UIViewController

@property (nonatomic,strong) NSString *content;

@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

-(void)returnText:(ReturnTextBlock)block;

@end
