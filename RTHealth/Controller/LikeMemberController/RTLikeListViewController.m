//
//  RTLikeListViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/12/9.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTLikeListViewController.h"
#import "RTTrendsRequest.h"
#import "RTLikeAndForwardTableViewCell.h"

@interface RTLikeListViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *likeListTableView;
    UserInfo *userinfo;
    NSArray *likeMemberArray;
}

@end

@implementation RTLikeListViewController

@synthesize trendID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0]];
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"点赞的人";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    likeListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
    likeListTableView.delegate = self;
    likeListTableView.dataSource = self;
    likeListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    likeListTableView.sectionIndexColor = [UIColor clearColor];
    likeListTableView.backgroundColor = [UIColor clearColor];
    likeListTableView.backgroundView = nil;
    likeListTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:likeListTableView];
    
    [self getLikeList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getLikeList
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:userinfo.userid, @"userid", userinfo.usertoken, @"usertoken", trendID, @"trendid", nil];
    [RTTrendsRequest getLikeListWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"获取成功");
            likeMemberArray = [response objectForKey:@"data"];
            NSLog(@"xianglinping");
            [likeListTableView reloadData];
            
        }
        else{
            
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息");
    }];
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return likeMemberArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [likeMemberArray objectAtIndex:indexPath.row];
    static NSString *likeCell = @"LikeCell";
    RTLikeAndForwardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:likeCell];
    if (cell == nil) {
        cell = [[RTLikeAndForwardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:likeCell WithData:dic];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *dic = [likeMemberArray objectAtIndex:indexPath.row];
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:[dic objectForKey:@"id"]];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
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
