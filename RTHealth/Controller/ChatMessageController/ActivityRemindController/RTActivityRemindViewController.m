//
//  RTActivityRemindViewController.m
//  RTHealth
//
//  Created by cheng on 15/1/5.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTActivityRemindViewController.h"
#import "RTRemindTableViewCell.h"
#import "RTActivityDetailViewController.h"

@interface RTActivityRemindViewController ()<RTRemindTableViewCellDelegate>{
    UserInfo *userinfo;
}

@end

@implementation RTActivityRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.remind allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"remindtime" ascending:NO];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"remindid" ascending:NO];
    [self.dataArray sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1,nil]];
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"活动提醒";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
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
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshTable{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    for (Remind *removeRemind in userinfo.remind) {
        [removeRemind MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    [RTMessageRequest getRemindListSuccess:^(id response){
        self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.remind allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"remindtime" ascending:NO];
        NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"remindid" ascending:NO];
        [self.dataArray sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1,nil]];
        [self doneLoadingTableViewData];
    } failure:^(NSError *error){
        [self doneLoadingTableViewData];
    }];
}

- (void)loadMoreData{
    
    self.loading = YES;
    [RTMessageRequest getRemindListSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray removeAllObjects];
            self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.remind allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"remindtime" ascending:NO];
            NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"remindid" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1,nil]];
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


#pragma mark - UITableView Delegate DataSource


- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuserIndentifier = @"Cell";
    Remind *remind = [self.dataArray objectAtIndex:indexPath.row];
    
    RTRemindTableViewCell *cell = [[RTRemindTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:remind];
    cell.delegate = self;
    return cell;
}

- (void)didSelectAtIndexPath:(NSIndexPath*)indexPath{
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath{
    Remind *remind = [self.dataArray objectAtIndex:indexPath.row];
    static NSString *reuserIndentifier = @"Cell";
    RTRemindTableViewCell *cell = [[RTRemindTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:remind];
    return cell.getHeight;
}

#pragma mark - RTRemindTableViewCell Delegate

- (void)clickActivity:(NSString *)activityid{
    RTActivityDetailViewController *activityController = [[RTActivityDetailViewController alloc]initWithActivityId:activityid];
    [self.navigationController pushViewController:activityController animated:YES];
    
}

- (void)clickUser:(NSString *)userid{
    
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:userid];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
