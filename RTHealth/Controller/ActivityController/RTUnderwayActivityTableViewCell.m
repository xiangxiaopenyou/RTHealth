//
//  RTUnderwayActivityTableViewCell.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTUnderwayActivityTableViewCell.h"

@implementation RTUnderwayActivityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(Activity *)activity
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        healthActivity = activity;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 200, 15)];
        self.titleLabel.font = SMALLFONT_12;
        self.titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        self.titleLabel.text = activity.activitytitle;
        [self addSubview:self.titleLabel];
        
        CGSize contentSie = [activity.activitycontent sizeWithFont:SMALLFONT_10 constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 37, 200, contentSie.height)];
        self.contentLabel.font = SMALLFONT_10;
        self.contentLabel.text = activity.activitycontent;
        self.contentLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.contentLabel.numberOfLines = 0;
        [self addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 12, 88, 15)];
        self.timeLabel.font = SMALLFONT_12;
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = activity.activitybegintime;
        NSString *timeString;
        NSDate *date = [CustomDate getTimeToDate:dateString];
        //NSLog(@"date %@", date);
        if ([[CustomDate compareDate:date] isEqualToString:@"今天"]) {
            timeString = @"今天进行";
        }
        else if([[CustomDate compareDate:date] isEqualToString:@"明天"]){
            timeString = @"明天开始";
        }
        else if ([[CustomDate compareDate:date] isEqualToString:@"后天"]){
            timeString = @"后天开始";
        }
        else{
            NSString *string = [[CustomDate getDateString:date] substringWithRange:NSMakeRange(5, 5)];
            timeString = [string stringByAppendingString:@"开始"];
        }
        self.timeLabel.text = timeString;
        self.timeLabel.textColor = [UIColor colorWithRed:83/255.0 green:161/255.0 blue:49/255.0 alpha:1.0];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeLabel];
        
        self.numberCount = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 37, 88, 15)];
        self.numberCount.font = SMALLFONT_12;
        self.numberCount.text = [NSString stringWithFormat:@"参与人数:%@",activity.activitynumber];
        self.numberCount.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        self.numberCount.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.numberCount];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 37 + contentSie.height + 9.5, self.frame.size.width, 0.5)];
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
