//
//  RTImportSelectView.h
//  RTHealth
//
//  Created by cheng on 14/11/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTImportSelectViewDelegate <NSObject>

@optional

- (void)clickItemAtIndex:(NSInteger)index;

@end

@interface RTImportSelectView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
    NSArray *array;
}

@property (nonatomic,assign) id<RTImportSelectViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)data;

@end
