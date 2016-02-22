//
//  RTPopOverView.m
//  RTHealth
//
//  Created by cheng on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPopOverView.h"

@implementation RTPopOverView

- (id)initWithFrame:(CGRect)frame withType:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        switch (index) {
            case 0:
                array = [NSArray arrayWithObjects:@"停止计划",@"删除计划",@"制定者",@"分享", nil];
                arrayImage = [NSArray arrayWithObjects:@"stopplan.png",@"deleteplan.png",@"createplanuser.png",@"sharedplan_image.png", nil];
                break;
            case 1:
                array = [NSArray arrayWithObjects:@"开始计划",@"删除计划",@"制定者",@"分享", nil];
                arrayImage = [NSArray arrayWithObjects:@"startplandetail.png",@"deleteplan.png",@"createplanuser.png",@"sharedplan_image.png", nil];
                break;
            case 2:
                array = [NSArray arrayWithObjects:@"开始计划",@"导入计划",@"制定者",@"分享", nil];
                arrayImage = [NSArray arrayWithObjects:@"startplandetail.png",@"importplan.png",@"createplanuser.png",@"sharedplan_image.png", nil];
                break;
            default:
                break;
        }
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.bounces = NO;
        tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:tableView];
    }
    return  self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    [self.delegate clickItemAtIndex:indexPath.row];
}

@end
