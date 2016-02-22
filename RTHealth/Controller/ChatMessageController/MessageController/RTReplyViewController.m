//
//  RTReplyViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTReplyViewController.h"
#import "RTReplyTableViewCell.h"
#import "MLEmojiLabel.h"
#import "RTTrendReplyViewController.h"
#import "RTTrendDetailViewController.h"

@interface RTReplyViewController ()<UITableViewDataSource,UITableViewDelegate,RTReplyTableViewCellDelegate>{
    UserInfo *userinfo;
}

@end

@implementation RTReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.reply allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"replytime" ascending:NO];
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
    titleLabel.text = @"消息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    self.tableview.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;

}
- (void)refreshTable{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    for (Reply *removeReply in userinfo.reply) {
        [removeReply MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    [RTMessageRequest getReplyListSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray removeAllObjects];
            self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.reply allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"replytime" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
            
            [self doneLoadingTableViewData];
        }
        if (![RTUtil isEmpty:[response objectForKey:@"reply"]]) {
            NSDictionary *tempDictionary = [response objectForKey:@"reply"];
            if ([[tempDictionary objectForKey:@"count"] intValue] == 20) {
                self.showMore = NO;
            }else{
                self.showMore = YES;
            }
        }else{
            self.showMore = YES;
        }
        
        [self doneLoadingTableViewData];
    }failure:^(NSError *error){
        
        [self doneLoadingTableViewData];
    }];
}
- (void)loadMoreData{
    self.loading = YES;
    [RTMessageRequest getReplyListSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray removeAllObjects];
            self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.reply allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"replytime" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        }
        if ([RTUtil isEmpty:[response objectForKey:@"reply"]]) {
            NSDictionary *tempDictionary = [response objectForKey:@"reply"];
            if ([[tempDictionary objectForKey:@"count"] intValue] == 20) {
                self.showMore = NO;
            }else{
                self.showMore = YES;
            }
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

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark - UITableView Delegate DataSource

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *reuserIndentifier = @"Cell";
//    Reply *reply = [self.dataArray objectAtIndex:indexPath.row];
//    
//    RTReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIndentifier];
//    if (cell == nil) {
//        cell = [[RTReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:reply];
//    }
//    return cell;
//}

- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuserIndentifier = @"Cell";
    Reply *reply = [self.dataArray objectAtIndex:indexPath.row];
    
    RTReplyTableViewCell *cell = [[RTReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:reply];
    cell.delegate = self;
    return cell;
}

- (void)didSelectAtIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"clickcell");
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    Reply *reply = [self.dataArray objectAtIndex:indexPath.row];
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
    
    static NSString *reuserIndentifier = @"Cell";
    Reply *reply = [self.dataArray objectAtIndex:indexPath.row];
    RTReplyTableViewCell *cell = [[RTReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:reply];
    return cell.frame.size.height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *reuserIndentifier = @"Cell";
//    Reply *reply = [self.dataArray objectAtIndex:indexPath.row];
//    RTReplyTableViewCell *cell = [[RTReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:reply];
//    return cell.frame.size.height;
//}

#pragma mark - RTReplyTableViewCell Delegate

- (void)pushToUserInfo:(NSString *)userid{
    NSLog(@"userid %@",userid);
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:userid];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pushToAddReply:(Reply *)reply{
    if ([RTUtil isEmpty:reply]) {
        return;
    }
    RTTrendReplyViewController *controller = [[RTTrendReplyViewController alloc]init];
    controller.trendID = reply.trendid;
    controller.commentID = reply.replyid;
    controller.commentUserID = reply.replyuserid;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
