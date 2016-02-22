//
//  RTInviteMemberViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/12/27.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTInviteMemberViewController.h"
#import "RTActivtyRequest.h"

@interface RTInviteMemberViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *memberTableView;
    NSMutableArray *dataArray;
    UserInfo *userinfo;
    NSMutableArray *friendidArray;
    NSString *friendidString;
}

@end

@implementation RTInviteMemberViewController

@synthesize activityId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 22, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"邀请";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    //发送邀请按钮
    UIButton *submitButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(SCREEN_WIDTH - 40, 22, 40, 40);
    [submitButton setTitle:@"发送" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    memberTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
    memberTableView.delegate = self;
    memberTableView.dataSource = self;
    memberTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    memberTableView.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:memberTableView];
    [self getFriends];
    
    friendidArray = [[NSMutableArray alloc] init];
}

- (void)getFriends
{
    dataArray = [[NSMutableArray alloc] init];
    for (FriendsInfo *removefriendInfo in userinfo.attentionuser) {
        [removefriendInfo MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [RTFriendRequest getAttentionSuccess:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:[userinfo.attentionuser allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendname" ascending:NO];
            [dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
            [memberTableView reloadData];
        }
        else{
            NSLog(@"获取失败");
        }
    } failure:^(NSError *error) {
        NSLog(@"获取失败");
    }];
}

- (void)submitButtonClick
{
    if (friendidArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"先选择要邀请的小伙伴吧~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        friendidString = @"";
        for(int i = 0; i < friendidArray.count; i++){
            friendidString = [friendidString stringByAppendingString:[friendidArray objectAtIndex:i]];
            friendidString = [friendidString stringByAppendingString:@";"];
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:userinfo.userid forKey:@"userid"];
        [dic setObject:userinfo.usertoken forKey:@"usertoken"];
        [dic setObject:friendidString forKey:@"friendid"];
        [dic setObject:activityId forKey:@"activityid"];
        [RTActivtyRequest inviteJoinActivityWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"邀请成功");
                [self.navigationController popViewControllerAnimated:YES];
                [JDStatusBarNotification showWithStatus:@"邀请已发送√" dismissAfter:1.4];
            }
            else{
                NSLog(@"邀请失败");
                [JDStatusBarNotification showWithStatus:@"邀请失败" dismissAfter:1.4];
            }
        } failure:^(NSError *error) {
            NSLog(@"网络问题");
            [JDStatusBarNotification showWithStatus:@"请检查网络" dismissAfter:1.4];
        }];
    }
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    FriendsInfo *friendInfo = [dataArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 40, 40)];
    headerImage.layer.masksToBounds = YES;
    headerImage.layer.cornerRadius = 20;
    headerImage.layer.borderWidth = 1;
    headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
    [headerImage setOnlineImage:[RTUtil urlPhoto:friendInfo.friendphoto]];
    [cell addSubview:headerImage];
    
    UILabel *nicknameLabe = [[UILabel alloc] initWithFrame:CGRectMake(62, 20, 200, 20)];
    nicknameLabe.font = SMALLFONT_14;
    nicknameLabe.textAlignment = NSTextAlignmentLeft;
    nicknameLabe.text = friendInfo.friendnickname;
    [cell addSubview:nicknameLabe];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5)];
    lineLabel.backgroundColor = LINE_COLOR;
    [cell addSubview:lineLabel];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendsInfo *friendInfo = [dataArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [friendidArray addObject:friendInfo.friendid];
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        for(int i = 0; i < friendidArray.count; i++){
            if ([friendInfo.friendid isEqualToString:[friendidArray objectAtIndex:i]]) {
                [friendidArray removeObjectAtIndex:i];
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
