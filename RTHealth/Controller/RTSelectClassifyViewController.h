//
//  RTSelectClassifyViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/12/26.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RTSelectClassifyDelegate<NSObject>
@optional
- (void)clickClassify:(NSString*)classify;
@end

@interface RTSelectClassifyViewController : UIViewController

@property (nonatomic, strong) NSString *classifyString;
@property (nonatomic, strong) NSString *selectedString;

@property (nonatomic, strong)id<RTSelectClassifyDelegate>delegate;

@end
