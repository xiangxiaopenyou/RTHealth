//
//  RTFinishPlanTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/10/31.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFinishPlanTableViewCell.h"
#import "RTLevelView.h"

@implementation RTFinishPlanTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(HealthPlan *)plan
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        healthPlan = plan;
        self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(8, 15, 40, 40)];
        self.imageview.layer.cornerRadius = 20;
        self.imageview.layer.masksToBounds = YES;
        self.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"exercise%02d.png",[healthPlan.plantype intValue]]];
        [self addSubview:self.imageview];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(56, 10, 183, 21)];
        self.titleLabel.font = VERDANA_FONT_16;
        self.titleLabel.text = plan.plantitle;
        [self addSubview:self.titleLabel];
        
        RTLevelView *levelView = [[RTLevelView alloc]initWithLevel:[plan.planlevel integerValue]];
        levelView.frame = CGRectMake(100, 43, 80, 13);
        [self addSubview:levelView];
        
        UILabel *labelMark = [[UILabel alloc]initWithFrame:CGRectMake(56, 39, 44, 22)];
        labelMark.font = VERDANA_FONT_14;
        labelMark.text = @"强度:";
        labelMark.backgroundColor = [UIColor clearColor];
        [self addSubview:labelMark];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, (70-20)/2, 110, 20)];
        timeLabel.font = VERDANA_FONT_12;
        timeLabel.text = [CustomDate getBirthDayString:plan.planbegindate];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:timeLabel];
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
