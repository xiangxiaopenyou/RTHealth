//
//  RTFriendSmallPlanTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFriendSmallPlanTableViewCell.h"

#define TEXTCOLOR [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]

@implementation RTFriendSmallPlanTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(SmallHealthPlan *)smallPlanData{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
        NSString *markString = [NSString stringWithFormat:@"备注:%@",smallPlanData.smallplanmark];
        
        framesize = [markString sizeWithFont:VERDANA_FONT_12
                           constrainedToSize:CGSizeMake(180.0, MAXFLOAT)
                               lineBreakMode:NSLineBreakByCharWrapping];
        
        NSLog(@"size %lf %lf",framesize.height,framesize.width);
        
        contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 180, 23)];
        contentLabel.text = [NSString stringWithFormat:@"%@: %ld分钟",[sports objectAtIndex:[smallPlanData.smallplantype intValue]],(long)[CustomDate getTimeDistance:smallPlanData.smallplanbegintime toTime:smallPlanData.smallplanendtime]];
        contentLabel.font = VERDANA_FONT_12;
        contentLabel.textColor = TEXTCOLOR;
        [self addSubview:contentLabel];
        
        costLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 23, 180, 23)];
        costLabel.text = [NSString stringWithFormat:@"消耗:%@",smallPlanData.smallplancost];
        costLabel.font = VERDANA_FONT_12;
        costLabel.textColor = TEXTCOLOR;
        [self addSubview:costLabel];
        
        typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (50-33)/2, 33, 33)];
        typeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%02d.png",[smallPlanData.smallplantype intValue]]];
        typeImageView.layer.masksToBounds = YES;
        typeImageView.layer.cornerRadius = 30/2;
        [self addSubview:typeImageView];
        
        timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 55), 30/2, 55, 20)];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.text = smallPlanData.smallplanbegintime;
        timeLabel.font = VERDANA_FONT_10;
        timeLabel.textColor = TEXTCOLOR;
        [self addSubview:timeLabel];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 1)];
        lineLabel.backgroundColor = LINE_COLOR;
        [self addSubview:lineLabel];
        
        labelOfMark = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 2500, framesize.height+10)];
        labelOfMark.text = markString;
        labelOfMark.numberOfLines = 0;
        labelOfMark.font = VERDANA_FONT_12;
        labelOfMark.textColor = TEXTCOLOR;
        [self addSubview:labelOfMark];
        
        finishLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-42, 55, 35, 14)];
        finishLabel.textColor = [UIColor whiteColor];
        finishLabel.font = VERDANA_FONT_10;
        finishLabel.textAlignment = NSTextAlignmentCenter;
        finishLabel.backgroundColor = [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1.0];
        if ([smallPlanData.smallplanstateflag intValue] == 1) {
            finishLabel.text = @"已完成";
        }else{
            finishLabel.text = @"未完成";
        }
        [self addSubview:finishLabel];
    }
    return self;
}

- (float)getheight
{
    return (30+framesize.height/2)*2;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
