//
//  RTPersonalTableViewController.m
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPersonalTableViewController.h"
#import "RTPersonalRequest.h"
#import "RTPersonalLetterViewController.h"
#import "RTPersonalInfoTableViewCell.h"
#import "RTPersonalOtherInfoTableViewCell.h"
#import "RTProgessBarTableViewCell.h"
#import "RTPersonalSmallPlanTableViewCell.h"
#import "RTPlanEmptyTableViewCell.h"
#import "RTOwnPlanTableViewCell.h"
#import "RTOwnPlanViewController.h"
#import "RTOwnActivityViewController.h"
#import "RTMyFansViewController.h"
#import "RTAttentionViewController.h"
#import "RTPersonalLetterViewController.h"
#import "RTUserInfoViewController.h"
#import "RTPlanDetailViewController.h"
#import "RTImportPlanViewController.h"
#import "RTPersonalTrendsViewController.h"
#import "RTPlanRequest.h"
#import "RTWeightRecordViewController.h"
#import "RTNominateWebViewController.h"
#import "RTNominateTableViewCell.h"
#import "RTNominate.h"
#import "RTPhotoNominateTableViewCell.h"
#import "RTSmallPlanViewController.h"

@interface RTPersonalTableViewController ()<UITableViewDataSource,UITableViewDelegate,RTPersonalInfoTableViewCellDelegate,RTPersonalOtherInfoTableViewCellDelegate,RTOwnPlanTableViewCellDelegate>{
    UITableView *tableview;
    UserInfo *userinfo;
    //message的小红点
    UILabel *labelmessage;
    //记录体重的小红点
    UILabel *labelweight;
    NSMutableArray *dataArray;
    NSMutableArray *systemArray;
    NSMutableArray *nominateArray;
}

@end

@implementation RTPersonalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nominateArray = [[NSMutableArray alloc]init];
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    [self getUserInfo];
    systemArray = [[NSMutableArray alloc]init];
    dataArray = [[NSMutableArray alloc]init];
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, NAVIGATIONBAR_HEIGHT)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"首页";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    UIButton *btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMessage.frame = CGRectMake(SCREEN_WIDTH - 39, (NAVIGATIONBAR_HEIGHT - 44) +11 , 29, 22);
    [btnMessage addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"messageimage.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnMessage];
    
    
    UIButton *btnweight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnweight.frame = CGRectMake(10, (NAVIGATIONBAR_HEIGHT - 44) +9 , 29, 29);
    [btnweight addTarget:self action:@selector(weightClick) forControlEvents:UIControlEventTouchUpInside];
    [btnweight setBackgroundImage:[UIImage imageNamed:@"recordweight.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnweight];
    
    labelweight = [[UILabel alloc]initWithFrame:CGRectMake(39, 26 , 6, 6)];
    labelweight.layer.cornerRadius = 3.0;
    labelweight.layer.masksToBounds = YES;
    labelweight.backgroundColor = [UIColor redColor];
    if ([CustomDate equalToDate:[[NSUserDefaults standardUserDefaults] objectForKey:WEIGHT_RECORD_TIME]]) {
        [labelweight setHidden:YES];
    }
    [self.view addSubview:labelweight];
    
    
    labelmessage = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-28, (NAVIGATIONBAR_HEIGHT - 44) +11-5, 22, 12)];
    labelmessage.backgroundColor = [UIColor redColor];
    labelmessage.alpha = 1.0;
    labelmessage.textColor = [UIColor whiteColor];
    labelmessage.textAlignment = NSTextAlignmentCenter;
    labelmessage.font = VERDANA_FONT_10;
    labelmessage.layer.cornerRadius = 6.0;
    labelmessage.layer.masksToBounds = YES;
    if (userData.favoriteNumber.intValue+userData.replyNumber.intValue+userData.systemNumber.intValue+userData.activityRemindNumber.intValue+userData.notReadChatNumber.intValue <= 0) {
        labelmessage.hidden = YES;
    }
    [self.view addSubview:labelmessage];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-TABBAR_HEIGHT)style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableview];
    [self getSystemPlan];
    [self loadData];
    [self getNominate];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadUserInfo) name:VIEWSHOULDLOAD object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:GETMYPLAN object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAllMessage) name:GETALLMESSAGE object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyPhoto) name:MODIFYPHOTO object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(labelWeight) name:WEIGHT_RECORD_TIME object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)weightClick{
    RTWeightRecordViewController *recordController = [[RTWeightRecordViewController alloc]init];
    
    RTAppDelegate *appDelegate                       = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.rootNavigationController pushViewController:recordController animated:YES];
    
}
//保存体重成功后去掉小红点
- (void)labelWeight{
    if ([CustomDate equalToDate:[[NSUserDefaults standardUserDefaults] objectForKey:WEIGHT_RECORD_TIME]]) {
        [labelweight setHidden:YES];
    }else{
        [labelweight setHidden:NO];
    }
}

//定时获取所有消息的通知方法
- (void)getAllMessage{
    RTUserInfo *userData = [RTUserInfo getInstance];
    int acount  = userData.favoriteNumber.intValue+userData.replyNumber.intValue+userData.systemNumber.intValue+userData.activityRemindNumber.intValue+userData.notReadChatNumber.intValue;
    if (acount <= 0) {
        labelmessage.hidden = YES;
    }else if (acount >= 99) {
        labelmessage.hidden = NO;
        labelmessage.text = [NSString stringWithFormat:@"99"];
    }
    else{
        labelmessage.hidden = NO;
        labelmessage.text = [NSString stringWithFormat:@"%d",acount];
    }
}
- (void)modifyPhoto{
    [self getUserInfo];
}
//刷新数据
- (void)loadData{
    HealthPlan *plan = userinfo.healthplan;
    
    NSInteger dateInterval = [CustomDate getDayToDate:plan.planbegindate];
    if ([RTUtil isEmpty:plan] || dateInterval >= [plan.plancycleday intValue]*[plan.plancyclenumber intValue]) {
        dataArray = nil;
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[userinfo.systemplan allObjects]];
        NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"planid" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
        systemArray = [NSMutableArray arrayWithArray:array];
        if (![RTUtil isEmpty:plan]) {
            userinfo.healthplan = nil;
            [userinfo.finishedplanSet addObject:plan];
        }
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


- (void)getNominate{
    [RTPersonalRequest getNominate:nominateArray success:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [tableview reloadData];
        }
    } failure:^(NSError *error){
        
    }];
}
//table view 重新加载数据
- (void)reloadData{
    [self getUserOtherInfo];
    [self getUserInfo];
    [self getAllMessage];
    [self loadData];
}
- (void)loadUserInfo{
    [self loadData];
    [self getAllMessage];
    //刷新粉丝和关注
    [self getUserOtherInfo];
}
//点击消息按钮
- (void)messageClick
{
    [self getAllMessage];
    //跳转消息页面
    RTPersonalLetterViewController *message = [[RTPersonalLetterViewController alloc]init];
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.rootNavigationController pushViewController:message animated:YES];
    
}

//获取系统推荐计划
- (void)getSystemPlan{
    
    HealthPlan *plan = userinfo.healthplan;
    if ([RTUtil isEmpty:plan]||[RTUtil isEmpty:plan.planbegindate]) {
        [self getSystemplanRequest];
        
    }else{
        NSInteger dateInterval = [CustomDate getDayToDate:plan.planbegindate]+1;
        
        if (dateInterval > [plan.plancycleday intValue]*[plan.plancyclenumber intValue]||[RTUtil isEmpty:plan]) {
            
            [self getSystemplanRequest];
        }
    }
}
- (void)getSystemplanRequest{
    if (![RTUtil isEmpty:userinfo.systemplan] && userinfo.systemplan.count != 0){
    }else{
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
        [parameter setObject:userinfo.userid forKey:@"userid"];
        [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
        [RTPlanRequest systemPlan:parameter success:^(id response){
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                [self loadData];
            }
        }failure:^(NSError *error){
        }];
    }
}
#pragma RTPersonalInfoTableViewCellDelegate

- (void)clickMyAttention
{
    RTAttentionViewController *attention = [[RTAttentionViewController alloc]init];
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootNavigationController pushViewController:attention animated:YES];
}

- (void)clickMyFans
{
    RTMyFansViewController *fans = [[RTMyFansViewController alloc]init];
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootNavigationController pushViewController:fans animated:YES];
    
}

#pragma mark 数据获取


- (void)getUserInfo{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:userinfo.userid,@"userid",userinfo.usertoken,@"usertoken", nil];
    [RTPersonalRequest userInfoWith:param success:^(NSDictionary *response){
        if ([[response objectForKey:@"state"]integerValue] == 1000) {
            [self performSelectorOnMainThread:@selector(changeView) withObject:nil waitUntilDone:YES];
        }
    }failure:^(NSError *error){
    }];
}

- (void)getUserOtherInfo{
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:userinfo.userid,@"userid",userinfo.usertoken,@"usertoken", nil];
    [RTPersonalRequest userOtherInfoWith:param success:^(NSDictionary *response){
        if ([[response objectForKey:@"state"]integerValue] == 1000) {
            [self performSelectorOnMainThread:@selector(changeOtherView) withObject:nil waitUntilDone:YES];
        }
    }failure:^(NSError *error){
    }];
}


- (void)changeView{
    [tableview reloadData];
}

- (void)changeOtherView{
    [tableview reloadData];
}

#pragma RTPersonalOtherInfo Delegate

- (void)clickMyActivity
{
    RTOwnActivityViewController *activity = [[RTOwnActivityViewController alloc] initWithId:userinfo.userid];
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootNavigationController pushViewController:activity animated:YES];
}

- (void)clickMyPlan
{
    RTAppDelegate *appDelegate    = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTOwnPlanViewController *plan = [[RTOwnPlanViewController alloc]init];
    [appDelegate.rootNavigationController pushViewController:plan animated:YES];
    
}

- (void)clickMyTrend
{
    RTAppDelegate *appDelegate    = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTPersonalTrendsViewController *myTrendsView = [[RTPersonalTrendsViewController alloc]initWithPersonalId:userinfo.userid];
    [appDelegate.rootNavigationController pushViewController:myTrendsView animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark RTOwnPlanTableViewCell Delegate

- (void)shouldReload{
    [self loadData];
}

#pragma  mark table View Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuserindextifier = @"Cell";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RTPersonalInfoTableViewCell *cell = [[RTPersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier];
            cell.delegate = self;
            return cell;
        }else if (indexPath.row == 1){
            RTPersonalOtherInfoTableViewCell *cell = [[RTPersonalOtherInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier];
            cell.delegate = self;
            return cell;
        }else if (indexPath.row == 2){
            if ((dataArray == nil || dataArray.count == 0) &&userinfo.healthplan == nil) {
                
                RTPlanEmptyTableViewCell *cell = [[RTPlanEmptyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier];
                return cell;
            }else {
                
                RTProgessBarTableViewCell *cell = [[RTProgessBarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier];
                return cell;
            }
            
        }else{
            
            if ((dataArray == nil || dataArray.count == 0 ) &&userinfo.healthplan == nil) {
                RTOwnPlanTableViewCell *cell = [[RTOwnPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier withData:[systemArray objectAtIndex:indexPath.row-3]];
                cell.delegate = self;
                return cell;
            }else {
                RTPersonalSmallPlanTableViewCell *cell = [[RTPersonalSmallPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier data:[dataArray objectAtIndex:indexPath.row-3]];
                return cell;
            }
        }
    }else{
        if (indexPath.row == 0) {
            NSDictionary *diction = [nominateArray objectAtIndex:indexPath.section-1];
            NSArray *array = [diction objectForKey:@"data"];
            NSDictionary *nominate = [array objectAtIndex:indexPath.row];
            RTPhotoNominateTableViewCell *cell = [[RTPhotoNominateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier];
            [cell.photoImage setOnlineImage:[RTUtil urlPhoto:[nominate objectForKey:@"photo"]]];
            return cell;
        }
        RTNominateTableViewCell *cell = [[RTNominateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserindextifier];
        NSDictionary *diction = [nominateArray objectAtIndex:indexPath.section-1];
        NSArray *array = [diction objectForKey:@"data"];
        NSDictionary *nominate = [array objectAtIndex:indexPath.row];
        cell.contentLabel.text = [nominate objectForKey:@"content"];
        cell.titleLabel.text = [nominate objectForKey:@"title"];
        [cell.photoImage setOnlineImage:[RTUtil urlPhoto:[nominate objectForKey:@"photo"]]];
        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            RTAppDelegate *appDelegate                       = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
            RTUserInfoViewController *userInfoController     = [[RTUserInfoViewController alloc]init];
            [appDelegate.rootNavigationController pushViewController:userInfoController animated:YES];
        }else if (indexPath.row == 1){
        }
        else if (indexPath.row == 2){
            if ((dataArray == nil || dataArray.count == 0 ) &&userinfo.healthplan == nil) {
                
                RTImportPlanViewController *planDetail = [[RTImportPlanViewController alloc]init];
                
                RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.rootNavigationController pushViewController:planDetail animated:YES];
            }else {
                RTPlanDetailViewController *planDetailController = [[RTPlanDetailViewController alloc]initWith:userinfo.healthplan Type:0];
                RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.rootNavigationController pushViewController:planDetailController animated:YES];
            }
        }else{
            if ((dataArray == nil || dataArray.count == 0 ) &&userinfo.healthplan == nil) {
                
                RTPlanDetailViewController *planDetailController = [[RTPlanDetailViewController alloc]initWith:[systemArray objectAtIndex:indexPath.row-3] Type:2];
                RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.rootNavigationController pushViewController:planDetailController animated:YES];
                
            }else {
                SmallHealthPlan *smallplan = [dataArray objectAtIndex:indexPath.row-3];
                NSString *url = [NSString stringWithFormat:@"%@%@?userid=%@&id=%@&cycleRound=%@&cycleDay=%@",URL_BASE,URL_PLAN_WEBSUBPLANDETAIL,userinfo.userid,smallplan.smallplanid,smallplan.smallplancycle,smallplan.smallplansequence];
                NSLog(@"URL %@",url);
                
                RTSmallPlanViewController *smallPlanController = [[RTSmallPlanViewController alloc]init];
                smallPlanController.smallPlan = smallplan;
                smallPlanController.plan = userinfo.healthplan;
                smallPlanController.url = url;
                RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.rootNavigationController pushViewController:smallPlanController animated:YES];
            }
        }
    }else{
        NSDictionary *diction = [nominateArray objectAtIndex:indexPath.section-1];
        NSArray *array = [diction objectForKey:@"data"];
        NSDictionary *nominate = [array objectAtIndex:indexPath.row];
        
        RTNominateWebViewController *nominateController = [[RTNominateWebViewController alloc]init];
        nominateController.url = [nominate objectForKey:@"url"];
        nominateController.title = [nominate objectForKey:@"title"];
        nominateController.photo = [nominate objectForKey:@"photo"];
        nominateController.content = [nominate objectForKey:@"content"];
        RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.rootNavigationController pushViewController:nominateController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 120.0;
        }else if (indexPath.row == 1) {
            return 45.0;
        }else if (indexPath.row == 2){
            
            if ((dataArray == nil || dataArray.count == 0 ) &&userinfo.healthplan == nil) {
                return 78;
            }else {
                return 58;
            }
        }else{
            
            if ((dataArray == nil || dataArray.count == 0 ) &&userinfo.healthplan == nil) {
                return 70;
            }else {
                RTPersonalSmallPlanTableViewCell *cell = [[RTPersonalSmallPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" data:[dataArray objectAtIndex:indexPath.row-3]];
                return [cell getheight];
            }
        }
    }else{
        if (indexPath.row == 0) {
            return 95;
        }
        return 59.0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (nominateArray == nil || nominateArray.count == 0) {
        return 1;
    }
    return nominateArray.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ((dataArray == nil || dataArray.count == 0 ) &&userinfo.healthplan == nil) {
            return 3+systemArray.count;
        }else {
            return 3+dataArray.count;
        }
    }else{
        NSDictionary *diction = [nominateArray objectAtIndex:section-1];
        NSArray *array = [diction objectForKey:@"data"];
        return array.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 40.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 45;
    }else{
        
        return 5;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 86)];
        headerView.backgroundColor = [UIColor colorWithRed:231/255.0 green:238/255.0 blue:244.0/255.0 alpha:1.0];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(45, 10, 100, 25)];
        label.text = @"每日推荐";
        label.font = [UIFont boldSystemFontOfSize:12.0];
        [headerView addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 25, 25)];
        imageView.image = [UIImage imageNamed:@"nominate.png"];
        [headerView addSubview:imageView];
        return headerView;
    }else{
        UIView *view = [[UIView alloc]init];
        return view;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        return view;
    }else{
        
        NSDictionary *diction = [nominateArray objectAtIndex:section-1];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 86)];
        headerView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255.0/255.0 alpha:1.0];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 300, 20)];
        timeLabel.text = [diction objectForKey:@"date"];
        timeLabel.textColor = [UIColor colorWithRed:236/255.0 green:100/255.0 blue:0/255.0 alpha:1.0];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = VERDANA_FONT_12;
        [headerView addSubview:timeLabel];
        return headerView;
    }
}
@end
