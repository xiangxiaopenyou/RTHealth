//
//  RTPopOverView.h
//  RTHealth
//
//  Created by cheng on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTPopOverViewDelegate <NSObject>

- (void)clickItemAtIndex:(NSInteger)index;

@end

@interface RTPopOverView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
    NSArray *array;
    NSArray *arrayImage;
}

@property (nonatomic,assign) id<RTPopOverViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame withType:(NSInteger)index;


@end
