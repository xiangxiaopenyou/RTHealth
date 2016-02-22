//
//  RTOwnPlanTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/10/31.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTOwnPlanTableViewCell.h"
#import "RTLevelView.h"
#import "RTImportNumber.h"
#import "RTPlanRequest.h"

@implementation RTOwnPlanTableViewCell

@synthesize healthPlan = healthPlan;

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
        
//        RTImportNumber *importnumber = [[RTImportNumber alloc]initWithImportNumber:plan.plannumber];
        RTImportNumber *importnumber = [[RTImportNumber alloc]initWithImportNumber:[NSString stringWithFormat:@"%@",plan.plannumber]];
        importnumber.frame = CGRectMake(190, 43, 80, 13);
        [self addSubview:importnumber];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH - 54, (70-44)/2, 44, 44);
        [btn setBackgroundImage:[UIImage imageNamed:@"startplan.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
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

- (void)startClick:(UIButton *)btn
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"开始计划" message:@"停止计划后，进度将被重置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:{
            [RTPlanRequest startWithPlan:healthPlan success:^(id response){
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                
                RTUserInfo *userdata = [RTUserInfo getInstance];
                UserInfo *userInfo = userdata.userData;
                [userInfo.canstartplanSet removeObject:healthPlan];
                [self.delegate shouldReload];
            }else{
            }
            [JDStatusBarNotification dismiss];
        }failure:^(NSError *error){
        }];
            
        }break;
            
        default:
            break;
    }
    

}
@end
