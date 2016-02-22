//
//  RTPlanKindViewController.h
//  RTHealth
//
//  Created by cheng on 14/12/8.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnArrayBlock)(NSString *kindString);

@interface RTPlanKindViewController : UIViewController

@property (nonatomic, copy) ReturnArrayBlock returnTextBlock;

-(void)returnArray:(ReturnArrayBlock)block;

@end
