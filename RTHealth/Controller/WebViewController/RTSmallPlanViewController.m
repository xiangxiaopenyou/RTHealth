//
//  RTSmallPlanViewController.m
//  RTHealth
//
//  Created by cheng on 15/1/6.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTSmallPlanViewController.h"
#import "RTCountView.h"
#import "RTPersonalRequest.h"

@interface RTSmallPlanViewController ()<RTCountViewDelegate,LXActivityDelegate>{
    RTCountView *countview ;
    UserInfo *userInfo;UIButton *rightBtn;
    
}

@end

@implementation RTSmallPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RTUserInfo *userdata = [RTUserInfo getInstance];
    userInfo = userdata.userData;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = [RTUtil isEmpty:self.title]?@"计划详情":self.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    webView_.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 75, (44-26)/2+20, 65, 26);
    [rightBtn addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setHidden:YES];
    [self.view addSubview:rightBtn];
    if ([self.smallPlan.smallplanstateflag intValue] == 2) {
        //子计划的几个状态 1 完成 2 未完成 3 正在进行4 未进行 flag
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"forgotplan_web.png"] forState:UIControlStateNormal];
    }else if ([self.smallPlan.smallplanstateflag intValue]== 4){
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"watchmine_web.png"] forState:UIControlStateNormal];
    }else if ([self.smallPlan.smallplanstateflag intValue]== 1){
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"showplan_web.png"] forState:UIControlStateNormal];
    }
    
    long time;
    if (self.smallPlan == nil) {
        time = 0;
    }else{
        time = [CustomDate getTimeDistance:self.smallPlan.smallplanbegintime toTime:self.smallPlan.smallplanendtime]*60*1000;
    }
    
    
    countview = [[RTCountView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40) time:time];
    countview.userInteractionEnabled = NO;
    [countview setHidden:YES];
    countview.delegate = self;
    
    [self.view addSubview:countview];
    
    //判断按钮和标记完成等得状态
    HealthPlan *startPlan = userInfo.healthplan;
    if (startPlan == nil || self.plan == nil) {
        
    }else if ([startPlan.planid intValue] == [self.plan.planid intValue]) {
        [rightBtn setHidden:NO];
        
        NSInteger dateInterval = [CustomDate getDayToDate:startPlan.planbegindate];
        
        if ([RTUtil isEmpty:startPlan] || dateInterval >= [startPlan.plancycleday intValue]*[startPlan.plancyclenumber intValue]) {
        }else {
            NSInteger cycle = dateInterval/[startPlan.plancycleday integerValue]+1;
            NSInteger days = dateInterval%[startPlan.plancycleday integerValue]+1;
            if ([self.smallPlan.smallplansequence intValue] ==  days&& [self.smallPlan.smallplancycle intValue] == cycle) {
                //可以标记完成和计时
                [countview setUserInteractionEnabled:YES];
                [countview setHidden:NO];
                [countview setBackgroundColor:[UIColor colorWithRed:255/255.0 green:117/255.0 blue:90/255.0 alpha:1]];
                webView_.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 40 - 64);
                if ([self.smallPlan.smallplanstateflag intValue] != 1){
                    [rightBtn setBackgroundImage:[UIImage imageNamed:@"finishplan_web.png"] forState:UIControlStateNormal];
                    self.smallPlan.smallplanstateflag = @"3";
                }
                
            }else{
                
            }
        }
    }else{
    }
    
    [self refreshPage];
}

- (void)clickRight{
    if ([self.smallPlan.smallplanstateflag intValue] == 2) {
        [self sharedCilck];
        //子计划的几个状态 1 完成 2 未完成 3 正在进行4 未进行 flag
    }else if ([self.smallPlan.smallplanstateflag intValue]== 4){
        [self sharedCilck];
    }else if ([self.smallPlan.smallplanstateflag intValue]== 1){
        //分享
        [self sharedCilck];
    }else if ([self.smallPlan.smallplanstateflag intValue]== 3){
        //标记完成
        
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"showplan_web.png"] forState:UIControlStateNormal];
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        [dictionary setObject:userInfo.userid forKey:@"userid"];
        [dictionary setObject:userInfo.usertoken forKey:@"usertoken"];
        [dictionary setObject:self.smallPlan.smallplansequence forKey:@"sequence"];
        [dictionary setObject:self.smallPlan.smallplancycle forKey:@"cycleround"];
        [dictionary setObject:self.smallPlan.smallplanid forKey:@"planid"];
        
        [RTPersonalRequest finishedSmallPlan:dictionary success:^(id response){
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                self.smallPlan.smallplanstateflag = @"1";
                [self refreshPage];
            }else{
                //错误信息
            }
        }failure:^(NSError *error){
            
        }];
    }
}


- (void)sharedCilck{
    NSArray *shareButtonTitleArray = @[@"新浪微博",@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"];
    NSArray *shareButtonImageNameArray = @[@"sns_icon_1",@"sns_icon_22",@"sns_icon_23",@"sns_icon_24",@"sns_icon_40"];
    
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self.view];
    
}

#pragma mark - LXActivityDelegate

- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    NSLog(@"%d",(int)imageIndex);
    NSString *string;
    //子计划的几个状态 1 完成 2 未完成 3 正在进行4 未进行 flag
    if ([self.smallPlan.smallplanstateflag intValue] == 2) {
        string = @"这是我在健身坊的健身任务，可惜没完成，小伙伴们以后监督我吧";
    }else if ([self.smallPlan.smallplanstateflag intValue]== 4){
        string = @"这是我在健身坊的健身任务，求小伙伴们来监督";
    }else if ([self.smallPlan.smallplanstateflag intValue]== 1){
        //分享
        string = @"这是我在健身坊今日健身任务，拿来炫一炫";
    }
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSString *urlString = [NSString stringWithFormat:@"%@%@?userid=%@&id=%@&cycleRound=%@&cycleDay=%@&shared=%d",URL_BASE,URL_SMALLPLAN_SHARE,userinfo.userid,self.smallPlan.smallplanid,self.smallPlan.smallplancycle,self.smallPlan.smallplansequence,[self.smallPlan.smallplanstateflag intValue]];
    
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    switch ((int)imageIndex) {
        case 0:{
            [appDelegate sharedWeiboTimeLine:string Description:self.smallPlan.smallplanmark objectID:self.smallPlan.smallplanid url:urlString photo:UIImageJPEGRepresentation(([UIImage imageNamed:@"icon.png"]), 1.0)];
        }break;
        case 1:{
            [appDelegate sendLinkContent:string Description:self.smallPlan.smallplanmark Url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 2:{
            [appDelegate sendLinkContentTimeLine:string Description:self.smallPlan.smallplanmark Url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 3:{
            [appDelegate sharedQQFriendTitle:string description:self.smallPlan.smallplanmark url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 4:{
            [appDelegate sharedQZoneTitle:string description:self.smallPlan.smallplanmark url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        default:
            break;
    }
}

- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}


- (void)refreshPage{
    if ([RTUtil isEmpty: self.url]) {
        return;
    }
    [webView_ loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [countview stop];
}

#pragma mark - UIWebViewDelegate


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSLog(@" url %@",request.URL);
    }
    
    else if (navigationType == UIWebViewNavigationTypeBackForward) {
        NSLog(@"back forward");
        if (![webView_ canGoBack]) {
        }
    }return YES;
}

#pragma mark - countView Delegate

- (void)timerDidEnd{
    
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"showplan_web.png"] forState:UIControlStateNormal];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:userInfo.userid forKey:@"userid"];
    [dictionary setObject:userInfo.usertoken forKey:@"usertoken"];
    [dictionary setObject:self.smallPlan.smallplansequence forKey:@"sequence"];
    [dictionary setObject:self.smallPlan.smallplancycle forKey:@"cycleround"];
    [dictionary setObject:self.smallPlan.smallplanid forKey:@"planid"];
    
    [RTPersonalRequest finishedSmallPlan:dictionary success:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            //存储数据
            self.smallPlan.smallplanstateflag = @"1";
            [self refreshPage];
        }else{
            //错误信息
        }
    }failure:^(NSError *error){
        
    }];
}
@end
