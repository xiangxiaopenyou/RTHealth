//
//  RTPopularViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/7.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPopularViewController.h"
#import "RTRealationshipTableViewCell.h"

@interface RTPopularViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UserInfo *userinfo;
}


@end

@implementation RTPopularViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.popularityuser allObjects]];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"friendcreatetime" ascending:NO];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendfansnumber" ascending:NO];
    [self.dataArray sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1, nil]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"人气";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    self.tableview.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.dataArray.count == 0) {
        [self.tableview setContentOffset:CGPointMake(0,-70) animated:YES];
    }
}
- (void)refreshTable{
    
    for (FriendsInfo *removefriendInfo in userinfo.popularityuser) {
        [removefriendInfo MR_deleteEntity];
    }
    [userinfo.popularityuserSet removeAllObjects];
    
    [RTFriendRequest getPopularSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[userinfo.popularityuser allObjects]];
            NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"friendcreatetime" ascending:NO];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendfansnumber" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1, nil]];
        }
        if (![RTUtil isEmpty:[response objectForKey:@"count"]]&&[[response objectForKey:@"count"]integerValue] == NUMBER_CELL){
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

- (void)loadMoreData{
    self.loading = YES;
    [RTFriendRequest getPopularSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            NSLog(@"刷新");
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[userinfo.popularityuser allObjects]];
            NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"friendcreatetime" ascending:NO];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendfansnumber" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1, nil]];
        }if ([[response objectForKey:@"count"] intValue] == NUMBER_CELL) {
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
    cell.labelSort.text = [NSString stringWithFormat:@"人气:%@",[RTUtil isEmpty:friendInfo.friendfansnumber]?@"0":friendInfo.friendfansnumber];
    return cell;
    
}
@end
