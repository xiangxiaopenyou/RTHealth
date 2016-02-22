//
//  RTFriendProgressTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFriendProgressTableViewCell.h"

#define LabelBackgroundColor [UIColor colorWithRed:239/255.0 green:237/255.0 blue:231/255.0 alpha:1.0]

@implementation RTFriendProgressTableViewCell

@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(FriendsInfo*)friendInfo{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        HealthPlan *healthplan = friendInfo.healthplan;
        NSInteger index = [CustomDate getDayToDate:healthplan.planbegindate]+1;
        NSInteger total = [healthplan.plancycleday integerValue]*[healthplan.plancyclenumber integerValue];
        
        self.backgroundColor = LabelBackgroundColor;
        
        UILabel *backgroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 20)];
        backgroundLabel.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0];
        [self addSubview:backgroundLabel];
        
        UIImage *image = [UIImage imageNamed:@"progress.png"];
        progressImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*index/total, 20)];
        progressImage.image = [image stretchableImageWithLeftCapWidth:8 topCapHeight:0];
        [self addSubview:progressImage];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 90, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = SMALLFONT_12;
        titleLabel.text = healthplan.plantitle;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
        
        progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 0, 50, 20)];
        progressLabel.backgroundColor = [UIColor clearColor];
        progressLabel.textColor = [UIColor whiteColor];
        progressLabel.font = SMALLFONT_12;
        progressLabel.text = [NSString stringWithFormat:@"%d/%d",index,total];
        progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:progressLabel];
        
        labelDays = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH, 58-20)];
        labelDays.text = [NSString stringWithFormat:@"今日任务(第%d天):",index];
        labelDays.textAlignment = NSTextAlignmentLeft;
        labelDays.font = VERDANA_FONT_12;
        labelDays.backgroundColor = [UIColor clearColor];
        [self addSubview:labelDays];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 58-1, SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_COLOR;
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
