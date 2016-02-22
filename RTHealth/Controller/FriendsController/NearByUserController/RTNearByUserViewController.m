//
//  RTNearByUserViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/7.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTNearByUserViewController.h"
#import "RTFriendsTableViewCell.h"
#import "RTRealationshipTableViewCell.h"

@interface RTNearByUserViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
    UserInfo *userinfo;
    NSMutableArray *dataArray;
    CLLocationManager *locationManager;
    RTUserInfo *userData;
}

@end

@implementation RTNearByUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    userData = [RTUserInfo getInstance];
    userData.locationed = NO;
    userinfo = userData.userData;
    [userData addObserver:self forKeyPath:@"locationed" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.nearbyuser allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"frienddistance" ascending:YES];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"friendcreatetime" ascending:NO];
    [self.dataArray sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1,nil]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"附近的人";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    self.tableview.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.dataArray.count == 0) {
        [self.tableview setContentOffset:CGPointMake(0,-70) animated:YES];
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f){
            [locationManager requestAlwaysAuthorization];
        }
        locationManager.distanceFilter = 1000.0f;
        [locationManager startUpdatingLocation];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"定位" message:@"定位功能未打开" delegate:nil cancelButtonTitle:@"确定“"otherButtonTitles: nil];
        [alert show];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark - locationManager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations objectAtIndex:0];
    
    userData.latitude = location.coordinate.latitude;
    userData.longitude = location.coordinate.longitude;
    
    userData.locationed = YES;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"locationed"])
    {
        if (userData.locationed) {
            [self refreshTable];
        }
    }
}

- (void)refreshTable{
    if (!userData.locationed) {
        return;
    }
    
    for (FriendsInfo *removefriendInfo in userinfo.nearbyuser) {
        [removefriendInfo MR_deleteEntity];
    }
    [userinfo.nearbyuserSet removeAllObjects];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [self.dataArray removeAllObjects];
    
    [RTFriendRequest getNearBySuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray addObjectsFromArray:[userinfo.nearbyuser allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"frienddistance" ascending:YES];
            NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"friendcreatetime" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1,nil]];
            
            
        }
        if ([[response objectForKey:@"count"]integerValue] == NUMBER_CELL){
            self.showMore = NO;
        }else{
            self.showMore = YES;
        }
        [self doneLoadingTableViewData];
    }failure:^(NSError *error){
        
        [self doneLoadingTableViewData];
    }];
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc{
    [userData removeObserver:self forKeyPath:@"locationed"];
}
- (void)loadMoreData{
    self.loading = YES;
    [RTFriendRequest getNearBySuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            NSLog(@"刷新");
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[userinfo.nearbyuser allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"frienddistance" ascending:YES];
            NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"friendcreatetime" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1,nil]];
        }if ([[response objectForKey:@"count"] intValue] == 20) {
            self.showMore = NO;
        }else{
            self.showMore = YES;
        }
        [self doneLoadingTableViewData];
        self.loading = NO;
    }failure:^(NSError *error){
        [self doneLoadingTableViewData];
        self.loading = NO;
        self.showMore = YES;
    }];
}

- (void)didSelectAtIndexPath:(NSIndexPath*)indexPath{
    
    FriendsInfo *friendInfo = [self.dataArray objectAtIndex:indexPath.row];
    RTFriendInfoTableViewController *friendController = [[RTFriendInfoTableViewController alloc]init];
    friendController.friendInfo = friendInfo;
    [self.navigationController pushViewController:friendController animated:YES];
}


- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserIndentifier = @"Cell";
    FriendsInfo *friendInfo = [self.dataArray objectAtIndex:indexPath.row];
    RTRealationshipTableViewCell *cell = [[RTRealationshipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:friendInfo];
    cell.labelSort.text = [NSString stringWithFormat:@"距离:%@km",[RTUtil isEmpty:friendInfo.frienddistance]?@"0":friendInfo.frienddistance];
    return cell;
    
}
@end
