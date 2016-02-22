//
//  RTDiscoverViewController.m
//  RTHealth
//
//  Created by cheng on 14/10/29.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTDiscoverViewController.h"
#import "RTActivityViewController.h"
#import "RTNearByUserViewController.h"
#import "RTTeacherViewController.h"
#import "RTPopularViewController.h"
#import "RTSportsCircleViewController.h"
#import "RTGuessLikeViewController.h"
#import "RTImportPlanViewController.h"
#import "RTSearchViewController.h"
#import "RTFoodWebViewController.h"
#import "RTHealthReportViewController.h"

@interface RTDiscoverViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate>{
    NSArray *sectionArray;
}

@end

@implementation RTDiscoverViewController

@synthesize tableview = _tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"健身圈", nil];
    NSArray *array2 = [[NSArray alloc] initWithObjects:@"活动",@"计划", nil];
    NSArray *array3 = [[NSArray alloc] initWithObjects:@"附近的人",@"人气",@"教练/达人", nil];
    NSArray *array4 = [[NSArray alloc] initWithObjects:@"健康报告",@"食物热量",@"运动耗能", nil];
    sectionArray = [[NSArray alloc] initWithObjects:array1,array2,array3,array4, nil];
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    self.searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    self.searchbar.placeholder = @"搜索ID或用户名";
    self.searchbar.delegate = self;
    [self.view addSubview:self.searchbar];
    
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-TABBAR_HEIGHT)style:UITableViewStyleGrouped];
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.backgroundColor =[UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    [self.view addSubview:_tableview];
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
    NSInteger i = indexPath.section;
    NSInteger j = indexPath.row;
    NSArray *array = [sectionArray objectAtIndex:indexPath.section];
    NSString *string = [array objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"discover%02d_%02d.png",i,j]];
    cell.textLabel.text = string;
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:{
                    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
                    RTSportsCircleViewController *sportsView = [[RTSportsCircleViewController alloc]init];
                    [appDelegate.rootNavigationController pushViewController:sportsView animated:YES];
                }
                    
                    break;
                    
                case 1:{
                    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
                    RTGuessLikeViewController *guessLikeView = [[RTGuessLikeViewController alloc]init];
                    [appDelegate.rootNavigationController pushViewController:guessLikeView animated:YES];
                }
                    
                    break;
                    
                default:
                    break;
            }
            
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0:{
                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
                    RTActivityViewController *activity = [[RTActivityViewController alloc] init];
                    [appDelegate.rootNavigationController pushViewController:activity animated:YES];
                }
                    
                    break;
                    
                case 1:{
                    RTImportPlanViewController *importPlan = [[RTImportPlanViewController alloc]init];
                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appDelegate.rootNavigationController pushViewController:importPlan animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    RTNearByUserViewController *nearbyuser = [[RTNearByUserViewController alloc]init];
                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appDelegate.rootNavigationController pushViewController:nearbyuser animated:YES];
                }break;
                case 1:{
                    RTPopularViewController *popularController = [[RTPopularViewController alloc]init];
                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appDelegate.rootNavigationController pushViewController:popularController animated:YES];
                }break;
                case 2:{
                    RTTeacherViewController *teacherController = [[RTTeacherViewController alloc]init];
                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appDelegate.rootNavigationController pushViewController:teacherController animated:YES];
                }break;
                    
                default:
                    break;
            }}break;
            
        case 3:{
            switch (indexPath.row) {
                case 0:{
                    RTHealthReportViewController *food = [[RTHealthReportViewController alloc]init];
                    food.title = @"健康报告";
                    RTUserInfo *userData = [RTUserInfo getInstance];
                    UserInfo *userinfo = userData.userData;
                    NSString *urlString = [NSString stringWithFormat:@"%@%@?userid=%@",URL_BASE,URL_DISCOVER_HELP,userinfo.userid];
                    food.url = urlString;
//                    food.url = @"http://www.baidu.com";
                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appDelegate.rootNavigationController pushViewController:food animated:YES];
                }break;
                case 1:{
                    RTFoodWebViewController *food = [[RTFoodWebViewController alloc]init];
                    food.title = @"食物热量";
                    food.url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_DISCOVER_FOOD];
                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appDelegate.rootNavigationController pushViewController:food animated:YES];
                }break;
                case 2:{
                    RTFoodWebViewController *food = [[RTFoodWebViewController alloc]init];
                    food.title = @"运动耗能";
                    food.url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_DISCOVER_SPORT];
                    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appDelegate.rootNavigationController pushViewController:food animated:YES];
                }break;
                    
                default:
                    break;
            }}break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.searchbar) {
        [self.searchbar resignFirstResponder];
    }
}
#pragma UISearchBar Delegate


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    RTSearchViewController *searchContrller = [[RTSearchViewController alloc]init];
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootNavigationController pushViewController:searchContrller animated:YES];
    return NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end
