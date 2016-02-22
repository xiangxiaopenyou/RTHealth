//
//  RTFriendOtherInfoTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFriendOtherInfoTableViewCell.h"

#define TEXTCOLOR [UIColor colorWithRed:68.0/255.0 green:64.0/255.0 blue:64.0/255.0 alpha:1.0]
#define TEXTCOLOR_LIGHT [UIColor colorWithRed:127/255.0 green:127.0/255.0 blue:127/255.0 alpha:1.0]

@implementation RTFriendOtherInfoTableViewCell

@synthesize fansLabel,activityLabel,attentionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(FriendsInfo *)InfoData{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        friendInfo = InfoData;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(myPlanClick) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, 45.0);
        [self addSubview:btn];
        
        UILabel *myplanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 45.0)];
        myplanLabel.backgroundColor = [UIColor clearColor];
        myplanLabel.textAlignment = NSTextAlignmentCenter;
        myplanLabel.text = @"TA的计划";
        myplanLabel.font = VERDANA_FONT_12;
        myplanLabel.textColor = TEXTCOLOR;
        [self addSubview:myplanLabel];
        
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 addTarget:self action:@selector(myTrendClick) forControlEvents:UIControlEventTouchUpInside];
        btn1.frame = CGRectMake( SCREEN_WIDTH/3,0, SCREEN_WIDTH/3, 45.0);
        [self addSubview:btn1];
        
        UILabel *myTrendLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3,0 , SCREEN_WIDTH/3, 45.0)];
        myTrendLabel.backgroundColor = [UIColor clearColor];
        myTrendLabel.textAlignment = NSTextAlignmentCenter;
        myTrendLabel.text = @"TA的动态";
        myTrendLabel.font = VERDANA_FONT_12;
        myTrendLabel.textColor = TEXTCOLOR;
        [self addSubview:myTrendLabel];
        
        
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn4 addTarget:self action:@selector(myActivityClick) forControlEvents:UIControlEventTouchUpInside];
        btn4.frame = CGRectMake( 2*SCREEN_WIDTH/3,0, SCREEN_WIDTH/3, 45.0);
        [self addSubview:btn4];
        
        UILabel *myactivityLabel = [[UILabel alloc]initWithFrame:CGRectMake( 2*SCREEN_WIDTH/3,0, SCREEN_WIDTH/3, 45.0)];
        myactivityLabel.backgroundColor = [UIColor clearColor];
        myactivityLabel.textAlignment = NSTextAlignmentCenter;
        myactivityLabel.text = @"TA的活动";
        myactivityLabel.font = [UIFont systemFontOfSize:12.0];
        myactivityLabel.textColor = TEXTCOLOR;
        [self addSubview:myactivityLabel];
        
        
        UILabel *labelline = [[UILabel alloc]init];
        labelline.backgroundColor = LINE_COLOR;
        labelline.frame = CGRectMake(SCREEN_WIDTH/3, 5, 1, 45.0-10);
        [self addSubview:labelline];
        UILabel *labelline1 = [[UILabel alloc]init];
        labelline1.backgroundColor = LINE_COLOR;
        labelline1.frame = CGRectMake(2*SCREEN_WIDTH/3, 5, 1, 45.0-10);
        [self addSubview:labelline1];
        
        RTUserInfo *userdata = [RTUserInfo getInstance];
        UserInfo *userinfo = userdata.userData;
        if ([friendInfo.friendid intValue] == [userinfo.userid intValue]) {
            myplanLabel.text = @"我的计划";
            myTrendLabel.text = @"我的动态";
            myactivityLabel.text = @"我的活动";
        }
        UILabel *labelline2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45-1, SCREEN_WIDTH, 1)];
        labelline2.backgroundColor = LINE_COLOR;
        [self addSubview:labelline2];
    }
    
    return self;
}
- (void)myPlanClick
{
    NSLog(@"点击我的计划");
    [self.delegate clickfriendPlan];
}
- (void)myTrendClick
{
    NSLog(@"点击我的动态");
    [self.delegate clickfriendTrend];
}

- (void)myActivityClick
{
    NSLog(@"点击我的活动");
    [self.delegate clickfriendActivity];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
