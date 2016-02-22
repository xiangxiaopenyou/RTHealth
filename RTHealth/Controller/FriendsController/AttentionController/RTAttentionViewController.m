//
//  RTAttentionViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/7.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTAttentionViewController.h"
#import "RTAttentionTableViewCell.h"

@interface RTAttentionViewController ()<UITableViewDataSource,UITableViewDelegate,RTAttentionTableViewCellDelegate>{
    UserInfo *userinfo;
}

@end

@implementation RTAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.attentionuser allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
    [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"我的关注";
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

    for (FriendsInfo *removefriendInfo in userinfo.attentionuser) {
        [removefriendInfo MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    [RTFriendRequest getAttentionSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[userinfo.attentionuser allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
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

- (void)loadMoreData{
    self.loading = YES;
    [RTFriendRequest getAttentionSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            NSLog(@"刷新");
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[userinfo.attentionuser allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
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
    RTAttentionTableViewCell *cell = [[RTAttentionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:friendInfo];
    cell.delegate = self;
    return cell;
    
}

#pragma mark RTAttentionTableViewCell Delegate

- (void)shouldReloadData{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[userinfo.attentionuser allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
    [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    [self.tableview reloadData];
}

@end
