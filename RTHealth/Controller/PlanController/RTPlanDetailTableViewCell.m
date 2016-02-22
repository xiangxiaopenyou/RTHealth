//
//  RTPlanDetailTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPlanDetailTableViewCell.h"
#import "RTLevelView.h"
#import "RTImportNumber.h"

@implementation RTPlanDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(HealthPlan*)plan{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        healthPlan = plan;
        NSInteger index;
        NSInteger total = [plan.plancycleday intValue]*[plan.plancyclenumber intValue];
        if ([RTUtil isEmpty:plan.planbegindate]) {
            index = 0;
        }else{
            if ([CustomDate getDayToDate:plan.planbegindate]<total) {
                index = [CustomDate getDayToDate:plan.planbegindate]+1;
            }else{
                index = 0;
            }
        }
        
        UILabel *progressLabelBackground = [[UILabel alloc]initWithFrame:CGRectMake(15, 65, 290, 15)];
        progressLabelBackground.backgroundColor = [UIColor lightGrayColor];
        progressLabelBackground.layer.masksToBounds = YES;
        progressLabelBackground.layer.cornerRadius = 7;
        [self addSubview:progressLabelBackground];
        
        self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 40, 40)];
        self.imageview.layer.cornerRadius = 20;
        self.imageview.layer.masksToBounds = YES;
        self.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"exercise%02d.png",[healthPlan.plantype intValue]]];
        [self addSubview:self.imageview];
        
        
        self.progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 65, 290, 15)];
        self.progressLabel.font = VERDANA_FONT_10;
        self.progressLabel.textColor = [UIColor whiteColor];
        self.progressLabel.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"progress.png"];
        self.progressImageView = [[UIImageView alloc]init];
        self.progressImageView.frame = CGRectMake(15, 65, self.progressLabel.frame.size.width*index/total, 15);
        self.progressImageView.image = [image stretchableImageWithLeftCapWidth:8 topCapHeight:0];
        self.progressImageView.layer.masksToBounds = YES;
        self.progressImageView.layer.cornerRadius = 7;
        [self addSubview:self.progressImageView];
        self.progressLabel.text = [NSString stringWithFormat:@"%d/%d",index,total];
        self.progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.progressLabel];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 10, 150, 21)];
        self.titleLabel.font = VERDANA_FONT_16;
        self.titleLabel.text = plan.plantitle;
        [self addSubview:self.titleLabel];
        
        RTLevelView *levelView = [[RTLevelView alloc]initWithLevel:[plan.planlevel integerValue]];
        levelView.frame = CGRectMake(110, 43, 80, 13);
        [self addSubview:levelView];
        
        UILabel *labelMark = [[UILabel alloc]initWithFrame:CGRectMake(65, 39, 44, 22)];
        labelMark.font = VERDANA_FONT_14;
        labelMark.text = @"强度:";
        labelMark.backgroundColor = [UIColor clearColor];
        [self addSubview:labelMark];
        
        RTImportNumber *importnumber = [[RTImportNumber alloc]initWithImportNumber:[NSString stringWithFormat:@"%@",plan.plannumber]];
        importnumber.frame = CGRectMake(250, 17, 40, 13);
        [self addSubview:importnumber];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 1)];
        lineLabel.backgroundColor = LINE_COLOR;
        [self addSubview:lineLabel];
        
        NSString *intrduce = [NSString stringWithFormat:@"计划介绍:%@",healthPlan.plancontent];
        framesize = [intrduce sizeWithFont:VERDANA_FONT_12
                         constrainedToSize:CGSizeMake(290.0, MAXFLOAT)
                             lineBreakMode:NSLineBreakByCharWrapping];
        UILabel *intrduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 100, SCREEN_WIDTH-20, framesize.height)];
        intrduceLabel.text = intrduce;
        intrduceLabel.font = VERDANA_FONT_12;
        intrduceLabel.numberOfLines = 0;
        [self addSubview:intrduceLabel];
        
        
        UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 110+framesize.height-1, SCREEN_WIDTH, 1)];
        lineLabel1.backgroundColor = LINE_COLOR;
        [self addSubview:lineLabel1];
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
