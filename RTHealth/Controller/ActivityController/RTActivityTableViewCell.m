//
//  RTActivityTableViewCell.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTActivityTableViewCell.h"

@implementation RTActivityTableViewCell


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
        
        CGSize contentSize = [activity.activitycontent sizeWithFont:SMALLFONT_10 constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 37, 200, contentSize.height)];
        self.contentLabel.font = SMALLFONT_10;
        self.contentLabel.text = activity.activitycontent;
        self.contentLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.contentLabel.numberOfLines = 0;
        [self addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 12, 88, 15)];
        self.timeLabel.font = SMALLFONT_12;
        NSTimeInterval secondsPerDay = 24*60*60;
        NSDate *today = [[NSDate alloc] init];
        NSDate *tomorrow = [today dateByAddingTimeInterval:secondsPerDay];
        NSDate *twoDaysLate = [today dateByAddingTimeInterval:2*secondsPerDay];
        NSDate *threeDaysLate = [today dateByAddingTimeInterval:3*secondsPerDay];
        NSString *todayString = [[today description] substringToIndex:10];
        NSString *tomorrowString = [[tomorrow description] substringToIndex:10];
        NSString *twoDaysLateString = [[twoDaysLate description] substringToIndex:10];
        NSString *threeDaysLateString = [[threeDaysLate description] substringToIndex:10];
        NSString *timeString = [[activity.activitybegintime description] substringToIndex:10];
        
        NSString *timeLabelString;
        
        if ([timeString isEqualToString:todayString]) {
            timeLabelString = @"今天";
        }
        else if ([timeString isEqualToString:tomorrowString]){
            timeLabelString = @"明天";
        }
        else if ([timeString isEqualToString:twoDaysLateString]){
            timeLabelString = @"后天";
        }
        else if ([timeString isEqualToString:threeDaysLateString]){
            timeLabelString = @"三天后";
        }
        else{
            
            timeLabelString = [activity.activitybegintime substringWithRange:NSMakeRange(5, 5)];
        }
        timeLabelString = [timeLabelString stringByAppendingString:@"开始"];
        self.timeLabel.text = timeLabelString;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeLabel];
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 37, 88, 15)];
        self.distanceLabel.font = SMALLFONT_12;
        self.distanceLabel.textAlignment = NSTextAlignmentRight;
        NSString *distanceString = @"距离:";
        //distanceString = [distanceString stringByAppendingString:activity.activitydistance];
        float distanceF = [activity.activitydistance floatValue];
        if (distanceF <= 0.9) {
            distanceF *= 1000;
            NSString *distanceM = [NSString stringWithFormat:@"%.f", distanceF];
            distanceString = [NSString stringWithFormat:@"%@%@米",distanceString, distanceM];
        }
        else{
            NSString *distanceKM = [NSString stringWithFormat:@"%.1f", distanceF];
            distanceString = [NSString stringWithFormat:@"%@%@公里", distanceString, distanceKM];
        }
        //distanceString = [distanceString stringByAppendingString:activity.activitydistance];
        self.distanceLabel.text = distanceString;
        [self addSubview:self.distanceLabel];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 37+contentSize.height + 9.5 , self.frame.size.width, 0.5)];
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
