//
//  RTTrendDetailViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/5.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTTrendDetailViewController.h"
#import "RTTrendDetailTopTableViewCell.h"
#import "RTDiscussViewController.h"
#import "RTDiscussTableViewCell.h"
#import "RTLikeAndForwardTableViewCell.h"
#import "RTTrendsRequest.h"
#import "RTLikeListViewController.h"
#import "RTFriendInfoTableViewController.h"

@interface RTTrendDetailViewController ()<UITableViewDataSource,UITableViewDelegate,RTTrendDetailTopTableViewCellDelegate, RTDiscussTableViewCellDelegate, UIActionSheetDelegate, LXActivityDelegate>
{
    RTTrendDetailTopTableViewCell *topCell;
    UITableView *mainTableView;
    NSMutableArray *cellArray;
    NSArray *segArray;
    NSArray *pictureArray;
    
    UIImageView *likeImage;
    UserInfo *userinfo;
}

@end

@implementation RTTrendDetailViewController

@synthesize headImageView, nicknameButton, timeLabel, contentTextView, picView, smallPicView, bottomView, discussLabel, discussButton, likeLabel, likeButton, forwardLabel, forwardButton;
@synthesize trend;
@synthesize commentArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentSuccess) name:COMMENTTRENDSUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replySuccess) name:REPLYTRENDSUCCESS object:nil];
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    commentArray = [[NSArray alloc] init];
    pictureArray = [trend.trendphoto componentsSeparatedByString:@";"];
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 22, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"动态详情";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - 50)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.sectionIndexColor = [UIColor clearColor];
    mainTableView.backgroundColor = [UIColor whiteColor];
    mainTableView.backgroundView = nil;
    mainTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainTableView];
    
    [self getCommentList];

}

- (void)viewDidAppear:(BOOL)animated
{
    //底部view
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    [bottomView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bottomView];
    
    //横分割线
    UILabel *line =[[UILabel alloc] init];
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    line.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:line];
    
    //评论
    discussButton = [UIButton buttonWithType:UIButtonTypeCustom];
    discussButton.frame = CGRectMake(0, 1, SCREEN_WIDTH/3, bottomView.frame.size.height-1);
    [discussButton addTarget:self action:@selector(discussButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:discussButton];
    
    discussLabel= [[UILabel alloc] init];
    discussLabel.frame = CGRectMake(SCREEN_WIDTH/6, 1, SCREEN_WIDTH/6, bottomView.frame.size.height-1);
    discussLabel.text = @"评论";
    discussLabel.textAlignment = NSTextAlignmentLeft;
    discussLabel.textColor = [UIColor grayColor];
    [bottomView addSubview:discussLabel];
    
    UIImageView *discussImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6 - 25, 14, 22, 22)];
    discussImage.image = [UIImage imageNamed:@"discuss.png"];
    [bottomView addSubview:discussImage];
    
    //点赞
    likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(SCREEN_WIDTH/3, 1, SCREEN_WIDTH/3, bottomView.frame.size.height-1);
    [likeButton addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:likeButton];
    likeLabel= [[UILabel alloc] init];
    likeLabel.frame = CGRectMake(SCREEN_WIDTH/2, 1, SCREEN_WIDTH/6, bottomView.frame.size.height-1);
    [bottomView addSubview:likeLabel];
    likeLabel.text = @"喜欢";
    likeLabel.textAlignment = NSTextAlignmentLeft;
    likeLabel.textColor = [UIColor grayColor];
    
    likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 25, 14, 22, 22)];
    [bottomView addSubview:likeImage];
    if ([trend.isfavorite integerValue] == 1) {
        likeImage.image = [UIImage imageNamed:@"like.png"];
    }else{
        likeImage.image = [UIImage imageNamed:@"dislike.png"];
    }
    
    //转发
    forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(SCREEN_WIDTH/3*2, 1, SCREEN_WIDTH/3, bottomView.frame.size.height-1);
    [forwardButton addTarget:self action:@selector(forwardButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:forwardButton];
    
    forwardLabel= [[UILabel alloc] init];
    forwardLabel.frame = CGRectMake(5*SCREEN_WIDTH/6, 1, SCREEN_WIDTH/6, bottomView.frame.size.height-1);
    [bottomView addSubview:forwardLabel];
    forwardLabel.text = @"转发";
    forwardLabel.textAlignment = NSTextAlignmentLeft;
    forwardLabel.textColor = [UIColor grayColor];
    
    UIImageView *forwardImage = [[UIImageView alloc] initWithFrame:CGRectMake(5*SCREEN_WIDTH/6 - 25, 14, 22, 22)];
    forwardImage.image = [UIImage imageNamed:@"forward.png"];
    [bottomView addSubview:forwardImage];
    
    //两个分割线
    UILabel *labelline = [[UILabel alloc]init];
    labelline.backgroundColor = [UIColor lightGrayColor];
    labelline.frame = CGRectMake(SCREEN_WIDTH/3, 15, 1, bottomView.frame.size.height-30);
    [bottomView addSubview:labelline];
    UILabel *labelline1 = [[UILabel alloc]init];
    labelline1.backgroundColor = [UIColor lightGrayColor];
    labelline1.frame = CGRectMake(2*SCREEN_WIDTH/3, 15, 1, bottomView.frame.size.height-30);
    [bottomView addSubview:labelline1];
}

- (void)commentSuccess
{
    [self getCommentList];
}
- (void)replySuccess
{
    [self getCommentList];
}


- (void)getCommentList
{
    if(![JDStatusBarNotification isVisible]){
        [JDStatusBarNotification showWithStatus:@"稍候..."];
    }
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userinfo.userid forKey:@"userid"];
    [dic setObject:userinfo.usertoken forKey:@"usertoken"];
    [dic setObject:trend.trendid forKey:@"trendid"];
    
    [RTTrendsRequest getCommentListWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"获取评论成功");
            if(![RTUtil isEmpty:[response objectForKey:@"data"]]){
                commentArray = [response objectForKey:@"data"];
                NSLog(@"commentArray %@", commentArray);
                [mainTableView reloadData];
                [JDStatusBarNotification dismiss];
            }
            else{
                [JDStatusBarNotification dismiss];
            }
        }
        else{
            NSLog(@"获取失败");
            [JDStatusBarNotification dismiss];
        }
    } failure:^(NSError *error) {
        NSLog(@"失败");
        [JDStatusBarNotification dismiss];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)discussButtonClick
{
    NSLog(@"点击了评论");
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
    RTDiscussViewController *discussView = [[RTDiscussViewController alloc] init];
    discussView.discussString = @"评论 ";
    discussView.ownerString = trend.usernickname;
    discussView.trendID = trend.trendid;
    [appDelegate.rootNavigationController pushViewController:discussView animated:YES];
}

- (void)likeButtonClick
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userinfo.userid, @"userid", userinfo.usertoken, @"usertoken", trend.trendid, @"trendid",  nil];
    if ([trend.isfavorite integerValue] == 2) {
        likeImage.image = [UIImage imageNamed:@"like.png"];
        trend.isfavorite = @"1";
        NSInteger favoirteNum = [trend.trendfavoritenumber integerValue];
        favoirteNum += 1;
        trend.trendfavoritenumber = [NSString stringWithFormat:@"%ld", (long)favoirteNum];
        //[mainTableView reloadData];
        //[self viewDidLoad];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        [RTTrendsRequest trendLikeWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"点赞成功");
                
            }
            else{
                NSLog(@"失败");
            }
        } failure:^(NSError *error) {
            NSLog(@"错误信息");
        }];
    }
    else{
        likeImage.image = [UIImage imageNamed:@"dislike.png"];
        trend.isfavorite = @"2";
        NSInteger favoirteNum = [trend.trendfavoritenumber integerValue];
        favoirteNum -= 1;
        trend.trendfavoritenumber = [NSString stringWithFormat:@"%ld", (long)favoirteNum];
        //[mainTableView reloadData];
        //[self viewDidLoad];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        [RTTrendsRequest trendDislikeWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"取消点赞成功");
                
            }
            else{
                NSLog(@"失败");
            }
        } failure:^(NSError *error) {
            NSLog(@"错误信息");
        }];
    }
}
- (void)forwardButtonClick
{
    NSArray *shareButtonTitleArray = @[@"新浪微博",@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"];
    NSArray *shareButtonImageNameArray = @[@"sns_icon_1",@"sns_icon_22",@"sns_icon_23",@"sns_icon_24",@"sns_icon_40"];
    
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self.view];

}

#pragma mark - LXActivityDelegate
- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    switch ((int)imageIndex) {
        case 0:
            [appDelegate sharedWeiboTimeLine:@"健身坊分享" Description:trend.trendcontent objectID:trend.trendid url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trend.trendid, trend.userid]];
            break;
            
        case 1:{
            if (pictureArray.count > 0) {
                [appDelegate sendLinkContent:@"健身坊分享" Description:trend.trendcontent Url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trend.trendid, trend.userid] Photo:[RTUtil urlWeixinPhoto:[pictureArray objectAtIndex:0]]];
            }
            else{
                [appDelegate sendLinkContent:@"健身坊分享" Description:trend.trendcontent Url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trend.trendid, trend.userid] Photo:[RTUtil urlWeixinPhoto:@"icon"]];
            }
        }
            break;
        case 2:{
            if (pictureArray.count > 0) {
                [appDelegate sendLinkContentTimeLine:trend.trendcontent Description:trend.trendcontent Url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trend.trendid, trend.userid] Photo:[RTUtil urlWeixinPhoto:[pictureArray objectAtIndex:0]]];
            }
            else{
                [appDelegate sendLinkContentTimeLine:trend.trendcontent Description:trend.trendcontent Url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trend.trendid, trend.userid] Photo:[RTUtil urlWeixinPhoto:@"icon"]];
            }
        }
            break;
        case 3:{
            if (pictureArray.count > 0) {
                [appDelegate sharedQQFriendTitle:@"健身坊分享" description:trend.trendcontent url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trend.trendid, trend.userid] Photo:[RTUtil urlZoomPhoto:[pictureArray objectAtIndex:0]]];
            }
            else{
                [appDelegate sharedQQFriendTitle:@"健身坊分享" description:trend.trendcontent url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trend.trendid, trend.userid] Photo:[RTUtil urlZoomPhoto:@"icon"]];
            }
        }
            break;
        case 4:{
            if (pictureArray.count > 0) {
                [appDelegate sharedQZoneTitle:@"健身坊分享" description:trend.trendcontent url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trend.trendid, trend.userid] Photo:[RTUtil urlZoomPhoto:[pictureArray objectAtIndex:0]]];
            }
            else{
                [appDelegate sharedQZoneTitle:@"健身坊分享" description:trend.trendcontent url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trend.trendid, trend.userid] Photo:[RTUtil urlZoomPhoto:@"icon"]];
            }
        }
            break;
        default:
            break;

    }
}

#pragma mark - tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return commentArray.count + 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        topCell = (RTTrendDetailTopTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [topCell heightWith:trend];
    }
    else if(indexPath.row == 1)
    {
        
        return 40;
    }
    else{
    
        RTDiscussTableViewCell *cell = (RTDiscussTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return 70 + cell.contentLabel.frame.size.height;
        NSLog(@"height %f", cell.contentLabel.frame.size.height);

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    static NSString *cellCustom = @"CellCustom";
    static NSString *Cell = @"TopCell";
    if (indexPath.row == 0) {
        topCell = [[RTTrendDetailTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell WithData:trend];
        topCell.delegate = self;
        [topCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return topCell;
    }
    else if (indexPath.row == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSString *likeNum = trend.trendfavoritenumber;
        likeNum = [NSString stringWithFormat:@"已有 %@ 人点赞", likeNum];
        NSLog(@"like %@", likeNum);
        UILabel *likeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 19, SCREEN_WIDTH - 10, 20)];
        likeNumLabel.text = likeNum;
        likeNumLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        likeNumLabel.font = SMALLFONT_14;
        [cell.contentView addSubview:likeNumLabel];
        
        //底部分割
        UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,  39.5, SCREEN_WIDTH, 0.5)];
        bottomLabel.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [cell.contentView addSubview:bottomLabel];

        
        return cell;
    }

    else{
        NSDictionary *dictionary = [[NSDictionary alloc] init];
        dictionary = [commentArray objectAtIndex:indexPath.row - 2];
        RTDiscussTableViewCell *cell = [[RTDiscussTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellCustom WithData:dictionary];
        cell.delegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        //分割线
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 69.5+cell.contentLabel.frame.size.height, SCREEN_WIDTH, 0.5)];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:lineLabel];
        
        return cell;

    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 1) {
        RTAppDelegate *appDelegate = (RTAppDelegate*)[UIApplication sharedApplication].delegate;
        RTLikeListViewController *likeListView = [[RTLikeListViewController alloc] init];
        likeListView.trendID = trend.trendid;
        [appDelegate.rootNavigationController pushViewController:likeListView animated:YES];
        
    }
}

#pragma mark - TopTableViewCell Delegate
- (void)clickHeadImage:(NSString *)idString
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:idString];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
}
- (void)clickNicknameButton:(NSString*)idString
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:idString];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
}

#pragma mark - DiscussTableCell Delegate
- (void)clickReplyButton{
       
}

- (void)clickDeleteCommentButton
{
    [self getCommentList];
}

- (void)clickSmallPicView
{
    
}
- (void)clickCommentHeadImage:(NSString *)idString
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:idString];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
}

- (void)clickCommentNickname:(NSString *)idString
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:idString];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
}
- (void)clickTrendClassify:(NSString *)classifyString
{
    [self.delegate clickLabel:classifyString];
    [self.navigationController popViewControllerAnimated:YES];
    
}

//#pragma mark - DiscussViewDelegate
//- (void)commentSuccess
//{
//    [self viewDidLoad];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
