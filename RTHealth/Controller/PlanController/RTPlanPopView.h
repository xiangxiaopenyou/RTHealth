//
//  RTPlanPopView.h
//  RTHealth
//
//  Created by cheng on 15/1/7.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTPlanPopViewDelegate <NSObject>

- (void)clickPlanPopItemAtIndex:(NSInteger)index;

@end

@interface RTPlanPopView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
    NSArray *array;
    NSArray *arrayImage;
}

@property (nonatomic,assign) id<RTPlanPopViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame;

@end
