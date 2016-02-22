//
//  RTPlanPopView.m
//  RTHealth
//
//  Created by cheng on 15/1/7.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTPlanPopView.h"

@implementation RTPlanPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        array = [NSArray arrayWithObjects:@"导入计划",@"制定者",@"分享", nil];
        arrayImage = [NSArray arrayWithObjects:@"importplan.png",@"createplanuser.png",@"sharedplan_image.png", nil];
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.bounces = NO;
        tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:tableView];
    }
    return  self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    cell.imageView.image = [UIImage imageNamed:[arrayImage objectAtIndex:indexPath.row]];
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate clickPlanPopItemAtIndex:indexPath.row];
}


@end
