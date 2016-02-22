//
//  RTSportsCircleViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/12.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTSportsCircleViewController.h"
#import "RTTrendsTableViewCell.h"
#import "RTTrendsRequest.h"
#import "RTTrendDetailViewController.h"

@interface RTSportsCircleViewController ()<UITableViewDataSource, UITableViewDelegate, RTTrendsTableViewCellDelegate, EGORefreshTableHeaderDelegate, UIScrollViewDelegate, RTTrendDetailDelegate>{
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    UITableView *sportsTableView;
    UserInfo *userinfo;
    
    NSMutableArray *sportsTrendsArray;
    NSString *timeString;
    NSString *userIdString;
    NSString *classifyString;
    
    BOOL _reloading;
    BOOL showMore;
    BOOL isGetData;

}

@end

@implementation RTSportsCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _reloading = NO;
    isGetData = YES;
    showMore = NO;
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    sportsTrendsArray = [[NSMutableArray alloc] init];
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"健身圈";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    //tableview
    sportsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
    sportsTableView.delegate = self;
    sportsTableView.dataSource = self;
    sportsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    sportsTableView.sectionIndexColor = [UIColor clearColor];
    sportsTableView.backgroundView = nil;
    sportsTableView.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    sportsTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:sportsTableView];
    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - sportsTableView.bounds.size.height, sportsTableView.frame.size.width, sportsTableView.bounds.size.height)];
        _refreshHeaderView.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
        _refreshHeaderView.delegate = self;
        [sportsTableView addSubview:_refreshHeaderView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    [self refreshSportsTrends];
}


//上拉加载
- (void)getSportsTrends
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userinfo.userid forKey:@"userid"];
    [dic setObject:userinfo.usertoken forKey:@"usertoken"];
    if (userinfo.sportstrends.count != 0) {
        Trends *trend = [sportsTrendsArray lastObject];
        [dic setObject:trend.trendtime forKey:@"time"];
        [dic setObject:trend.userid forKey:@"fansid"];
    }
    if (![RTUtil isEmpty:classifyString]) {
        [dic setObject:classifyString forKey:@"topic"];
    }
    [RTTrendsRequest getSportsTrendsWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"获取运动圈动态成功");
            [sportsTrendsArray removeAllObjects];
            [sportsTrendsArray addObjectsFromArray:[userinfo.sportstrends allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
            [sportsTrendsArray sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
            if ([[response objectForKey:@"count"]  integerValue] != 10) {
                showMore = YES;
            }
            else{
                showMore = NO;
            }
            
        }
        else{
            NSLog(@"获取运动圈动态失败");
            showMore = YES;
        }
        [sportsTableView reloadData];
        isGetData = NO;
    } failure:^(NSError *error) {
        NSLog(@"失败");
        showMore = YES;
        [sportsTableView reloadData];
        isGetData = NO;
    }];

}

//刷新
- (void)refreshSportsTrends
{
    classifyString = nil;
    for(Trends *removeTrend in userinfo.sportstrends){
        [removeTrend MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [userinfo.sportstrendsSet removeAllObjects];
    //NSString *timeString = [CustomDate getDateString:[NSDate date]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userinfo.userid forKey:@"userid"];
    [dic setObject:userinfo.usertoken forKey:@"usertoken"];
    
    [RTTrendsRequest getSportsTrendsWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"获取运动圈动态成功");
            [sportsTrendsArray removeAllObjects];
            [sportsTrendsArray addObjectsFromArray:[userinfo.sportstrends allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
            [sportsTrendsArray sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
            if ([[response objectForKey:@"count"]  integerValue] != 10) {
                showMore = YES;
            }
            else{
                showMore = NO;
            }
           
            
        }
        else{
            NSLog(@"获取运动圈动态失败");
            showMore = YES;
        }
        [self doneLoadingTableViewData];
        isGetData = NO;
    } failure:^(NSError *error) {
        NSLog(@"失败");
        showMore = YES;
        [self doneLoadingTableViewData];
        isGetData = NO;
    }];
    
}

//带话题类型刷新
- (void)refreshSportsWithType
{
    for(Trends *removeTrend in userinfo.sportstrends){
        [removeTrend MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [userinfo.sportstrendsSet removeAllObjects];
    //NSString *timeString = [CustomDate getDateString:[NSDate date]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userinfo.userid forKey:@"userid"];
    [dic setObject:userinfo.usertoken forKey:@"usertoken"];
    if (![RTUtil isEmpty:classifyString]) {
        [dic setObject:classifyString forKey:@"topic"];
    }
    
    [RTTrendsRequest getSportsTrendsWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"获取运动圈动态成功");
            [sportsTrendsArray removeAllObjects];
            [sportsTrendsArray addObjectsFromArray:[userinfo.sportstrends allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
            [sportsTrendsArray sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
            if ([[response objectForKey:@"count"]  integerValue] != 10) {
                showMore = YES;
            }
            else{
                showMore = NO;
            }
            
            
        }
        else{
            NSLog(@"获取运动圈动态失败");
            showMore = YES;
        }
        [self doneLoadingTableViewData];
        isGetData = NO;
    } failure:^(NSError *error) {
        NSLog(@"失败");
        showMore = YES;
        [self doneLoadingTableViewData];
        isGetData = NO;
    }];
}

#pragma mark - RTTrendsTableViewCellDelegate
- (void)clickHeadImage:(NSString *)userid
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:userid];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
}
- (void)clickNicknameButton:(NSString *)userid
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:userid];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
}
- (void)clickTrendsClassfy:(NSString *)classify
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"#"];
    classifyString = [classify stringByTrimmingCharactersInSet:set];
    [self refreshSportsWithType];
}

- (void)clickLabel:(NSString *)labelString
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"#"];
    classifyString = [labelString stringByTrimmingCharactersInSet:set];
    [self refreshSportsWithType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sportsTrendsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellidentifier = @"Cell";
    static NSString *lastCell = @"LastCell";
    
    if (indexPath.row >= sportsTrendsArray.count) {
        RTLastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lastCell];
        if (cell == nil) {
            cell = [[RTLastTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCell];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
        if (showMore) {
            cell.label.text = @"没有更多动态喽~";
            [cell.indicatorView stopAnimating];
        }
        else{
            cell.label.text = @"加载中...";
            [cell.indicatorView startAnimating];
            if (!isGetData) {
                [self getSportsTrends];
            }
        }
        return cell;
        
    }
    else{
    
        Trends *trend = [sportsTrendsArray objectAtIndex:indexPath.row];
        
        RTTrendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidentifier];
        cell = [[RTTrendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidentifier WithData:trend];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.delegate = self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row < sportsTrendsArray.count) {
        RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
        RTTrendDetailViewController *trendDetailView = [[RTTrendDetailViewController alloc] init];
        trendDetailView.delegate = self;
        trendDetailView.trend = [sportsTrendsArray objectAtIndex:indexPath.row];
        [appDelegate.rootNavigationController pushViewController:trendDetailView animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == sportsTrendsArray.count) {
        return 48;
    }
    else{
        Trends *trend = [sportsTrendsArray objectAtIndex:indexPath.row];
        RTTrendsTableViewCell *cell = (RTTrendsTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [cell heightWith:trend];
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate
- (void)reloadTableViewDataSource
{
    _reloading = YES;
    [self refreshSportsTrends];
}
- (void)doneLoadingTableViewData
{
    _reloading=NO;
    [sportsTableView reloadData];
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:sportsTableView];
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
}
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}
-(NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
