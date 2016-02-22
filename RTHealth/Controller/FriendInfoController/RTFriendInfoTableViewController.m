//
//  RTFriendInfoTableViewController.m
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFriendInfoTableViewController.h"
#import "RTFriendInfoTableViewCell.h"
#import "RTFriendOtherInfoTableViewCell.h"
#import "RTFriendPlanViewController.h"
#import "RTFriendAttionViewController.h"
#import "RTFriendFansViewController.h"
#import "RTFriendProgressTableViewCell.h"
#import "RTFriendSmallPlanTableViewCell.h"
#import "RTFriendDetailInfoViewController.h"
#import "RTPlanDetailViewController.h"
#import "RTChatViewController.h"
#import "RTFriendDetailRequest.h"
#import "RTPersonalTrendsViewController.h"
#import "RTOwnActivityViewController.h"
#import "RTPlanOtherWebViewController.h"
#import "RTOtherSmallPlanViewController.h"

//需修改
#import "RTAttentionViewController.h"
#import "RTMyFansViewController.h"
#import "RTOwnPlanViewController.h"

@interface RTFriendInfoTableViewController ()<UITableViewDataSource,UITableViewDelegate,RTFriendInfoTableViewCellDelegate,RTFriendOtherInfoTableViewCellDelegate,UIActionSheetDelegate>{
    UITableView *tableview;
    NSMutableArray *dataArray;
    UserInfo *userinfo;
}

@end

@implementation RTFriendInfoTableViewController

- (id)initWithFriendid:(NSString*)idString{
    self = [super init];
    if (self) {
        if ([RTUtil isEmpty:idString]) {
            return self;
        }
        if ([RTUtil isEmpty:self.friendInfo]) {
            self.friendInfo = [FriendsInfo MR_findFirstByAttribute:@"friendid" withValue:idString];
            if (self.friendInfo == nil) {
                self.friendInfo = [FriendsInfo MR_createEntity];
                self.friendInfo.friendid = idString;
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, NAVIGATIONBAR_HEIGHT)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    dataArray = [[NSMutableArray alloc]init];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = [RTUtil isEmpty:self.friendInfo.friendnickname]?@"TA":self.friendInfo.friendnickname;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    UIButton *btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMessage.frame = CGRectMake(SCREEN_WIDTH - 67, (NAVIGATIONBAR_HEIGHT - 44) +6 , 57, 32);
    [btnMessage addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"settingplan.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnMessage];
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    if ([self.friendInfo.friendid isEqualToString:userinfo.userid]) {
        [btnMessage setHidden:YES];
    }
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT)];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];

    [self getFriendInfo];
}

//刷新数据
- (void)loadData{
    HealthPlan *plan = self.friendInfo.healthplan;
    
    NSInteger dateInterval = [CustomDate getDayToDate:plan.planbegindate];
    if ([RTUtil isEmpty:plan] || dateInterval >= [plan.plancycleday intValue]*[plan.plancyclenumber intValue]) {
        dataArray = nil;
    }else {
        NSInteger cycle = dateInterval/[plan.plancycleday integerValue]+1;
        NSInteger days = dateInterval%[plan.plancycleday integerValue]+1;
        NSArray *array = [plan.smallhealthplan allObjects];
        
        NSPredicate *preTemplate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"smallplancycle=='%ld'",(long)cycle]];
        NSMutableArray *arrayCycle = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:preTemplate]];
        NSPredicate *preTemplate1 = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"smallplansequence=='%ld'",(long)days]];
        NSMutableArray *arrayToday = [NSMutableArray arrayWithArray:[arrayCycle filteredArrayUsingPredicate:preTemplate1]];
        
        dataArray = [NSMutableArray arrayWithArray:arrayToday];
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"smallplanbegintime" ascending:YES];
        NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"smallplanid" ascending:YES];
        [dataArray sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1,nil]];
    }
    
    [tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)messageClick{
    NSString *string;
    if ([self.friendInfo.friendflag intValue]==2 ||[self.friendInfo.friendflag intValue] == 3){
        string = @"取消关注";
    }else{
        string = @"加关注";
    }

    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:string,@"发私信", nil];
    
    [actionSheet showInView:self.view];
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}


- (void)getFriendInfo{
    [RTFriendDetailRequest friendInfoWith:self.friendInfo success:^(NSDictionary *response){
        if ([[response objectForKey:@"state"]integerValue] == 1000) {
            [self performSelectorOnMainThread:@selector(loadData) withObject:nil waitUntilDone:YES];
        }
        
    }failure:^(NSError *error){
    }];
}

# pragma mark UIActionSheet Delegate


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            if ([self.friendInfo.friendflag intValue]==2){
                
                [RTFriendRequest fansDeleteFriend:self.friendInfo Success:^(id response){
                    if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                        self.friendInfo.friendflag = @"4";
                    }
                }failure:^(NSError *error){
                }];
                
            }else if ([self.friendInfo.friendflag intValue] == 4){
                [RTFriendRequest fansCreateFriend:self.friendInfo Success:^(id response){
                    
                    if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                        self.friendInfo.friendflag = @"2";
                    }
                }failure:^(NSError *error){
                    
                }];
            }else if ([self.friendInfo.friendflag intValue] == 1){
                [RTFriendRequest fansCreateFriend:self.friendInfo Success:^(id response){
                    
                    if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                        self.friendInfo.friendflag = @"3";
                    }
                }failure:^(NSError *error){
                    
                }];
            }else if ([self.friendInfo.friendflag intValue] == 3){
                [RTFriendRequest fansDeleteFriend:self.friendInfo Success:^(id response){
                    if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                        self.friendInfo.friendflag = @"1";
                    }
                    
                }failure:^(NSError *error){
                }];
            }
        }break;
        case 1:{
            RTChatViewController *chatViewController = [[RTChatViewController alloc]init];
            chatViewController.friendID = self.friendInfo.friendid;
            chatViewController.friendInfo = self.friendInfo;
            [self.navigationController pushViewController:chatViewController animated:YES];
            
        }
            break;
        default:
            break;
    }
}

#pragma RTPersonalOtherInfo Delegate

- (void)clickfriendActivity
{
    if ([self.friendInfo.friendid isEqualToString:userinfo.userid]) {
        RTAppDelegate *appDelegate  = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
        RTOwnActivityViewController *activityView = [[RTOwnActivityViewController alloc]initWithId:self.friendInfo.friendid];
        [appDelegate.rootNavigationController pushViewController:activityView animated:YES];
        return;
    }
    RTAppDelegate *appDelegate  = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTOwnActivityViewController *activityView = [[RTOwnActivityViewController alloc]initWithId:self.friendInfo.friendid];
    [appDelegate.rootNavigationController pushViewController:activityView animated:YES];
    
}

- (void)clickHisAttention
{
    if ([self.friendInfo.friendid isEqualToString:userinfo.userid]) {
        RTAttentionViewController *attention = [[RTAttentionViewController alloc]init];
        [self.navigationController pushViewController:attention animated:YES];
        return;
    }
    RTFriendAttionViewController *attention = [[RTFriendAttionViewController alloc]init];
    attention.friendInfo = self.friendInfo;
    [self.navigationController pushViewController:attention animated:YES];
}

- (void)clickHisFans
{
    if ([self.friendInfo.friendid isEqualToString:userinfo.userid]) {
        RTMyFansViewController *attention = [[RTMyFansViewController alloc]init];
        [self.navigationController pushViewController:attention animated:YES];
        return;
    }
    RTFriendFansViewController *fansController = [[RTFriendFansViewController alloc]init];
    fansController.friendInfo = self.friendInfo;
    [self.navigationController pushViewController:fansController animated:YES];
    
}

- (void)clickfriendPlan
{
    if ([self.friendInfo.friendid isEqualToString:userinfo.userid]) {
        RTOwnPlanViewController *attention = [[RTOwnPlanViewController alloc]init];
        [self.navigationController pushViewController:attention animated:YES];
        return;
    }
    RTFriendPlanViewController *plan = [[RTFriendPlanViewController alloc]init];
    plan.friendInfo = self.friendInfo;
    [self.navigationController pushViewController:plan animated:YES];
    
}

- (void)clickfriendTrend
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTPersonalTrendsViewController *myTrendsView = [[RTPersonalTrendsViewController alloc]initWithPersonalId:self.friendInfo.friendid];
    [appDelegate.rootNavigationController pushViewController:myTrendsView animated:YES];
}

#pragma  table View Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuserindextifier = @"Cell";
    if (indexPath.row == 0) {
        RTFriendInfoTableViewCell *cell = [[RTFriendInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier data:self.friendInfo];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 1){
        RTFriendOtherInfoTableViewCell *cell = [[RTFriendOtherInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier data:self.friendInfo];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 2){
            RTFriendProgressTableViewCell *cell = [[RTFriendProgressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier Data:self.friendInfo];
            return cell;
        
    }else{
            RTFriendSmallPlanTableViewCell *cell = [[RTFriendSmallPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier Data:[dataArray objectAtIndex:indexPath.row-3]];
            return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        RTAppDelegate *appDelegate                       = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
        RTFriendDetailInfoViewController *userInfoController     = [[RTFriendDetailInfoViewController alloc]init];
        userInfoController.friendInfo = self.friendInfo;
        [appDelegate.rootNavigationController pushViewController:userInfoController animated:YES];
    }else if (indexPath.row == 1){
    }
    else if (indexPath.row == 2){
        if ([self.friendInfo.friendid isEqualToString:userinfo.userid]) {
            RTPlanDetailViewController *planDetailController = [[RTPlanDetailViewController alloc]initWith:self.friendInfo.healthplan Type:1];
            RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.rootNavigationController pushViewController:planDetailController animated:YES];
        }else{
            RTPlanOtherWebViewController *planDetailController = [[RTPlanOtherWebViewController alloc]initWith:self.friendInfo.healthplan];
            planDetailController.friendInfo = self.friendInfo;
            RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.rootNavigationController pushViewController:planDetailController animated:YES];
        }
    }else{
        
        SmallHealthPlan *smallplan = [dataArray objectAtIndex:indexPath.row-3];
        NSString *url = [NSString stringWithFormat:@"%@%@?userid=%@&id=%@&cycleRound=%@&cycleDay=%@",URL_BASE,URL_PLAN_WEBSUBPLANDETAIL,self.friendInfo.friendid,smallplan.smallplanid,smallplan.smallplancycle,smallplan.smallplansequence];
        NSLog(@"URL %@",url);
        
        RTOtherSmallPlanViewController *smallPlanController = [[RTOtherSmallPlanViewController alloc]init];
        smallPlanController.url = url;
        RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.rootNavigationController pushViewController:smallPlanController animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 120.0;
    }else if (indexPath.row == 1) {
        return 45.0;
    }else if (indexPath.row == 2){
            return 58;
    }else{
        RTFriendSmallPlanTableViewCell *cell = [[RTFriendSmallPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" Data:[dataArray objectAtIndex:indexPath.row-3]];
        return [cell getheight];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([RTUtil isEmpty:dataArray]|| dataArray.count == 0) {
        return 2;
    }else {
        return 3+dataArray.count;
    }
}

@end
