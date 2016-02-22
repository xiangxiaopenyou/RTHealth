//
//  RTRecommendedPlanTableViewCell.m
//  RTHealth
//
//  Created by 项小盆友 on 15/1/7.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTRecommendedPlanTableViewCell.h"
#import "RTLevelView.h"
#import "RTPlanRequest.h"

@implementation RTRecommendedPlanTableViewCell
@synthesize button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDic:(NSDictionary *)dictionary
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.planDic = dictionary;
        self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        self.imageview.layer.cornerRadius = 15;
        self.imageview.layer.masksToBounds = YES;
        self.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"exercise%@.png",[dictionary objectForKey:@"type"]]];
        [self addSubview:self.imageview];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 180, 15)];
        self.titleLabel.font = SMALLFONT_10;
        self.titleLabel.attributedText = [self getAttributedString];
        [self addSubview:self.titleLabel];
        
        if (![RTUtil isEmpty:[dictionary objectForKey:@"level"] ]) {
            RTLevelView *levelView = [[RTLevelView alloc]initWithLevel:[[dictionary objectForKey:@"level"] integerValue]];
            levelView.frame = CGRectMake(80, 20, 80, 15);
            [self addSubview:levelView];
        }
        else{
            RTLevelView *levelView = [[RTLevelView alloc]initWithLevel:0];
            levelView.frame = CGRectMake(80, 20, 80, 15);
            [self addSubview:levelView];
        }
        
        UILabel *labelMark = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, 30, 15)];
        labelMark.font = SMALLFONT_10;
        labelMark.text = @"强度:";
        labelMark.backgroundColor = [UIColor clearColor];
        [self addSubview:labelMark];
        
        isImport = NO;
        //导入按钮
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(238, 6, 27, 27);
        [button setImage:[UIImage imageNamed:@"not_secret.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(inputPlanClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //分割线
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.7, self.frame.size.width, 0.3)];
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
    }
    return self;
}

- (void)inputPlanClick{
    
    if (!isImport) {
        healthPlan = [HealthPlan MR_createEntity];
        healthPlan.planid = [self.planDic objectForKey:@"id"];
        healthPlan.plancontent = [RTUtil isEmpty:[self.planDic objectForKey:@"content"]]?@"":[self.planDic objectForKey:@"content"];
        healthPlan.plancreatetime = [self.planDic objectForKey:@"created_time"];
        healthPlan.plancycleday =  [NSNumber numberWithInt:[[self.planDic objectForKey:@"cycleDay"] intValue]];
        healthPlan.plancyclenumber = [NSNumber numberWithInt:[[self.planDic objectForKey:@"cycleRound"] intValue]];
        healthPlan.planflag = [RTUtil isEmpty:[self.planDic objectForKey:@"flag"]]?@"0":[self.planDic objectForKey:@"flag"];
        healthPlan.planid = [self.planDic objectForKey:@"id"];
        healthPlan.planlevel = [NSString stringWithFormat:@"%@",[self.planDic objectForKey:@"level"]];
        healthPlan.plannumber = [NSNumber numberWithInt:[[self.planDic objectForKey:@"recommend_num"] intValue]];
        healthPlan.planpublic = [self.planDic objectForKey:@"planpublic"];
        healthPlan.plantitle = [self.planDic objectForKey:@"title"];
        healthPlan.plantype = [self.planDic objectForKey:@"type"];
        [button setImage:[UIImage imageNamed:@"is_secret.png"] forState:UIControlStateNormal];
        healthPlan.planimported = @"2";
        isImport = YES;
        [RTPlanRequest importWithPlan:healthPlan success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue]==URL_NORMAL) {
                
            }
            else{
                healthPlan.planimported = @"1";
                isImport = NO;
            }
        } failure:^(NSError *error) {
            healthPlan.planimported = @"1";
            isImport = NO;
        }];
        
    }
    else{
        [button setImage:[UIImage imageNamed:@"not_secret.png"] forState:UIControlStateNormal];
        isImport = NO;
        healthPlan.planimported = @"1";
        [RTPlanRequest deleteWithPlan:healthPlan success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue]==URL_NORMAL) {
                
            }else{
                
                healthPlan.planimported = @"2";
                isImport = YES;
            }

        } failure:^(NSError *error) {
            healthPlan.planimported = @"2";
            isImport = YES;
        }];
    }
}

- (NSAttributedString*)getAttributedString{
    
    if ([[self.planDic objectForKey:@"flag"]intValue] == 1) {
        
        NSRange range=[[self.planDic objectForKey:@"title"] rangeOfString:[self.planDic objectForKey:@"title"]];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:[self.planDic objectForKey:@"title"]];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        return attriString;
    }else if ([[self.planDic objectForKey:@"flag"] intValue] == 2) {
        
        NSString *string = [NSString stringWithFormat:@"%@(教练)",[self.planDic objectForKey:@"title"]];
        NSRange range=[string rangeOfString:[self.planDic objectForKey:@"title"]];
        NSRange range1=[string rangeOfString:@"(教练)"];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:190.0f/255.0 green:88.0f/255.0 blue:31.0f/255.0 alpha:1.0] range:range1];
        return attriString;
    }else if ([[self.planDic objectForKey:@"flag"] intValue] == 3) {
        
        NSString *string = [NSString stringWithFormat:@"%@(达人)",[self.planDic objectForKey:@"title"]];
        NSRange range=[string rangeOfString:[self.planDic objectForKey:@"title"]];
        NSRange range1=[string rangeOfString:@"(达人)"];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:31.0f/255.0 green:162.0f/255.0 blue:19.0f/255.0 alpha:1.0] range:range1];
        return  attriString;
    }else if ([[self.planDic objectForKey:@"flag"] intValue] == 4) {
        NSString *string = [NSString stringWithFormat:@"%@(系统)",[self.planDic objectForKey:@"title"]];
        NSRange range=[string rangeOfString:[self.planDic objectForKey:@"title"]];
        NSRange range1=[string rangeOfString:@"(系统)"];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:227.0f/255.0 green:69.0f/255.0 blue:133.0f/255.0 alpha:1.0] range:range1];
        return attriString;
    }else{
        NSRange range=[[self.planDic objectForKey:@"title"] rangeOfString:[self.planDic objectForKey:@"title"]];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:[self.planDic objectForKey:@"title"]];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        return attriString;
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
