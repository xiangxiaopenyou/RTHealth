//
//  RTStartPlanTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/10/31.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTStartPlanTableViewCell.h"
#import "RTLevelView.h"

@implementation RTStartPlanTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(HealthPlan *)plan
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    
        
        healthPlan = plan;
        NSInteger index = [CustomDate getDayToDate:healthPlan.planbegindate]+1;
        NSInteger total = [healthPlan.plancycleday integerValue]*[healthPlan.plancyclenumber integerValue];
        
        UILabel *progressLabelBackground = [[UILabel alloc]initWithFrame:CGRectMake(8, 65, 304, 15)];
        progressLabelBackground.backgroundColor = [UIColor lightGrayColor];
        progressLabelBackground.layer.masksToBounds = YES;
        progressLabelBackground.layer.cornerRadius = 7;
        [self addSubview:progressLabelBackground];
        
        self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(8, 15, 40, 40)];
        self.imageview.layer.cornerRadius = 20;
        self.imageview.layer.masksToBounds = YES;
        self.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"exercise%02d.png",[healthPlan.plantype intValue]]];
        [self addSubview:self.imageview];
        
        
        self.progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 65, 304, 15)];
        self.progressLabel.font = VERDANA_FONT_10;
        self.progressLabel.textColor = [UIColor whiteColor];
        self.progressLabel.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"progress.png"];
        self.progressImageView = [[UIImageView alloc]init];
        self.progressImageView.frame = CGRectMake(8, 65, self.progressLabel.frame.size.width*index/total, 15);
        self.progressImageView.image = [image stretchableImageWithLeftCapWidth:8 topCapHeight:0];
        self.progressImageView.layer.masksToBounds = YES;
        self.progressImageView.layer.cornerRadius = 7;
        [self addSubview:self.progressImageView];
        self.progressLabel.text = [NSString stringWithFormat:@"%d/%d",index,total];
        self.progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.progressLabel];
        
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
