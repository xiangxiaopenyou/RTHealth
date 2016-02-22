//
//  RTFriendAttionViewController.m
//  RTHealth
//
//  Created by cheng on 14/12/5.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFriendAttionViewController.h"
#import "RTFriendsTableViewCell.h"
#import "RTFriendDetailRequest.h"

@interface RTFriendAttionViewController ()<UITableViewDataSource,UITableViewDelegate>{
}

@end

@implementation RTFriendAttionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [[NSMutableArray alloc]initWithArray:[self.friendInfo.friendattentionSet allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
    [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"TA的关注";
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
    for (FriendsInfo *removeFriendInfo in self.friendInfo.friendattention) {
        [removeFriendInfo MR_deleteEntity];
    }
    [self.friendInfo.friendattentionSet removeAllObjects];
    
    [RTFriendDetailRequest friendAttentionWith:self.friendInfo success:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[self.friendInfo.friendattentionSet allObjects]];
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
    [RTFriendDetailRequest friendAttentionWith:self.friendInfo success:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            NSLog(@"刷新");
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[self.friendInfo.friendattentionSet allObjects]];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendsInfo *friendInfo = [self.dataArray objectAtIndex:indexPath.row];
    RTFriendInfoTableViewController *friendController = [[RTFriendInfoTableViewController alloc]init];
    friendController.friendInfo = friendInfo;
    [self.navigationController pushViewController:friendController animated:YES];
}


- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserIndentifier = @"Cell";
    FriendsInfo *friendInfo = [self.dataArray objectAtIndex:indexPath.row];
    RTFriendsTableViewCell *cell = [[RTFriendsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:friendInfo];
    return cell;
    
}
@end
