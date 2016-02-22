//
//  RTSmallPlanTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTSmallPlanTableViewCell.h"

#define TEXTCOLOR [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]

@implementation RTSmallPlanTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(SmallHealthPlan*)smallPlanData
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        NSString *markString = [NSString stringWithFormat:@"备注:%@",smallPlanData.smallplanmark];
        
        framesize = [markString sizeWithFont:VERDANA_FONT_12
                           constrainedToSize:CGSizeMake(180.0, MAXFLOAT)
                               lineBreakMode:NSLineBreakByCharWrapping];
        
        NSLog(@"size %lf %lf",framesize.height,framesize.width);
        
        labelOfMark = [[UILabel alloc]initWithFrame:CGRectMake(65, 5, 180, framesize.height)];
        labelOfMark.text = markString;
        labelOfMark.numberOfLines = 0;
        labelOfMark.font = VERDANA_FONT_12;
        labelOfMark.textColor = TEXTCOLOR;
        [self addSubview:labelOfMark];
        
        timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 5+framesize.height, 100, 25)];
        timeLabel.text = [NSString stringWithFormat:@"开始时间:%@",smallPlanData.smallplanbegintime];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = VERDANA_FONT_12;
        timeLabel.textColor = TEXTCOLOR;
        [self addSubview:timeLabel];
        
        costLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 5+framesize.height, 130, 25)];
        costLabel.text = smallPlanData.smallplancost;
        costLabel.font = VERDANA_FONT_12;
        costLabel.textColor = TEXTCOLOR;
        costLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:costLabel];
        
        typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, ([self getheight]-30)/2, 30, 30)];
        typeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%02d.png",[smallPlanData.smallplantype intValue]]];
        typeImageView.layer.masksToBounds = YES;
        typeImageView.layer.cornerRadius = 30/2;
        [self addSubview:typeImageView];
        
        UIImageView *stateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-13, ([self getheight]-51)/2, 13, 51)];
        [self addSubview:stateImageView];
        switch ([smallPlanData.smallplanstateflag intValue]) {
            case 1:{
                stateImageView.image = [UIImage imageNamed:@"smallplanstate01.png"];
            }break;
            case 2:{
                stateImageView.image = [UIImage imageNamed:@"smallplanstate02.png"];
            }break;
            case 3:{
                stateImageView.image = [UIImage imageNamed:@"smallplanstate03.png"];
            }break;
            case 4:{
                stateImageView.image = [UIImage imageNamed:@"smallplanstate04.png"];
            }break;
            default:
                break;
        }
    }
    return self;
}
- (float)getheight
{
    return (17.5+framesize.height/2)*2;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
