//
//  RTPariseViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/11.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPariseViewController.h"
#import "RTPraiseTableViewCell.h"
#import "MLEmojiLabel.h"
#import "RTTrendDetailViewController.h"

@interface RTPariseViewController ()<UITableViewDataSource,UITableViewDelegate,RTPraiseTableViewCellDelegate>{
    UserInfo *userinfo;
}

@end

@implementation RTPariseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.praise allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"praisetime" ascending:NO];
    [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"喜欢我的";
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
}

- (void)refreshTable{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    for (Praise *removePraise in userinfo.praise) {
        [removePraise MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    [RTMessageRequest getFavoriteListSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray removeAllObjects];
            self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.praise allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"praisetime" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
            
            [self doneLoadingTableViewData];
        }
        if ([[response objectForKey:@"count"] intValue] == 20) {
            self.showMore = NO;
        }else{
            self.showMore = YES;
        }
    }failure:^(NSError *error){
    }];
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadMoreData{
    self.loading = YES;
    [RTMessageRequest getFavoriteListSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray removeAllObjects];
            self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.praise allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"praisetime" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        }
            if ([[response objectForKey:@"count"] intValue] == 20) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate DataSource


- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath
{
    
    Praise *reply = [self.dataArray objectAtIndex:indexPath.row];
    
    static NSString *reuserIndentifier = @"Cell";
    RTPraiseTableViewCell *cell = [[RTPraiseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:reply];
    cell.delegate = self;
    return cell;
}

- (void)didSelectAtIndexPath:(NSIndexPath*)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    Praise *reply = [self.dataArray objectAtIndex:indexPath.row];
    Trends *trend = [Trends MR_createEntity];
    trend.trendid = reply.trendid;
    trend.trendcontent = reply.trendcontent;
    trend.trendphoto = reply.trendphoto;
    trend.usernickname = reply.username;
    trend.useraddress = reply.trendaddress;
    trend.trendcommentnumber = reply.trendcommentnumber;
    trend.trendcontent = reply.trendcontent;
    trend.trendtime = reply.trendcreatetime;
    trend.trendclassify = reply.trendlabel;
    trend.trendfavoritenumber = reply.trendlike;
    trend.usersex = reply.trendsex;
    trend.userphoto = reply.trenduserhead;
    trend.userid = reply.trenduserid;
    trend.usertype = reply.trendusertype;
    if ([RTUtil isEmpty:trend.trendid]) {
        return;
    }
    RTTrendDetailViewController *trendDetailController = [[RTTrendDetailViewController alloc]init];
    trendDetailController.trend = trend;
    [self.navigationController pushViewController:trendDetailController animated:YES];
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
}

#pragma mark - RTPraiseTableviewCell Delegate


- (void)clickToUserInfo:(NSString *)userid{
    
    NSLog(@"userid %@",userid);
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:userid];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
