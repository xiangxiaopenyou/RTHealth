//
//  RTPlanEmptyTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPlanEmptyTableViewCell.h"

@implementation RTPlanEmptyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *labelDays = [[UILabel alloc]initWithFrame:CGRectMake(17, 0, SCREEN_WIDTH-17-65, 78-20)];
        labelDays.textAlignment = NSTextAlignmentLeft;
        labelDays.text = @"你还没有任何进行中的计划哦，赶紧在\"我的计划\"开始一个计划吧！~";
        labelDays.font = VERDANA_FONT_12;
        labelDays.numberOfLines = 0;
        labelDays.backgroundColor = [UIColor clearColor];
        [self addSubview:labelDays];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(320-53, ((78-20)-33)/2, 43, 33)];
        imageview.image = [UIImage imageNamed:@"noplanimport"];
        [self addSubview:imageview];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 78-20, SCREEN_WIDTH, 20)];
        view.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
        [self addSubview:view];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 20)];
        label.text = @"系统推荐任务";
        label.textColor = [UIColor whiteColor];
        label.font = VERDANA_FONT_10;
        [view addSubview:label];
        
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 58-1, SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
        
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line1.backgroundColor = LINE_COLOR;
        [self addSubview:line1];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
