//
//  RTPersonalTrendsViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/12/19.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPersonalTrendsViewController.h"
#import "RTTrendsRequest.h"
#import "RTTrendsTableViewCell.h"
#import "RTTrendDetailViewController.h"

@interface RTPersonalTrendsViewController ()<UITableViewDataSource, UITableViewDelegate, RTTrendsTableViewCellDelegate, RTTrendDetailDelegate>
{
    UserInfo *userinfo;
    
    NSMutableArray *trendsArray;
    
    UITableView *trendTableView;
    RTTrendsTableViewCell *trendCell;
    
    NSString *classifyString;
    
    BOOL showMore;
    BOOL isGetData;
}

@end

@implementation RTPersonalTrendsViewController
@synthesize personalId;

- (id)initWithPersonalId:(NSString *)idString
{
    self = [super init];
    if (self) {
        if ([RTUtil isEmpty:idString]) {
            return self;
        }
        personalId = idString;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    showMore = NO;
    isGetData = YES;
    _reloading = NO;
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    trendsArray = [[NSMutableArray alloc] init];
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    if ([userinfo.userid isEqualToString:personalId]) {
        titleLabel.text = @"我的动态";
    }
    else{
        titleLabel.text = @"TA的动态";
    }
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    //话题列表
    trendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
    trendTableView.delegate = self;
    trendTableView.dataSource = self;
    
    [trendTableView setSectionIndexColor:[UIColor clearColor]];
    [trendTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [trendTableView setBackgroundView:nil];
    [trendTableView setBackgroundColor:[UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0]];
    trendTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:trendTableView];
    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - trendTableView.bounds.size.height, trendTableView.frame.size.width, trendTableView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        _refreshHeaderView.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
        [trendTableView addSubview:_refreshHeaderView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    [self refreshTrends];
}

//上拉加载
- (void)getTrends
{
    //[userinfo.usertrendsSet removeAllObjects];
    if ([userinfo.userid isEqualToString:personalId]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userinfo.userid forKey:@"userid"];
        [dic setObject:userinfo.usertoken forKey:@"usertoken"];
        NSString *timeString = [CustomDate getDateString:[NSDate date]];
        if (userinfo.usertrends.count == 0) {
            [dic setObject:timeString forKey:@"time"];
        }
        else{
            Trends *trend = [trendsArray lastObject];
            [dic setObject:trend.trendtime forKey:@"time"];
        }
        if (![RTUtil isEmpty:classifyString]) {
            [dic setObject:classifyString forKey:@"topic"];
        }
        [RTTrendsRequest getMyTrendsListWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"获取我的动态成功");
                [trendsArray removeAllObjects];
                [trendsArray addObjectsFromArray:[userinfo.usertrends allObjects]];
                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
                [trendsArray sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
                //NSLog(@"%@", trendsArray);
                if ([[response objectForKey:@"count"]  integerValue] != 10) {
                    showMore = YES;
                }
                else{
                    showMore = NO;
                }
            }
            else{
                NSLog(@"获取我的动态失败");
                showMore = YES;
            }
            [trendTableView reloadData];
            isGetData = NO;
        } failure:^(NSError *error) {
            NSLog(@"失败");
            showMore = YES;
            [trendTableView reloadData];
            isGetData = NO;
        }];
    }
    else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userinfo.userid forKey:@"userid"];
        [dic setObject:userinfo.usertoken forKey:@"usertoken"];
        [dic setObject:personalId forKey:@"friendid"];
        NSString *timeString = [CustomDate getDateString:[NSDate date]];
        if (userinfo.friendtrends.count == 0) {
            [dic setObject:timeString forKey:@"time"];
        }
        else{
            Trends *trend = [trendsArray lastObject];
            [dic setObject:trend.trendtime forKey:@"time"];
        }
        if (![RTUtil isEmpty:classifyString]) {
            [dic setObject:classifyString forKey:@"topic"];
        }
        [RTTrendsRequest getFriendsTrendsListWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"获取他人动态成功");
                [trendsArray removeAllObjects];
                [trendsArray addObjectsFromArray:[userinfo.friendtrends allObjects]];
                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
                [trendsArray sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
                //NSLog(@"%@", trendsArray);
                if ([[response objectForKey:@"count"]  integerValue] != 10) {
                    showMore = YES;
                }
                else{
                    showMore = NO;
                }
            }
            else{
                NSLog(@"获取他人动态失败");
                showMore = YES;
            }
            [trendTableView reloadData];
            isGetData = NO;
        } failure:^(NSError *error) {
            NSLog(@"失败");
            showMore = YES;
            [trendTableView reloadData];
            isGetData = NO;
        }];
    }

}

//下拉刷新
- (void)refreshTrends
{
    classifyString = nil;
    if ([userinfo.userid isEqualToString:personalId]) {
        for(Trends *removeTrend in userinfo.usertrends){
            [removeTrend MR_deleteEntity];
        }
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        [userinfo.usertrendsSet removeAllObjects];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userinfo.userid forKey:@"userid"];
        [dic setObject:userinfo.usertoken forKey:@"usertoken"];
        NSString *timeString = [CustomDate getDateString:[NSDate date]];
        [dic setObject:timeString forKey:@"time"];
        [RTTrendsRequest getMyTrendsListWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"获取我的动态成功");
                [trendsArray removeAllObjects];
                [trendsArray addObjectsFromArray:[userinfo.usertrends allObjects]];
                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
                [trendsArray sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
                //NSLog(@"%@", trendsArray);
                if ([[response objectForKey:@"count"]  integerValue] != 10) {
                    showMore = YES;
                }
                else{
                    showMore = NO;
                }
            }
            else{
                NSLog(@"获取我的动态失败");
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
    else{
        for(Trends *removeTrend in userinfo.friendtrends){
            [removeTrend MR_deleteEntity];
        }
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        [userinfo.friendtrendsSet removeAllObjects];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userinfo.userid forKey:@"userid"];
        [dic setObject:userinfo.usertoken forKey:@"usertoken"];
        [dic setObject:personalId forKey:@"friendid"];
        NSString *timeString = [CustomDate getDateString:[NSDate date]];
        [dic setObject:timeString forKey:@"time"];
        [RTTrendsRequest getFriendsTrendsListWith:dic success:^(id response) {
            NSLog(@"res %@", response);
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"获取他人动态成功");
                [trendsArray removeAllObjects];
                [trendsArray addObjectsFromArray:[userinfo.friendtrends allObjects]];
                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
                [trendsArray sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
                //NSLog(@"%@", trendsArray);
                if ([[response objectForKey:@"count"]  integerValue] != 10) {
                    showMore = YES;
                }
                else{
                    showMore = NO;
                }
            }
            else{
                NSLog(@"获取他人动态失败");
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
}

//带话题类型刷新
- (void)refreshTrendsWithType
{
    if ([userinfo.userid isEqualToString:personalId]) {
        for(Trends *removeTrend in userinfo.usertrends){
            [removeTrend MR_deleteEntity];
        }
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        [userinfo.usertrendsSet removeAllObjects];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userinfo.userid forKey:@"userid"];
        [dic setObject:userinfo.usertoken forKey:@"usertoken"];
        NSString *timeString = [CustomDate getDateString:[NSDate date]];
        [dic setObject:timeString forKey:@"time"];
        if (![RTUtil isEmpty:classifyString]) {
            [dic setObject:classifyString forKey:@"topic"];
        }
        [RTTrendsRequest getMyTrendsListWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"获取我的动态成功");
                [trendsArray removeAllObjects];
                [trendsArray addObjectsFromArray:[userinfo.usertrends allObjects]];
                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
                [trendsArray sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
                //NSLog(@"%@", trendsArray);
                if ([[response objectForKey:@"count"]  integerValue] != 10) {
                    showMore = YES;
                }
                else{
                    showMore = NO;
                }
            }
            else{
                NSLog(@"获取我的动态失败");
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
    else{
        for(Trends *removeTrend in userinfo.friendtrends){
            [removeTrend MR_deleteEntity];
        }
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        [userinfo.friendtrendsSet removeAllObjects];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userinfo.userid forKey:@"userid"];
        [dic setObject:userinfo.usertoken forKey:@"usertoken"];
        [dic setObject:personalId forKey:@"friendid"];
        NSString *timeString = [CustomDate getDateString:[NSDate date]];
        [dic setObject:timeString forKey:@"time"];
        if (![RTUtil isEmpty:classifyString]) {
            [dic setObject:classifyString forKey:@"topic"];
        }
        [RTTrendsRequest getFriendsTrendsListWith:dic success:^(id response) {
            NSLog(@"res %@", response);
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"获取他人动态成功");
                [trendsArray removeAllObjects];
                [trendsArray addObjectsFromArray:[userinfo.friendtrends allObjects]];
                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
                [trendsArray sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
                //NSLog(@"%@", trendsArray);
                if ([[response objectForKey:@"count"]  integerValue] != 10) {
                    showMore = YES;
                }
                else{
                    showMore = NO;
                }
            }
            else{
                NSLog(@"获取他人动态失败");
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
}


- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return trendsArray.count + 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell = @"TrendCell";
    static NSString *LastCell = @"LastCell";
    if (indexPath.row >= trendsArray.count) {
        RTLastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LastCell];
        if (cell == nil) {
            cell = [[RTLastTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LastCell];
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
                [self getTrends];
            }
        }
        return cell;
        
    }
    else{
        Trends *trend = [trendsArray objectAtIndex:indexPath.row];
        trendCell = [[RTTrendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell WithData:trend];
        trendCell.delegate = self;
        return trendCell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == trendsArray.count) {
        return 48;
    }
    else{
        Trends *trend = [trendsArray objectAtIndex:indexPath.row];
        trendCell = (RTTrendsTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [trendCell heightWith:trend];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == trendsArray.count) {
        
    }
    else{
        RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
        RTTrendDetailViewController *trendDetailView = [[RTTrendDetailViewController alloc] init];
        trendDetailView.delegate = self;
        trendDetailView.trend = [trendsArray objectAtIndex:indexPath.row];
        [appDelegate.rootNavigationController pushViewController:trendDetailView animated:YES];
    }
}

#pragma mark - RTTrendTableViewCellDelegate
- (void)clickDeleteButton
{
    [self refreshTrends];
}

- (void)clickTrendsClassfy:(NSString *)classify
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"#"];
    classifyString = [classify stringByTrimmingCharactersInSet:set];
    [self refreshTrendsWithType];
}
//点击头像
- (void)clickHeadImage:(NSString*)userid{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:userid];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
}
//点击昵称
- (void)clickNicknameButton:(NSString *)userid
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:userid];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
}

#pragma mark - 
- (void)clickLabel:(NSString *)labelString
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"#"];
    classifyString = [labelString stringByTrimmingCharactersInSet:set];
    [self refreshTrendsWithType];
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
    [self refreshTrends];
}
- (void)doneLoadingTableViewData
{
    _reloading=NO;
    [trendTableView reloadData];
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:trendTableView];
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

@end
