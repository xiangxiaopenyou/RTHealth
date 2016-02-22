//
//  RTImportSelectView.m
//  RTHealth
//
//  Created by cheng on 14/11/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTImportSelectView.h"

@interface RTImportSelectView ()<UITableViewDataSource,UITableViewDelegate>
{
    
}
@end

@implementation RTImportSelectView

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)data
{
    self = [super initWithFrame:frame];
    if (self) {
        array = [NSArray arrayWithArray:data];
        self.backgroundColor = [UIColor colorWithRed:251.0f/255.0 green:251.0f/255.0 blue:251.0f/255.0 alpha:1.0];;
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        if (frame.size.height >390) {
            tableView.bounces = NO;
        }else{
            tableView.bounces = YES;
        }
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
    }
    return  self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"Cell"];
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];

    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 43, self.frame.size.width, 1)];
    line.backgroundColor = LINE_COLOR;
    [cell.contentView addSubview:line];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click");
    [self.delegate clickItemAtIndex:indexPath.row];
}

@end
