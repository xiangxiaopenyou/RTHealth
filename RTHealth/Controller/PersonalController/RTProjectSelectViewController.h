//
//  RTProjectSelectViewController.h
//  RTHealth
//
//  Created by cheng on 14/11/24.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnArrayBlock)(NSMutableArray *array);

@interface RTProjectSelectViewController : UIViewController

@property (nonatomic,strong) NSMutableArray *selectarray;

@property (nonatomic, copy) ReturnArrayBlock returnTextBlock;

-(void)returnArray:(ReturnArrayBlock)block;
@end
