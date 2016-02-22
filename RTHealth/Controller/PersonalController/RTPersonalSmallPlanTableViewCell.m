//
//  RTPersonalSmallPlanTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPersonalSmallPlanTableViewCell.h"
#import "VBFPopFlatButton.h"
#import "UIColor+FlatColors.h"
#import "RTPersonalRequest.h"

#define TEXTCOLOR [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]

@implementation RTPersonalSmallPlanTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(SmallHealthPlan*)smallPlandata{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        smallPlanData = smallPlandata;
        NSArray *sportsname = sports;
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
        NSString *markString = [NSString stringWithFormat:@"备注:%@",smallPlanData.smallplanmark];
        framesize = [markString sizeWithFont:VERDANA_FONT_12
                           constrainedToSize:CGSizeMake(180.0, MAXFLOAT)
                               lineBreakMode:NSLineBreakByCharWrapping];
        
        NSLog(@"size %lf %lf",framesize.height,framesize.width);
        
        
        
        contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 180, 23)];
        contentLabel.text = [NSString stringWithFormat:@"%@: %ld分钟",[sportsname objectAtIndex:[smallPlanData.smallplantype intValue]],(long)[CustomDate getTimeDistance:smallPlanData.smallplanbegintime toTime:smallPlanData.smallplanendtime]];
        contentLabel.font = VERDANA_FONT_12;
        contentLabel.textColor = [UIColor blackColor];
        [self addSubview:contentLabel];
        
        costLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 23, 180, 18)];
        costLabel.text = [NSString stringWithFormat:@"消耗:%@",smallPlanData.smallplancost];
        if ([smallPlandata.smallplantype intValue] == 02) {
            costLabel.text = [NSString stringWithFormat:@"摄入:%@",smallPlanData.smallplancost];
        }
        costLabel.font = VERDANA_FONT_12;
        costLabel.textColor = TEXTCOLOR;
        [self addSubview:costLabel];
        
        typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (50-33)/2, 33, 33)];
        typeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%02d.png",[smallPlanData.smallplantype intValue]]];
        typeImageView.layer.masksToBounds = YES;
        typeImageView.layer.cornerRadius = 33/2;
        [self addSubview:typeImageView];
        
        timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-55), 10/2, 55 , 20)];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.text = smallPlanData.smallplanbegintime;
        timeLabel.font = VERDANA_FONT_10;
        timeLabel.textColor = [UIColor colorWithRed:251/255.0 green:24/255.0 blue:40/255.0 alpha:1.0];//TEXTCOLOR;
        [self addSubview:timeLabel];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50-1, SCREEN_WIDTH-20, 1)];
        lineLabel.backgroundColor = LINE_COLOR;
        [self addSubview:lineLabel];
        
        labelOfMark = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 250, framesize.height+10)];
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
            finishLabel.backgroundColor = [UIColor colorWithRed:63/255.0 green:136/255.0 blue:63/255.0 alpha:1.0];
        }else{
            finishLabel.text = @"未完成";
        }
        [self addSubview:finishLabel];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, [self getheight]-1, SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_COLOR;
        
        modifyButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-15-20, 25, 20, 20)
                                                   buttonType:buttonMenuType
                                                  buttonStyle:buttonRoundedStyle];
        modifyButton.roundBackgroundColor = [UIColor whiteColor];
        modifyButton.lineThickness = 2;
        modifyButton.linesColor = [UIColor flatPeterRiverColor];
        [modifyButton addTarget:self action:@selector(modifyClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:modifyButton];
        
        [self addSubview:line];
    }
    return self;
}
- (float)getheight
{
    return 50+framesize.height+10;
}


- (void)modifyClick{
    
    if (modifyButton.currentButtonType == buttonMenuType) {
        
        [modifyButton animateToType:buttonCloseType];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
        [bgView setBackgroundColor:[UIColor colorWithRed:0.3
                                                   green:0.3
                                                    blue:0.3
                                                   alpha:0.7]];
        if ([smallPlanData.smallplanstateflag intValue] == 1) {
            
            for (int i = 0 ; i < 3; i ++ ) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(35 + i * ( 48 + 5 ), ([self getheight]-48)/2, 48, 48);
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"planstate%02d.png",i+1]] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = i+1;
                [btn setUserInteractionEnabled:NO];
                [bgView addSubview:btn];
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(35 + 3 * ( 48 + 5 ), ([self getheight]-48)/2, 48, 48);
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"planstatebtn04.png"]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 4;
            [bgView addSubview:btn];
            
        }else{
            for (int i = 0 ; i < 3; i ++ ) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(35 + i * ( 48 + 5 ), ([self getheight]-48)/2, 48, 48);
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"planstatebtn%02d.png",i+1]] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = i+1;
                [bgView addSubview:btn];
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(35 + 3 * ( 48 + 5 ), ([self getheight]-48)/2, 48, 48);
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"planstate04.png"]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 4;
            [btn setUserInteractionEnabled:NO];
            [bgView addSubview:btn];
        }
        
        background = bgView;
        [self insertSubview:bgView belowSubview:modifyButton];
        [self shakeToShow:bgView];//放大过程中的动画
        
    }else{
        [modifyButton animateToType:buttonMenuType];
        [background removeFromSuperview];
    }
}

- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (void)stateClick:(UIButton*)btn{
    NSInteger flag = btn.tag;
    switch (flag) {
        case 1:{
            RTUserInfo *userData = [RTUserInfo getInstance];
            UserInfo *userinfo = userData.userData;
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
            [dictionary setObject:userinfo.userid forKey:@"userid"];
            [dictionary setObject:userinfo.usertoken forKey:@"usertoken"];
            [dictionary setObject:smallPlanData.smallplansequence forKey:@"sequence"];
            [dictionary setObject:smallPlanData.smallplancycle forKey:@"cycleround"];
            [dictionary setObject:smallPlanData.smallplanid forKey:@"planid"];
            
            [RTPersonalRequest finishedSmallPlan:dictionary success:^(id response){
                if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                    //存储数据
                    smallPlanData.smallplanstateflag = @"1";
                    [self setNeedsDisplay];
                }else{
                    //错误信息
                }
            }failure:^(NSError *error){
                
            }];
        }break;
        case 2:{
            clickIndex = 4;
            [self sharedCilck];
            
        }break;
        case 3:{
            clickIndex = 3;
            [self sharedCilck];
        }break;
        case 4:{
            clickIndex = 1;
            [self sharedCilck];
        }break;
            
        default:
            break;
    }
}

- (void)drawRect:(CGRect)rect{
    [modifyButton animateToType:buttonMenuType];
    [background removeFromSuperview];
    
    if ([smallPlanData.smallplanstateflag intValue] == 1) {
        finishLabel.text = @"已完成";
        finishLabel.backgroundColor = [UIColor colorWithRed:63/255.0 green:136/255.0 blue:63/255.0 alpha:1.0];
    }else{
        finishLabel.text = @"未完成";
        finishLabel.backgroundColor = [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1.0];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)sharedCilck{
    NSArray *shareButtonTitleArray = @[@"新浪微博",@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"];
    NSArray *shareButtonImageNameArray = @[@"sns_icon_1",@"sns_icon_22",@"sns_icon_23",@"sns_icon_24",@"sns_icon_40"];
    
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self.superview];
    
}

#pragma mark - LXActivityDelegate

- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    NSLog(@"%d",(int)imageIndex);
    NSString *string;
    
    //子计划的几个状态 1 完成 2 未完成 3 正在进行4 未进行 flag
    if (clickIndex == 3) {
        string = @"这是我在健身坊今日健身任务，求组队一起练";
    }else if (clickIndex == 4){
        string = @"这是我在健身坊的健身任务，求小伙伴们来监督";
    }else if (clickIndex == 1){
        //分享
        string = @"这是我在健身坊今日健身任务，拿来炫一炫";
    }
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSString *urlString = [NSString stringWithFormat:@"%@%@?userid=%@&id=%@&cycleRound=%@&cycleDay=%@&shared=%d",URL_BASE,URL_SMALLPLAN_SHARE,userinfo.userid,smallPlanData.smallplanid,smallPlanData.smallplancycle,smallPlanData.smallplansequence,clickIndex];
    
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    switch ((int)imageIndex) {
        case 0:{
            [appDelegate sharedWeiboTimeLine:string Photo:[UIImage imageNamed:@"icon.png"]];
        }break;
        case 1:{
            [appDelegate sendLinkContent:string Description:smallPlanData.smallplanmark Url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 2:{
            [appDelegate sendLinkContentTimeLine:string Description:smallPlanData.smallplanmark Url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 3:{
            [appDelegate sharedQQFriendTitle:string description:smallPlanData.smallplanmark url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 4:{
            [appDelegate sharedQZoneTitle:string description:smallPlanData.smallplanmark url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        default:
            break;
    }
}

- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}


@end
