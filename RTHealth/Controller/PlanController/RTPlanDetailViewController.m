//
//  RTPlanDetailViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPlanDetailViewController.h"
#import "PopoverView.h"
#import "RTPopOverView.h"
#import "RTPlanDetailTableViewCell.h"
#import "RTSmallPlanTableViewCell.h"
#import "RTSmallPlanViewController.h"
#import "RTOtherSmallPlanViewController.h"
#import "RTPlanRequest.h"

@interface RTPlanDetailViewController ()<PopoverViewDelegate,RTPopOverViewDelegate,LXActivityDelegate>{
    PopoverView *settingPlanView;
}

@end

@implementation RTPlanDetailViewController

@synthesize plan = plan;


- (id)initWith:(HealthPlan*)healthPlan Type:(NSInteger)index{
    self = [super init];
    if (self) {
        plan = healthPlan;
        type = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"计划概要";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    UIButton *btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMessage.frame = CGRectMake(SCREEN_WIDTH - 67, (NAVIGATIONBAR_HEIGHT - 44) +6 , 57, 32);
    [btnMessage addTarget:self action:@selector(settingCilck) forControlEvents:UIControlEventTouchUpInside];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"settingplan.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnMessage];
    
    [RTPlanRequest detailWithPlan:plan success:^(id response){
        if ([[response objectForKey:@"state"] integerValue] == URL_NORMAL) {
            switch ([plan.planstate integerValue] )  {
                case 1:{//正在进行
                    type = 0;
                }break;
                case 2:{//导入未开始
                    type = 1;
                }break;
                case 3:{//完成
                    type = 2;
                }break;
                case 4:{//未导入
                    type = 2;
                }break;
                    
                default:
                    break;
            }
        }else{
            
        }
    }failure:^(NSError *error){
        
    }];
    
    [self refreshPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)settingCilck
{
    CGPoint point = CGPointMake(SCREEN_WIDTH - 22.5, NAVIGATIONBAR_HEIGHT);
    RTPopOverView *popoverView = [[RTPopOverView alloc]initWithFrame:CGRectMake(0, 0, 150,180) withType:type];
    popoverView.delegate = self;
    
    settingPlanView = [[PopoverView alloc]init];
    settingPlanView.delegate = self;
    [settingPlanView showAtPoint:point inView:self.view withContentView:popoverView];
}

#pragma mark - PopoverViewDelegate Methods

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    
    [popoverView showImage:[UIImage imageNamed:@"success"] withMessage:@"123"];
    //Dismiss the PopoverView after 0.5 seconds
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - RTPopOverViewDelegate

- (void)clickItemAtIndex:(NSInteger)index
{
    switch (type) {
        case 0:{
            if (index == 0) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"停止计划" message:@"停止计划后，进度将被重置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 10;
                [alertView show];
            }else if (index ==1){
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"删除开始计划" message:@"删除已进行计划后，数据将不会被保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 11;
                [alertView show];
            }else if (index == 2){
                if (![RTUtil isEmpty: plan.plancreateuserid]) {
                    RTFriendInfoTableViewController *friendInfo = [[RTFriendInfoTableViewController alloc]initWithFriendid:plan.plancreateuserid];
                    [self.navigationController pushViewController:friendInfo animated:YES];
                }
            }else if (index == 3){
                //分享
                [self sharedCilck];
            }
        }break;
        case 1:{
            if (index == 0) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"开始计划" message:@"开始计划将覆盖已经开始的计划" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 12;
                [alertView show];
            }else if (index ==1){
                [RTPlanRequest deleteWithPlan:plan success:^(id response){
                    if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    type = 2;
                }failure:^(NSError *error){
                }];
            }else if (index == 2){
                
                if (![RTUtil isEmpty: plan.plancreateuserid]) {
                    RTFriendInfoTableViewController *friendInfo = [[RTFriendInfoTableViewController alloc]initWithFriendid:plan.plancreateuserid];
                    [self.navigationController pushViewController:friendInfo animated:YES];
                }
            }else if (index == 3){
                [self sharedCilck];
            }
        }break;
        case 2:{
            if (index == 0) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"开始计划" message:@"开始计划将覆盖已经开始的计划" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 12;
                [alertView show];
            }else if (index ==1){
                
                [RTPlanRequest importWithPlan:plan success:^(id response){
                    type = 1;
                    
                }failure:^(NSError *error){
                    
                }];
            }else if (index == 2){
                
                if (![RTUtil isEmpty: plan.plancreateuserid]) {
                    RTFriendInfoTableViewController *friendInfo = [[RTFriendInfoTableViewController alloc]initWithFriendid:plan.plancreateuserid];
                    [self.navigationController pushViewController:friendInfo animated:YES];
                }
            }else if (index == 3){
                [self sharedCilck];
            }
        }break;
        default:
            break;
    }
    
    [settingPlanView dismiss];
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
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    switch ((int)imageIndex) {
        case 0:{
            [appDelegate sharedWeiboTimeLine:plan.plantitle Description:plan.plancontent objectID:plan.planid url:webView_.request.URL.absoluteString photo:UIImageJPEGRepresentation(([UIImage imageNamed:@"icon.png"]), 1.0)];
        }break;
        case 1:{
            [appDelegate sendLinkContent:plan.plantitle  Description:plan.plancontent Url:webView_.request.URL.absoluteString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 2:{
            [appDelegate sendLinkContentTimeLine:plan.plantitle  Description:plan.plancontent Url:webView_.request.URL.absoluteString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 3:{
            [appDelegate sharedQQFriendTitle:plan.plantitle  description:plan.plancontent url:webView_.request.URL.absoluteString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 4:{
            [appDelegate sharedQZoneTitle:plan.plantitle  description:plan.plancontent url:webView_.request.URL.absoluteString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        default:
            break;
    }
}

- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}

#pragma  mark UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        switch (alertView.tag ) {
            case 10:
            {
                [RTPlanRequest stopWithPlan:plan success:^(id response){
                    
                    type = 1;
                }failure:^(NSError *error){
                    
                }];
            }break;
            case 11:{
                [RTPlanRequest deleteWithPlan:plan success:^(id response){
                    type = 2;
                    if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }failure:^(NSError *error){
                    
                }];
            }break;
            case 12:{
                [RTPlanRequest startWithPlan:plan success:^(id response){
                    type = 0;
                    if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }failure:^(NSError *error){
                    
                }];
            }break;
            default:
                break;
        }
    }
}

#pragma mark -- fresh

- (void)refreshPage{
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    NSString *url = [NSString stringWithFormat:@"%@%@?userid=%@&planid=%@",URL_BASE,URL_PLAN_WEBDETAIL,userinfo.userid,plan.planid];
    NSLog(@"%@,",url);
    [webView_ loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark - UIWebViewDelegate


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"1 %@",request.URL);
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSLog(@" url %@",request.URL);
        
        NSString *round;
        NSString *cycleday;
        NSString *subplanid;
        NSString *userid;
        
        NSArray *arrayQuery = [request.URL.query componentsSeparatedByString:@"&"];
        for (NSString *string in arrayQuery) {
            NSArray *array   = [string componentsSeparatedByString:@"="];
            if ([[array objectAtIndex:0]  isEqual: @"id"]) {
                subplanid = [array objectAtIndex:1];
            }
            if ([[array objectAtIndex:0] isEqual:@"cycleRound"]) {
                round = [array objectAtIndex:1];
            }
            if ([[array objectAtIndex:0] isEqual:@"cycleDay"]) {
                cycleday = [array objectAtIndex:1];
            }if ([[array objectAtIndex:0] isEqual:@"userid"]) {
                userid = [array objectAtIndex:1];
            }
        }
        SmallHealthPlan *smallPlan;
        if (![RTUtil isEmpty:subplanid]&&![RTUtil isEmpty:round]&&![RTUtil isEmpty:cycleday]&&![RTUtil isEmpty:userid]) {
            for (SmallHealthPlan *smallPlanTemp in plan.smallhealthplan) {
                if ([smallPlanTemp.smallplansequence integerValue]==[cycleday intValue]&&[smallPlanTemp.smallplancycle intValue] == [round intValue]&&[smallPlanTemp.smallplanid isEqualToString:subplanid]) {
                    smallPlan = smallPlanTemp;
                }
            }
        }
        if (![RTUtil isEmpty: smallPlan]) {
            RTSmallPlanViewController *smallPlanController = [[RTSmallPlanViewController alloc]init];
            smallPlanController.smallPlan = smallPlan;
            smallPlanController.plan = plan;
            smallPlanController.url = request.URL.absoluteString;
            [self.navigationController pushViewController:smallPlanController animated:YES];
        }else{
            RTOtherSmallPlanViewController *smallPlanController = [[RTOtherSmallPlanViewController alloc]init];
            smallPlanController.url = request.URL.absoluteString;
            [self.navigationController pushViewController:smallPlanController animated:YES];
        }
        
        
        return NO;
    }else if (navigationType == UIWebViewNavigationTypeBackForward) {
        NSLog(@"back forward");
        if (![webView_ canGoBack]) {
        }
    }return YES;
}
@end

//- (id)initWith:(HealthPlan*)healthPlan Type:(NSInteger)index{
//    self = [super init];
//    if (self) {
//        plan = healthPlan;
//        type = index;
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    
//    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
//    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
//    [self.view addSubview:navigation];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setFrame:CGRectMake(0, 20, 40, 40)];
//    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
//    titleLabel.text = @"计划详情";
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font = BOLDFONT_17;
//    titleLabel.textColor = TITLE_COLOR;
//    [self.view addSubview:titleLabel];
//    
//    UIButton *btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnMessage.frame = CGRectMake(SCREEN_WIDTH - 67, (NAVIGATIONBAR_HEIGHT - 44) +6 , 57, 32);
//    [btnMessage addTarget:self action:@selector(settingCilck) forControlEvents:UIControlEventTouchUpInside];
//    [btnMessage setBackgroundImage:[UIImage imageNamed:@"settingplan.png"] forState:UIControlStateNormal];
//    [self.view addSubview:btnMessage];
//    
//    
//    
//    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT)];
//    tableview.delegate = self;
//    tableview.dataSource = self;
//    [self.view addSubview:tableview];
//    
//    [RTPlanRequest detailWithPlan:plan success:^(id response){
//        if ([[response objectForKey:@"state"] integerValue] == URL_NORMAL) {
//            [tableview reloadData];
//        }else{
//            
//        }
//    }failure:^(NSError *error){
//        
//    }];
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//- (void)backClick
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)settingCilck
//{
//    CGPoint point = CGPointMake(SCREEN_WIDTH - 22.5, NAVIGATIONBAR_HEIGHT);
//    RTPopOverView *popoverView = [[RTPopOverView alloc]initWithFrame:CGRectMake(0, 0, 150,150) withType:type];
//    popoverView.delegate = self;
//    
//    settingPlanView = [[PopoverView alloc]init];
//    settingPlanView.delegate = self;
//    [settingPlanView showAtPoint:point inView:self.view withContentView:popoverView];
//}
//
//#pragma mark - PopoverViewDelegate Methods
//
//- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
//
//    [popoverView showImage:[UIImage imageNamed:@"success"] withMessage:@"123"];
//    //Dismiss the PopoverView after 0.5 seconds
//    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
//}
//
//- (void)popoverViewDidDismiss:(PopoverView *)popoverView {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//}
//
//#pragma mark - RTPopOverViewDelegate
//
//- (void)clickItemAtIndex:(NSInteger)index
//{
//    switch (type) {
//        case 0:{
//            if (index == 0) {
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"停止计划" message:@"停止计划后，进度将被重置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                alertView.tag = 10;
//                [alertView show];
//            }else if (index ==1){
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"删除开始计划" message:@"删除已进行计划后，数据将不会被保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                alertView.tag = 11;
//                [alertView show];
//            }else{
//                if (![RTUtil isEmpty: plan.plancreateuserid]) {
//                    RTFriendInfoTableViewController *friendInfo = [[RTFriendInfoTableViewController alloc]initWithFriendid:plan.plancreateuserid];
//                    [self.navigationController pushViewController:friendInfo animated:YES];
//                }
//            }
//        }break;
//        case 1:{
//            if (index == 0) {
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"开始计划" message:@"开始计划将覆盖已经开始的计划" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                alertView.tag = 12;
//                [alertView show];
//            }else if (index ==1){
//                [RTPlanRequest deleteWithPlan:plan success:^(id response){
//                    if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
//                        [self.navigationController popViewControllerAnimated:YES];
//                    }
//                    type = 2;
//                }failure:^(NSError *error){
//                }];
//            }else{
//                
//                if (![RTUtil isEmpty: plan.plancreateuserid]) {
//                    RTFriendInfoTableViewController *friendInfo = [[RTFriendInfoTableViewController alloc]initWithFriendid:plan.plancreateuserid];
//                    [self.navigationController pushViewController:friendInfo animated:YES];
//                }
//            }
//        }break;
//        case 2:{
//            if (index == 0) {
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"开始计划" message:@"开始计划将覆盖已经开始的计划" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                alertView.tag = 12;
//                [alertView show];
//            }else if (index ==1){
//                
//                [RTPlanRequest importWithPlan:plan success:^(id response){
//                    type = 1;
//                    
//                }failure:^(NSError *error){
//                    
//                }];
//            }else{
//                
//                if (![RTUtil isEmpty: plan.plancreateuserid]) {
//                    RTFriendInfoTableViewController *friendInfo = [[RTFriendInfoTableViewController alloc]initWithFriendid:plan.plancreateuserid];
//                    [self.navigationController pushViewController:friendInfo animated:YES];
//                }
//            }
//        }break;
//        default:
//            break;
//    }
//    
//    [settingPlanView dismiss];
//}
//
//#pragma mark - UITableViewDelegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if(section == 0){
//        return 1;
//    }else{
//        NSMutableArray *array = [[NSMutableArray alloc]init];
//        for (SmallHealthPlan *smallPlan in plan.smallhealthplan) {
//            if ([smallPlan.smallplansequence integerValue]-1==(section-1)%[plan.plancycleday intValue]&&[smallPlan.smallplancycle intValue]-1 == (section-1)/[plan.plancycleday intValue]) {
//                [array addObject:smallPlan];
//            }
//        }
//        return array.count;
//    }
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    NSInteger count = [plan.plancycleday integerValue];
//    NSInteger days = [plan.plancyclenumber integerValue];
//    return 1+count*days;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        NSString *intrduce = [NSString stringWithFormat:@"计划介绍:%@",plan.plancontent];
//        CGSize framesize = [intrduce sizeWithFont:VERDANA_FONT_12
//                                constrainedToSize:CGSizeMake(290.0, MAXFLOAT)
//                                    lineBreakMode:NSLineBreakByCharWrapping];
//        return 110+framesize.height;
//    }else{
//        NSMutableArray *array = [[NSMutableArray alloc]init];
//        for (SmallHealthPlan *smallPlan in plan.smallhealthplan) {
//            if ([smallPlan.smallplansequence integerValue]-1==(indexPath.section-1)%[plan.plancycleday intValue]&&[smallPlan.smallplancycle intValue]-1 == (indexPath.section-1)/[plan.plancycleday intValue]) {
//                [array addObject:smallPlan];
//            }
//        }
//        SmallHealthPlan *smallPlanData = [array objectAtIndex:indexPath.row];
//        
//        NSString *markString = [NSString stringWithFormat:@"备注:%@",smallPlanData.smallplanmark];
//        
//        CGSize framesize = [markString sizeWithFont:VERDANA_FONT_12
//                           constrainedToSize:CGSizeMake(180.0, MAXFLOAT)
//                               lineBreakMode:NSLineBreakByCharWrapping];
//        return  (17.5+framesize.height/2)*2;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *indentifier = @"Cell";
//    if (indexPath.section == 0) {
//        RTPlanDetailTableViewCell *cell = [[RTPlanDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier Data:plan];
//        return cell;
//    }else{
//        NSMutableArray *array = [[NSMutableArray alloc]init];
//        for (SmallHealthPlan *smallPlan in plan.smallhealthplan) {
//            if ([smallPlan.smallplansequence integerValue]-1==(indexPath.section-1)%[plan.plancycleday intValue]&&[smallPlan.smallplancycle intValue]-1 == (indexPath.section-1)/[plan.plancycleday intValue]) {
//                [array addObject:smallPlan];
//            }
//        }
//        NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"smallplanid" ascending:NO];
//        [array sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
//        RTSmallPlanTableViewCell *cell = [[RTSmallPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier Data:[array objectAtIndex:indexPath.row]];
//        return cell;
//    }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 0;
//    }else if ((section-1)%[plan.plancycleday intValue] == 0){
//        return 40+20;
//    }else{
//        return 30;
//    }
//}
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
//    }else if((section-1)%[plan.plancycleday intValue] == 0){
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
//        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
//        label1.text =[NSString stringWithFormat:@"第%ld轮",1+section/[plan.plancycleday intValue]];
//        label1.font = VERDANA_FONT_12;
//        [view addSubview:label1];
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 100, 20)];
//        label.text =[NSString stringWithFormat:@"第%ld天",1+(section-1)%[plan.plancycleday intValue]];
//        label.font = VERDANA_FONT_12;
//        [view addSubview:label];
//    
//        return view;
//    }else{
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
//        label.text =[NSString stringWithFormat:@"第%ld天",1+(section-1)%[plan.plancycleday intValue]];
//        label.font = VERDANA_FONT_12;
//        [view addSubview:label];
//        
//        return view;
//    }
//}
//
//#pragma  mark UIAlertView Delegate
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1) {
//        
//        switch (alertView.tag ) {
//            case 10:
//            {
//                [RTPlanRequest stopWithPlan:plan success:^(id response){
//                    
//                    type = 1;
//                }failure:^(NSError *error){
//                    
//                }];
//            }break;
//            case 11:{
//                [RTPlanRequest deleteWithPlan:plan success:^(id response){
//                    type = 2;
//                    if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
//                        [self.navigationController popViewControllerAnimated:YES];
//                    }
//                }failure:^(NSError *error){
//                    
//                }];
//            }break;
//            case 12:{
//                [RTPlanRequest startWithPlan:plan success:^(id response){
//                    type = 0;
//                    if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
//                        [self.navigationController popViewControllerAnimated:YES];
//                    }
//                }failure:^(NSError *error){
//                    
//                }];
//            }break;
//            default:
//                break;
//        }
//    }
//}
//@end
