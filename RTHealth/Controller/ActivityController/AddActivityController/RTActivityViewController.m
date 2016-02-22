//
//  RTActivityViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTActivityViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "RTActivityTableViewCell.h"
#import "RTOrganizeActivityViewController.h"
#import "RTActivtyRequest.h"
#import "RTActivityDetailViewController.h"
@interface RTActivityViewController ()<UITableViewDataSource,UITableViewDelegate, CLLocationManagerDelegate>
{
    UIView *viewPage;
    UITableView *tableViewTime;
    UITableView *tableViewDistance;
    NSInteger currentIndex;
    BOOL showMoreTime;
    BOOL isGetData;
    UserInfo *userInfo;
    NSMutableArray *arrayOfTime;
    NSMutableArray *arrayOfDistance;
    CLLocationManager *locationManager;
    
    float latitude;
    float longitude;
}
@end

@implementation RTActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    RTUserInfo *userData = [RTUserInfo getInstance];
    userInfo = userData.userData;
    _isloading_time = NO;
    _reloading_time = NO;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0]];
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        locationManager.distanceFilter = 1000.0f;
        [locationManager startUpdatingLocation];
        
    }
    else{
        NSLog(@"xiang");
        NSLog(@"请开启定位功能");
        [JDStatusBarNotification showWithStatus:@"定位服务未开启哦~" dismissAfter:1.4f];
        [self refreshActivityWithDistance];
    }
    
    arrayOfTime = [[NSMutableArray alloc] initWithArray:[userInfo.addactivitytime allObjects]];
    arrayOfDistance = [[NSMutableArray alloc] initWithArray:[userInfo.addactivitydistance allObjects]];
    NSSortDescriptor *sortTime = [NSSortDescriptor sortDescriptorWithKey:@"activitybegintime" ascending:YES];
    [arrayOfTime sortUsingDescriptors:[NSArray arrayWithObjects:sortTime, nil]];
    NSSortDescriptor *sortDistance = [NSSortDescriptor sortDescriptorWithKey:@"activitydistance" ascending:YES];
    [arrayOfDistance sortUsingDescriptors:[NSArray arrayWithObjects:sortDistance, nil]];
    currentIndex = 0;
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIButton *organizeActivityButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 35, 60, 20) text:@"组织" icon:@"icon-plus" textAttributes:nil andIconPosition:IconPositionLeft];
    [organizeActivityButton setTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName, [UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0], NSForegroundColorAttributeName, nil] forUIControlState:UIControlStateNormal];
    [organizeActivityButton addTarget:self action:@selector(organizeActivityClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:organizeActivityButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"推荐活动";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    //添加segment
    [self setupSegment];
    
    //两个tableview
    tableViewDistance = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50)];
    tableViewDistance.tag = 10;
    tableViewDistance.delegate = self;
    tableViewDistance.dataSource = self;
    tableViewDistance.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    [tableViewDistance setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [viewPage addSubview:tableViewDistance];
    if (_refreshHeaderView_distance == nil) {
        _refreshHeaderView_distance = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - tableViewDistance.bounds.size.height, tableViewDistance.frame.size.width, tableViewDistance.bounds.size.height)];
        _refreshHeaderView_distance.delegate = self;
        _refreshHeaderView_distance.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
        [tableViewDistance addSubview:_refreshHeaderView_distance];
    }
    [_refreshHeaderView_distance refreshLastUpdatedDate];
    
    tableViewTime = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50)];
    tableViewTime.tag = 11;
    tableViewTime.delegate = self;
    tableViewTime.dataSource = self;
    tableViewTime.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    [tableViewTime setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [viewPage addSubview:tableViewTime];
  
    if (_refreshHeaderView_time == nil) {
        _refreshHeaderView_time = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - tableViewTime.bounds.size.height, tableViewTime.frame.size.width, tableViewTime.bounds.size.height)];
        _refreshHeaderView_time.delegate = self;
        _refreshHeaderView_time.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
        [tableViewTime addSubview:_refreshHeaderView_time];
    }
    [_refreshHeaderView_time refreshLastUpdatedDate];


}

- (void)setupSegment
{
    PPiFlatSegmentedControl *segmented2=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-250)/2, NAVIGATIONBAR_HEIGHT+10, 250, 30)
                                                                                 items:[NSArray arrayWithObjects:
                                                                                        [NSDictionary dictionaryWithObjectsAndKeys:@"距离",@"text",@"icon-map-marker",@"icon", nil],
                                                                                        [NSDictionary dictionaryWithObjectsAndKeys:@"时间",@"text",@"icon-time",@"icon", nil] ,nil]
                                                                          iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                              
                                                                              switch (segmentIndex) {
                                                                                  case 0:{
                                                                                      currentIndex = 0;
                                                                                      [UIView animateWithDuration:0.2 animations:^(void){
                                                                                          viewPage.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50);
                                                                                      }completion:^(BOOL finished){
                                                                                          viewPage.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50);
                                                                                      }];
                                                                                  }break;
                                                                                  case 1:{
                                                                                      currentIndex = 1;
                                                                                      [UIView animateWithDuration:0.2 animations:^(void){
                                                                                          viewPage.frame = CGRectMake(-SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50);
                                                                                      }completion:^(BOOL finished){
                                                                                          viewPage.frame = CGRectMake(-SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50);
                                                                                      }];
                                                                                  }break;
                                                                                  default:
                                                                                      break;
                                                                              }
                                                                              
                                                                          }];
    segmented2.color = [UIColor whiteColor];
    segmented2.borderWidth = 0.5;
    segmented2.borderColor = [UIColor colorWithRed:33.0f/255.0 green:138.0f/255.0 blue:246.0f/255.0 alpha:1];
    segmented2.selectedColor = [UIColor colorWithRed:33.0f/255.0 green:138.0f/255.0 blue:246.0f/255.0 alpha:1];
    segmented2.textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil];
    segmented2.selectedTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.view addSubview:segmented2];
    
    viewPage = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50)];
    [self.view addSubview:viewPage];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations objectAtIndex:0];
    
    latitude = location.coordinate.latitude;
    longitude = location.coordinate.longitude;
    [self refreshActivityWithDistance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)getActivityWithDistance
//{
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:userInfo.userid forKey:@"userid"];
//}
- (void)refreshActivityWithDistance
{
    for(Activity *removeActivity in userInfo.addactivitydistance){
        [removeActivity MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [userInfo.addactivitydistanceSet removeAllObjects];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userInfo.userid forKey:@"userid"];
    [dic setObject:userInfo.usertoken forKey:@"usertoken"];
    [dic setObject:@"500" forKey:@"distance"];
    if (![RTUtil isBlankString:[NSString stringWithFormat:@"%f", latitude]]) {
        [dic setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"positionX"];
        [dic setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"positionY"];
    }
    else{
        [dic setObject:@"0" forKey:@"positionX"];
        [dic setObject:@"0" forKey:@"positionY"];
    }
    NSLog(@"dic %@", dic);
    [RTActivtyRequest getActivityWithDistance:dic success:^(id response) {
        if ([[response objectForKey:@"state"]  integerValue] == 1000) {
            NSLog(@"获取距离列表成功");
            [arrayOfDistance removeAllObjects];
            [arrayOfDistance addObjectsFromArray:[userInfo.addactivitydistance allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"activitydistance" ascending:YES];
            [arrayOfDistance sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
            [tableViewDistance reloadData];
            
        }
        else{
            NSLog(@"失败");
        }
        [self doneLoadingTableViewData];
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
}

- (void)refreshActivityWithTime
{
    for(Activity *removeActivity in userInfo.addactivitytime){
        [removeActivity MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [userInfo.addactivitytimeSet removeAllObjects];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userInfo.userid forKey:@"userid"];
    [dic setObject:userInfo.usertoken forKey:@"usertoken"];
    [dic setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"positionX"];
    [dic setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"positionY"];
    if(userInfo.addactivitytime.count == 0){
        [dic setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }
    else
    {
        Activity *activity = [arrayOfTime lastObject];
        [dic setObject:activity.activitybegintime forKey:@"time"];
    }
    NSLog(@"dic %@", dic);
    [RTActivtyRequest getActivityWtihTime:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"获取活动列表成功");
            [arrayOfTime removeAllObjects];
            [arrayOfTime addObjectsFromArray:[userInfo.addactivitytime allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"activitybegintime" ascending:YES];
            [arrayOfTime sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
            [tableViewTime reloadData];
        }
        else{
            NSLog(@"获取活动列表失败");
        }
        [self doneLoadingTableViewData];
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)organizeActivityClick
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
    RTOrganizeActivityViewController *organizeActivityView = [[RTOrganizeActivityViewController alloc] init];
    [appDelegate.rootNavigationController pushViewController:organizeActivityView animated:YES];
}

#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTActivityTableViewCell *cell = (RTActivityTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 47 + cell.contentLabel.frame.size.height;
//    return  44;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    Activity *activity;
    if (tableView.tag == 10) {
        activity = [arrayOfDistance objectAtIndex:indexPath.row];
    }
    else{
        activity = [arrayOfTime objectAtIndex:indexPath.row];
    }
    
    RTActivityTableViewCell *cell = [[RTActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withData:activity];
    if (tableView.tag == 10) {
        cell.distanceLabel.textColor = [UIColor colorWithRed:83/255.0 green:161/255.0 blue:49/255.0 alpha:1.0];
    }
    else{
        cell.timeLabel.textColor = [UIColor colorWithRed:83/255.0 green:161/255.0 blue:49/255.0 alpha:1.0];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10) {
        return  arrayOfDistance.count;
    }
    else{
        return arrayOfTime.count;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    if (tableView.tag == 10) {
        Activity *act = [arrayOfDistance objectAtIndex:indexPath.row];
        RTActivityDetailViewController *detailView = [[RTActivityDetailViewController alloc]initWithActivityId:act.activityid];
        [appDelegate.rootNavigationController pushViewController:detailView animated:YES];
    }
    else{
        Activity *act = [arrayOfTime objectAtIndex:indexPath.row];
        RTActivityDetailViewController *detailView = [[RTActivityDetailViewController alloc]initWithActivityId:act.activityid];
        [appDelegate.rootNavigationController pushViewController:detailView animated:YES];
    }
    
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (currentIndex == 0) {
        
        [_refreshHeaderView_distance egoRefreshScrollViewDidScroll:scrollView];
    }else{
        [_refreshHeaderView_time egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (currentIndex == 0) {
        [_refreshHeaderView_distance egoRefreshScrollViewDidEndDragging:scrollView];
    }else{
        [_refreshHeaderView_time egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (currentIndex == 0) {
        [_refreshHeaderView_distance egoRefreshScrollViewDidEndDragging:scrollView];
    }else{
        [_refreshHeaderView_time egoRefreshScrollViewDidEndDragging:scrollView];
    }
}
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)reloadTableViewDataSource{
    if (currentIndex == 0) {
        _reloading_distance = YES;
        [self refreshActivityWithDistance];
    }else{
        _reloading_time = YES;
        [self refreshActivityWithTime];
    }
}

- (void)doneLoadingTableViewData{
    if (currentIndex == 0) {
        _reloading_distance = NO;
        [tableViewDistance reloadData];
        [_refreshHeaderView_distance egoRefreshScrollViewDataSourceDidFinishedLoading:tableViewDistance];
    }else{
        _reloading_time = NO;
        [tableViewTime reloadData];
        [_refreshHeaderView_time egoRefreshScrollViewDataSourceDidFinishedLoading:tableViewTime];
    }
    
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    if (currentIndex == 0) {
        return _reloading_distance;
        
    }else{
        return _reloading_time; // should return if data source model is reloading
    }
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}


@end
