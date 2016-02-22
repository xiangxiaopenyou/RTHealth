//
//  RTOwnActivityViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTOwnActivityViewController.h"
#import "RTUnderwayActivityTableViewCell.h"
#import "RTFinishedActivityTableViewCell.h"
#import "RTActivityViewController.h"
#import "RTActivityDetailViewController.h"
#import "RTActivtyRequest.h"

@interface RTOwnActivityViewController ()<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>{
    UserInfo *userInfo;
    NSMutableArray *arrayUnderwayActivity;
    NSMutableArray *arrayFinishededActivity;
    
    CLLocationManager *locationManager;
    
    BOOL showMore;
    BOOL isGetData;
    
    float latitude;
    float longitude;
}

@end

@implementation RTOwnActivityViewController

@synthesize activityTableView = _activityTableView;
@synthesize personalId;

- (id)initWithId:(NSString *)idString
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createActivitySuccess) name:CREATEACTIVITYSUCCESS object:nil];
    
    showMore = NO;
    isGetData = YES;
    _reloading = NO;
    
    RTUserInfo *userdata = [RTUserInfo getInstance];
    userInfo = userdata.userData;
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        locationManager.distanceFilter = 1000.0f;
        [locationManager startUpdatingLocation];
        
    }
    else{
        NSLog(@"请开启定位功能");
    }
    //[self refreshMyActivity];
    arrayFinishededActivity = [[NSMutableArray alloc] init];
    arrayUnderwayActivity = [[NSMutableArray alloc] init];
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    if ([userInfo.userid isEqualToString:personalId]) {
        titleLabel.text = @"我的活动";
        [arrayFinishededActivity addObjectsFromArray:[userInfo.finishedactivity allObjects]];
        [arrayUnderwayActivity addObjectsFromArray:[userInfo.underwayactivity allObjects]];
        NSSortDescriptor *sortFinished = [NSSortDescriptor sortDescriptorWithKey:@"activityendtime" ascending:NO];
        NSSortDescriptor *sortUnderway = [NSSortDescriptor sortDescriptorWithKey:@"activitybegintime" ascending:YES];
        [arrayFinishededActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortFinished, nil]];
        [arrayUnderwayActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortUnderway, nil]];
    }
    else{
        titleLabel.text = @"TA的活动";
        [arrayFinishededActivity addObjectsFromArray:[userInfo.friendfinishedactivity allObjects]];
        [arrayUnderwayActivity addObjectsFromArray:[userInfo.friendunderwayactivity allObjects]];
        NSSortDescriptor *sortFinished = [NSSortDescriptor sortDescriptorWithKey:@"activityendtime" ascending:NO];
        NSSortDescriptor *sortUnderway = [NSSortDescriptor sortDescriptorWithKey:@"activitybegintime" ascending:YES];
        [arrayFinishededActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortFinished, nil]];
        [arrayUnderwayActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortUnderway, nil]];
    }
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    _activityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
    _activityTableView.delegate = self;
    _activityTableView.dataSource = self;
    _activityTableView.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    _activityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _activityTableView.showsVerticalScrollIndicator = NO;
    //_activityTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_activityTableView];
    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - _activityTableView.bounds.size.height, _activityTableView.frame.size.width, _activityTableView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        _refreshHeaderView.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
        [_activityTableView addSubview:_refreshHeaderView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations objectAtIndex:0];
    
    latitude = location.coordinate.latitude;
    longitude = location.coordinate.longitude;
    [self refreshMyActivity];
}

- (void)createActivitySuccess
{
    [self refreshMyActivity];
}

- (void)getMyActivity
{
    if ([userInfo.userid isEqualToString:personalId]) {
        [userInfo.underwayactivitySet removeAllObjects];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userInfo.userid forKey:@"userid"];
        [dic setObject:userInfo.usertoken forKey:@"usertoken"];
        [dic setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"positionX"];
        [dic setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"positionY"];
        if(userInfo.finishedactivity.count == 0){
            NSDate *nowDate = [NSDate date];
            NSString *time = [CustomDate getDateString:nowDate];
            [dic setObject:time forKey:@"time"];
        }
        else{
            Activity *activity = [arrayFinishededActivity lastObject];
            [dic setObject:activity.activityendtime forKey:@"time"];
        }
        [RTActivtyRequest getMyActivityWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"获取成功");
                [arrayFinishededActivity removeAllObjects];
                [arrayUnderwayActivity removeAllObjects];
                //NSLog(@"userinfo %lu",(unsigned long)userInfo.underwayactivity.count);
                [arrayFinishededActivity addObjectsFromArray:[userInfo.finishedactivity allObjects]];
                [arrayUnderwayActivity addObjectsFromArray:[userInfo.underwayactivity allObjects]];
                NSSortDescriptor *sortFinished = [NSSortDescriptor sortDescriptorWithKey:@"activityendtime" ascending:NO];
                NSSortDescriptor *sortUnderway = [NSSortDescriptor sortDescriptorWithKey:@"activitybegintime" ascending:YES];
                [arrayFinishededActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortFinished, nil]];
                [arrayUnderwayActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortUnderway, nil]];
                [_activityTableView reloadData];
                if ([[[[response objectForKey:@"data"] objectForKey:@"complete"] objectForKey:@"count"] integerValue] != 10) {
                    showMore = YES;
                }
            }
            else{
                NSLog(@"获取失败");
                showMore = YES;
            }
            //[_activityTableView reloadData];
            [self doneLoadingTableViewData];
            isGetData = NO;
        } failure:^(NSError *error) {
            NSLog(@"失败");
            showMore = YES;
            //[_activityTableView reloadData];
            [self doneLoadingTableViewData];
            isGetData = NO;
            
        }];

    }
    else{
        [userInfo.friendunderwayactivitySet removeAllObjects];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userInfo.userid forKey:@"userid"];
        [dic setObject:userInfo.usertoken forKey:@"usertoken"];
        [dic setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"positionX"];
        [dic setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"positionY"];
        [dic setObject:personalId forKey:@"friendid"];
        if(userInfo.finishedactivity.count == 0){
            NSDate *nowDate = [NSDate date];
            NSString *time = [CustomDate getDateString:nowDate];
            [dic setObject:time forKey:@"time"];
        }
        else{
            Activity *activity = [arrayFinishededActivity lastObject];
            [dic setObject:activity.activityendtime forKey:@"time"];
        }
        [RTActivtyRequest getFriendActivityWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"获取成功");
                [arrayFinishededActivity removeAllObjects];
                [arrayUnderwayActivity removeAllObjects];
                //NSLog(@"userinfo %lu",(unsigned long)userInfo.underwayactivity.count);
                [arrayFinishededActivity addObjectsFromArray:[userInfo.friendfinishedactivity allObjects]];
                [arrayUnderwayActivity addObjectsFromArray:[userInfo.friendunderwayactivity allObjects]];
                NSSortDescriptor *sortFinished = [NSSortDescriptor sortDescriptorWithKey:@"activityendtime" ascending:NO];
                NSSortDescriptor *sortUnderway = [NSSortDescriptor sortDescriptorWithKey:@"activitybegintime" ascending:YES];
                [arrayFinishededActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortFinished, nil]];
                [arrayUnderwayActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortUnderway, nil]];
                [_activityTableView reloadData];
                if ([[[[response objectForKey:@"data"] objectForKey:@"complete"] objectForKey:@"count"] integerValue] != 10) {
                    showMore = YES;
                }
            }
            else{
                NSLog(@"获取失败");
                showMore = YES;
            }
            //[_activityTableView reloadData];
            [self doneLoadingTableViewData];
            isGetData = NO;
        } failure:^(NSError *error) {
            NSLog(@"失败");
            showMore = YES;
            //[_activityTableView reloadData];
            [self doneLoadingTableViewData];
            isGetData = NO;
            
        }];

    }
}

- (void)refreshMyActivity
{
    if ([userInfo.userid isEqualToString:personalId]) {
        for(Activity *removeFinishedActivity in userInfo.finishedactivity){
            [removeFinishedActivity MR_deleteEntity];
        }
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        [userInfo.finishedactivitySet removeAllObjects];
        for (Activity *removeUnderwayActivity in userInfo.underwayactivity) {
            [removeUnderwayActivity MR_deleteEntity];
        }
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        [userInfo.underwayactivitySet removeAllObjects];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userInfo.userid forKey:@"userid"];
        [dic setObject:userInfo.usertoken forKey:@"usertoken"];
        [dic setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"positionX"];
        [dic setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"positionY"];
//        if(userInfo.finishedactivity.count == 0){
        NSDate *nowDate = [NSDate date];
        NSString *time = [CustomDate getDateString:nowDate];
        [dic setObject:time forKey:@"time"];
//        }
//        else{
//            Activity *activity = [arrayFinishededActivity lastObject];
//            [dic setObject:activity.activityendtime forKey:@"time"];
//        }
//        NSLog(@"dic %@", dic);
        [RTActivtyRequest getMyActivityWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"获取成功");
                [arrayFinishededActivity removeAllObjects];
                [arrayUnderwayActivity removeAllObjects];
                [arrayFinishededActivity addObjectsFromArray:[userInfo.finishedactivity allObjects]];
                [arrayUnderwayActivity addObjectsFromArray:[userInfo.underwayactivity allObjects]];
                //NSLog(@"finished %@", arrayFinishededActivity);
                NSSortDescriptor *sortFinished = [NSSortDescriptor sortDescriptorWithKey:@"activityendtime" ascending:NO];
                NSSortDescriptor *sortUnderway = [NSSortDescriptor sortDescriptorWithKey:@"activitybegintime" ascending:YES];
                [arrayFinishededActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortFinished, nil]];
                [arrayUnderwayActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortUnderway, nil]];
                
                [_activityTableView reloadData];
                if ([[[[response objectForKey:@"data"] objectForKey:@"complete"] objectForKey:@"count"] integerValue] != 10) {
                    showMore = YES;
                }
                else{
                    showMore = NO;
                }
                
            }
            else{
                NSLog(@"获取失败");
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
    else{
        for(Activity *removeFinishedActivity in userInfo.friendfinishedactivity){
            [removeFinishedActivity MR_deleteEntity];
        }
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        [userInfo.friendfinishedactivitySet removeAllObjects];
        for (Activity *removeUnderwayActivity in userInfo.friendunderwayactivity) {
            [removeUnderwayActivity MR_deleteEntity];
        }
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        [userInfo.friendunderwayactivitySet removeAllObjects];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userInfo.userid forKey:@"userid"];
        [dic setObject:userInfo.usertoken forKey:@"usertoken"];
        [dic setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"positionX"];
        [dic setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"positionY"];
        [dic setObject:personalId forKey:@"friendid"];
//        if(userInfo.finishedactivity.count == 0){
        NSDate *nowDate = [NSDate date];
        NSString *time = [CustomDate getDateString:nowDate];
        [dic setObject:time forKey:@"time"];
//        }
//        else{
//            Activity *activity = [arrayFinishededActivity lastObject];
//            [dic setObject:activity.activityendtime forKey:@"time"];
//        }
        NSLog(@"dic %@", dic);
        [RTActivtyRequest getFriendActivityWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"获取成功");
                [arrayFinishededActivity removeAllObjects];
                [arrayUnderwayActivity removeAllObjects];
                [arrayFinishededActivity addObjectsFromArray:[userInfo.friendfinishedactivity allObjects]];
                [arrayUnderwayActivity addObjectsFromArray:[userInfo.friendunderwayactivity allObjects]];
                NSSortDescriptor *sortFinished = [NSSortDescriptor sortDescriptorWithKey:@"activityendtime" ascending:NO];
                NSSortDescriptor *sortUnderway = [NSSortDescriptor sortDescriptorWithKey:@"activitybegintime" ascending:YES];
                [arrayFinishededActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortFinished, nil]];
                [arrayUnderwayActivity sortUsingDescriptors:[NSArray arrayWithObjects:sortUnderway, nil]];
                
                [_activityTableView reloadData];
                if ([[[[response objectForKey:@"data"] objectForKey:@"complete"] objectForKey:@"count"] integerValue] != 10) {
                    showMore = YES;
                }
                else{
                    showMore = NO;
                }
                
            }
            else{
                NSLog(@"获取失败");
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return arrayUnderwayActivity.count;
    }
    else{
        return arrayFinishededActivity.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *LastCell = @"RTLastTableViewCell";
    if (indexPath.section == 0) {
        Activity *activity = [arrayUnderwayActivity objectAtIndex:indexPath.row];
        RTUnderwayActivityTableViewCell *cell = [[RTUnderwayActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withData:activity];
        return cell;
    }
    else{
        if (indexPath.row >= arrayFinishededActivity.count) {
            RTLastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LastCell];
            if (cell == nil) {
                cell = [[RTLastTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LastCell];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
            cell.label.text = @"";
            if (arrayFinishededActivity.count != 0) {
                if (showMore) {
                    cell.label.text = @"没有更多活动了";
                    [cell.indicatorView stopAnimating];
                }
                else{
                    cell.label.text = @"加载中...";
                    [cell.indicatorView startAnimating];
                    if (!isGetData) {
                        [self getMyActivity];
                    }
                }
            }
            
            return cell;
            
        }
        Activity *activity = [arrayFinishededActivity objectAtIndex:indexPath.row];
        RTFinishedActivityTableViewCell *cell = [[RTFinishedActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withData:activity];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 16, 100, 17)];
    sectionLabel.font = SMALLFONT_14;
    sectionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    if (section == 0) {
        sectionLabel.text = @"进行中的活动";
        [header addSubview:sectionLabel];
        if ([userInfo.userid isEqualToString:personalId]) {
            UIButton *addActivityButton = [UIButton buttonWithType:UIButtonTypeCustom];
            addActivityButton.frame = CGRectMake(SCREEN_WIDTH - 70, 10, 60, 22);
            [addActivityButton addTarget:self action:@selector(addActivityClick) forControlEvents:UIControlEventTouchUpInside];
            [addActivityButton setImage:[UIImage imageNamed:@"create_activity.png"] forState:UIControlStateNormal];
            [header addSubview:addActivityButton];
            
            if (arrayUnderwayActivity.count == 0) {
                UIImageView *activityImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 45, SCREEN_WIDTH - 24, 94)];
                activityImage.backgroundColor = [UIColor whiteColor];
                [header addSubview:activityImage];
                UILabel *activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 45, SCREEN_WIDTH - 64, 94)];
                activityLabel.text = @"一个活动都没有，你是宅女还是腐男啊(￣▽￣)~";
                activityLabel.textColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
                activityLabel.font = SMALLFONT_14;
                activityLabel.backgroundColor = [UIColor whiteColor];
                activityLabel.numberOfLines = 2;
                //activityLabel.textAlignment = NSTextAlignmentCenter;
                [header addSubview:activityLabel];
            }
        }
        else{
            if (arrayUnderwayActivity.count == 0) {
                UIImageView *activityImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 45, SCREEN_WIDTH - 24, 94)];
                activityImage.backgroundColor = [UIColor whiteColor];
                [header addSubview:activityImage];
                UILabel *activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 45, SCREEN_WIDTH - 64, 94)];
                activityLabel.text = @"远离腐宅，健康生活，给你朋友推荐个活动吧(￣▽￣)~";
                activityLabel.textColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
                activityLabel.font = SMALLFONT_14;
                activityLabel.backgroundColor = [UIColor whiteColor];
                activityLabel.numberOfLines = 2;
                //activityLabel.textAlignment = NSTextAlignmentCenter;
                [header addSubview:activityLabel];
            }
        }
        
        
    }
    else{
        sectionLabel.text = @"已结束的活动";
        [header addSubview:sectionLabel];
        if (arrayFinishededActivity.count == 0) {
            UIImageView *activityImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 45, SCREEN_WIDTH - 24, 94)];
            activityImage.backgroundColor = [UIColor whiteColor];
            [header addSubview:activityImage];
            UILabel *activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 45, SCREEN_WIDTH - 64, 94)];
            activityLabel.text = @"嘿咻~嘿咻~嘿咻~什么活动这么久，到现在还没结束(⊙＿⊙)";
            activityLabel.textColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
            activityLabel.font = SMALLFONT_14;
            activityLabel.backgroundColor = [UIColor whiteColor];
            activityLabel.numberOfLines = 2;
            //activityLabel.textAlignment = NSTextAlignmentCenter;
            [header addSubview:activityLabel];
        }
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (arrayUnderwayActivity.count == 0) {
            return 145;
        }
        else{
            return 45;
        }
    }
    else{
    
        if (arrayFinishededActivity.count == 0) {
            return 145;
        }
        else{
            return 45;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RTUnderwayActivityTableViewCell *cell = (RTUnderwayActivityTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return 47 + cell.contentLabel.frame.size.height;
    }
    else{
        return 32;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (indexPath.section == 0) {
        Activity *act = [arrayUnderwayActivity objectAtIndex:indexPath.row];
        RTActivityDetailViewController *activityDetailView = [[RTActivityDetailViewController alloc]initWithActivityId:act.activityid];
        [appDelegate.rootNavigationController pushViewController:activityDetailView animated:YES];
    }
    else{
        if (indexPath.row < arrayFinishededActivity.count) {
            Activity *act = [arrayFinishededActivity objectAtIndex:indexPath.row];
            RTActivityDetailViewController *activityDetailView = [[RTActivityDetailViewController alloc]initWithActivityId:act.activityid];
            [appDelegate.rootNavigationController pushViewController:activityDetailView animated:YES];
        }
        
    }
    //activityDetailView.isJoin = @"0";
}

- (void)addActivityClick
{
    RTActivityViewController *addActivityView = [[RTActivityViewController alloc] init];
    [self.navigationController pushViewController:addActivityView animated:YES];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate
- (void)reloadTableDataSource
{
    _reloading = YES;
    [self refreshMyActivity];
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_activityTableView reloadData];
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_activityTableView];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableDataSource];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

@end
