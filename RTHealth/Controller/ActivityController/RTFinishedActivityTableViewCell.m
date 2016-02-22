//
//  RTFinishedActivityTableViewCell.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFinishedActivityTableViewCell.h"

@implementation RTFinishedActivityTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(Activity *)activity
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        healthActivity = activity;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 180, 22)];
        self.titleLabel.font = SMALLFONT_12;
        self.titleLabel.text = activity.activitytitle;
        self.titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.titleLabel];
        
        self.finishedTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 5, 98, 22)];
        self.finishedTimeLabel.font = SMALLFONT_10;
        NSString *finishDateString = [activity.activityendtime substringWithRange:NSMakeRange(0, 10)];
        finishDateString = [finishDateString stringByAppendingString:@"结束"];
        self.finishedTimeLabel.text = finishDateString;
        self.finishedTimeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        self.finishedTimeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.finishedTimeLabel];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 31.5, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.3];
        [self addSubview:line];
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
