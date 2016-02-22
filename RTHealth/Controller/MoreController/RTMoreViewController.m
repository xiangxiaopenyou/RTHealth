//
//  RTMoreViewController.m
//  RTHealth
//
//  Created by cheng on 14/12/27.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTMoreViewController.h"
#import "RTFriendInfoTableViewController.h"
#import "RTChangePasswordViewController.h"
#import "RTAgeChooseViewController.h"
#import "RTRecommendedPlanViewController.h"
#import "RTPersonalRequest.h"
#import "RTFoodWebViewController.h"
#import "RTIntroductionViewController.h"

@interface RTMoreViewController ()<UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate>{
    UITableView *tableview;
    NSArray *sectionArray;
}
@property (nonatomic, strong) NSString *updateUrl;

@end

@implementation RTMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, NAVIGATIONBAR_HEIGHT)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"更多";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-TABBAR_HEIGHT) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    [self.view addSubview:tableview];
    
    
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"账号密码",@"用户反馈", nil];
//    NSArray *array2 = [[NSArray alloc] initWithObjects:@"微信",@"微博",@"QQ", nil];
    NSArray *array3 = [[NSArray alloc] initWithObjects:@"检查更新",@"清除缓存",@"给我们好评", nil];
    NSArray *array4 = [[NSArray alloc] initWithObjects:@"退出登录", nil];
    sectionArray = [[NSArray alloc] initWithObjects:array1,array3,array4, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    NSArray *array = [sectionArray objectAtIndex:indexPath.section];
    NSString *string = [array objectAtIndex:indexPath.row];
    if (indexPath.section == 2) {
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.textLabel.text = string;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = SMALLFONT_14;
        cell.backgroundColor = [UIColor colorWithRed:36.0f/255.0 green:159/255.0 blue:248.0f/255.0 alpha:1.0];
        return cell;
    }
    else if(indexPath.section == 0){
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = string;
        cell.textLabel.font = SMALLFONT_14;
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        return cell;
    }
    else{
    
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
        cell.textLabel.text = string;
        cell.textLabel.font = SMALLFONT_14;
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        switch (indexPath.row) {
            case 0:{
                UIImageView *updateImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 7, 30, 30)];
                updateImage.image = [UIImage imageNamed:@"update.png"];
                [cell addSubview:updateImage];
            }
            break;
            case 1:{
                UIImageView *cleanImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 7, 30, 30)];
                cleanImage.image = [UIImage imageNamed:@"clean_cache.png"];
                [cell addSubview:cleanImage];
            }
            break;
                
            case 2:{
                UIImageView *commentsImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 7, 30, 30)];
                commentsImage.image = [UIImage imageNamed:@"positive_comments.png"];
                [cell addSubview:commentsImage];
            }
            break;
                
            default:
                break;
        }
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [sectionArray objectAtIndex:section];
    return array.count;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 53)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 26, 100, 15)];
        headerLabel.font = [UIFont systemFontOfSize:16];
        headerLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        headerLabel.text = @"账号资料";
        [headerView addSubview:headerLabel];
        return headerView;
    }
    else if(section == 1){
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 53)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 26, 100, 15)];
        headerLabel.font = [UIFont systemFontOfSize:16];
        headerLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        headerLabel.text = @"其他功能";
        [headerView addSubview:headerLabel];
        return headerView;
    }
    else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 53;
            break;
        case 1:
            return 53;
            break;
        case 2:
            return 30;
            
        default:
            return 0;
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                    
                case 0:{
                    RTChangePasswordViewController *changePasswordController = [[RTChangePasswordViewController alloc] init];
                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appDelegate.rootNavigationController pushViewController:changePasswordController animated:YES];
                }break;
                case 1:{
                    
                    RTFoodWebViewController *food = [[RTFoodWebViewController alloc]init];
                    food.title = @"用户反馈";
                    food.url = @"http://www.wenjuan.com/s/bQvMJ3/";
                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appDelegate.rootNavigationController pushViewController:food animated:YES];
                }break;
                    
                default:
                    break;
            }
            
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0:{
                    //RTIntroductionViewController *introductionView = [[RTIntroductionViewController alloc] init];
//                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
//                    RTIntroductionViewController *introViewController = [[RTIntroductionViewController alloc] init];
//                    [appDelegate.rootNavigationController pushViewController:introViewController animated:YES];
                    if (![JDStatusBarNotification isVisible]) {
                        [JDStatusBarNotification showWithStatus:@"正在检查更新..."];
                    }
                    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
                    [RTPersonalRequest checkUpdateSuccess:^(id response){
                        if ([[response objectForKey:@"version"] intValue] == 1) {
                            [JDStatusBarNotification showWithStatus:@"已是最新版本咯~" dismissAfter:2.0f];
                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"检查更新" message:@"已经是最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                            
                        }else if ([[response objectForKey:@"version"] intValue] == 2){
                            self.updateUrl = [response objectForKey:@"updateurl"];
                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"有新版本更新" message:[response objectForKey:@"data"] delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"马上更新", nil];
                            alertView.tag = 100;
                            [alertView show];
                            [JDStatusBarNotification dismiss];
                        }
                    }failure:^(NSError *error){
                        [JDStatusBarNotification showWithStatus:@"请检查网络" dismissAfter:2.0f];
                    }];
                }
                    break;
                case 1:{
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"清除缓存图片" message:@"立刻清除?" delegate:self cancelButtonTitle:@"暂不" otherButtonTitles:@"清除", nil];
                    alertView.tag = 101;
                    [alertView show];
                }break;
                case 2:{
//                    NSString *str = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", @"893122685"];
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                    NSString *str2 = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",  @"958451085"];//打开某应用
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str2]];
                }break;
                default:
                    break;
            }
            break;
            
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录" message:@"退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alert show];
                }break;
                    
                default:
                    break;
            }}break;
            
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if(buttonIndex == 1){
            NSURL *url = [NSURL URLWithString:self.updateUrl];
            [[UIApplication sharedApplication] openURL:url];
        }
    }else if(alertView.tag == 101 ){
        if(buttonIndex == 1){
            ImageCacheQueue *clear = [ImageCacheQueue sharedCache];
            [clear clearCache];
        }
    }
    else{
        if (buttonIndex == 1) {
            
            RTUserInfo *userData = [RTUserInfo getInstance];
            userData.userData = nil;
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userid"];
            [[NSNotificationCenter defaultCenter]postNotificationName:LOGINSTATECHANGE object:@NO];
        }
    }
}

@end
