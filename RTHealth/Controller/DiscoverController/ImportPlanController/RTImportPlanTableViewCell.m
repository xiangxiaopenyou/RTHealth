//
//  RTImportPlanTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/11/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTImportPlanTableViewCell.h"
#import "RTLevelView.h"
#import "RTImportNumber.h"
#import "RTPlanRequest.h"

@implementation RTImportPlanTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithData:(HealthPlan*)plan{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        healthPlan = plan;
        self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(8, (48-30)/2, 30, 30)];
        self.imageview.layer.cornerRadius = 10;
        self.imageview.layer.masksToBounds = YES;
        self.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"exercise%02d.png",[plan.plantype intValue]]];
        [self addSubview:self.imageview];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(56, 5, 183, 20)];
        self.titleLabel.font = VERDANA_FONT_12;
        self.titleLabel.attributedText = [self getAttributedString];
        [self addSubview:self.titleLabel];
        
        RTLevelView *levelView = [[RTLevelView alloc]initWithLevel:[plan.planlevel integerValue]];
        levelView.frame = CGRectMake(90, 30, 80, 13);
        [self addSubview:levelView];
        
        UILabel *labelMark = [[UILabel alloc]initWithFrame:CGRectMake(56, 25, 44, 22)];
        labelMark.font = VERDANA_FONT_11;
        labelMark.text = @"强度:";
        labelMark.backgroundColor = [UIColor clearColor];
        [self addSubview:labelMark];
        
        
        self.importnumber = [[RTImportNumber alloc]initWithImportNumber:[NSString stringWithFormat:@"%@",plan.plannumber]];
        self.importnumber.frame = CGRectMake(190, 30, 80, 13);
        [self addSubview:self.importnumber];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 25, 100, 20)];
        self.timeLabel.font = VERDANA_FONT_10;
        self.timeLabel.text = [RTUtil isEmpty:plan.plancreatetime]?@"":[CustomDate getDateStringToDete:plan.plancreatetime];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeLabel];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH - 54, (48-44)/2, 44, 44);
        [btn setBackgroundImage:[UIImage imageNamed:@"import.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(importClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if ([plan.planimported integerValue]==2) {
            [btn setUserInteractionEnabled:NO];
            [btn setBackgroundImage:[UIImage imageNamed:@"imported.png"] forState:UIControlStateNormal];
        }
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 47, SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
    }
    
    return self;
    
}

- (void)importClick:(UIButton*)btn
{
    healthPlan.planimported = @"2";
    [btn setUserInteractionEnabled:NO];
    [btn setBackgroundImage:[UIImage imageNamed:@"imported.png"] forState:UIControlStateNormal];
    
    NSLog(@"import");
    [RTPlanRequest importWithPlan:healthPlan success:^(id response){
        if ([[response objectForKey:@"state"] integerValue]==URL_NORMAL) {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"导入计划" message:@"导入计划成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [view show];
        }else{
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"导入计划" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [view show];
            
            healthPlan.planimported = @"1";
            [btn setUserInteractionEnabled:YES];
            [btn setBackgroundImage:[UIImage imageNamed:@"import.png"] forState:UIControlStateNormal];
        }
    }failure:^(NSError *error){
        
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"导入计划" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [view show];
        healthPlan.planimported = @"1";
        [btn setUserInteractionEnabled:YES];
        [btn setBackgroundImage:[UIImage imageNamed:@"import.png"] forState:UIControlStateNormal];
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSAttributedString*)getAttributedString{
    
    if ([healthPlan.planflag intValue] == 1) {
        
        NSRange range=[healthPlan.plantitle rangeOfString:healthPlan.plantitle];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:healthPlan.plantitle];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        return attriString;
    }else if ([healthPlan.planflag intValue] == 2) {
        
        NSString *string = [NSString stringWithFormat:@"%@(教练)",healthPlan.plantitle];
        NSRange range=[string rangeOfString:healthPlan.plantitle];
        NSRange range1=[string rangeOfString:@"(教练)"];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:190.0f/255.0 green:88.0f/255.0 blue:31.0f/255.0 alpha:1.0] range:range1];
        return attriString;
    }else if ([healthPlan.planflag intValue] == 3) {
        
        NSString *string = [NSString stringWithFormat:@"%@(达人)",healthPlan.plantitle];
        NSRange range=[string rangeOfString:healthPlan.plantitle];
        NSRange range1=[string rangeOfString:@"(达人)"];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:31.0f/255.0 green:162.0f/255.0 blue:19.0f/255.0 alpha:1.0] range:range1];
        return  attriString;
    }else if ([healthPlan.planflag intValue] == 4) {
        NSString *string = [NSString stringWithFormat:@"%@(系统)",healthPlan.plantitle];
        NSRange range=[string rangeOfString:healthPlan.plantitle];
        NSRange range1=[string rangeOfString:@"(系统)"];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:227.0f/255.0 green:69.0f/255.0 blue:133.0f/255.0 alpha:1.0] range:range1];
        return attriString;
    }else{
        NSRange range=[healthPlan.plantitle rangeOfString:healthPlan.plantitle];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:healthPlan.plantitle];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        return attriString;
    }
}
@end
