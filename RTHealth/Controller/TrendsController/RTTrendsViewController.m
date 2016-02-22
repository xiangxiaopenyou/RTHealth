//
//  RTTrendsViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/10/23.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTTrendsViewController.h"
#import "RTTrendsTableViewCell.h"
#import "RTLastTableViewCell.h"
//#import "RTSelectView.h"
#import "RTTrendDetailViewController.h"
#import "RTSelectProjectViewController.h"
#import "RTTrendsRequest.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "RTTrendDetailViewController.h"
#import "RTSelectClassifyViewController.h"
#import "UIButton+PPiAwesome.h"
#import "RTFocusMapDetailViewController.h"


@interface RTTrendsViewController ()<UITableViewDataSource,UITableViewDelegate, PopoverViewDelegate, RTTrendsTableViewCellDelegate, RTSelectProjectViewControllerDelegate, RTTrendDetailDelegate, RTSelectClassifyDelegate>
{
    RTSelectProjectViewController *selectprojectView;
    RTTrendsTableViewCell *trendsCell;
    //RTSelectView *selectView;
    PopoverView *popoverView;
    
    UIScrollView *topScrollView;
    UIPageControl *pageControl;
    
    UIImageView *chooseProjectImage;
    NSString *projectTypeString;
    NSString *trendsClassifyString;
    
    NSMutableArray *arrayOfTrends;
    
    NSArray *focusMapArray;
    NSArray *focusUrlArray;
    UserInfo *userinfo;
    NSInteger imageCount;
    
    BOOL showMore;
    BOOL isGetData;
    
    NSString *classifyString;
    
    NSIndexPath *index;
    
    UIButton *selectButton;
}

@end

@implementation RTTrendsViewController
@synthesize trendsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendSuccess) name:SENDSUCCESS object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentSuccess) name:COMMENTTRENDSUCCESS object:nil];
    showMore = NO;
    isGetData = YES;
    _reloading = NO;
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    arrayOfTrends = [[NSMutableArray alloc] init];
    chooseProjectImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 42, 30, 24, 24)];
    chooseProjectImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports01.png"]];
    [self.view addSubview:chooseProjectImage];
    
    //项目选择按钮
    UIButton *chooseProjectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseProjectButton.frame = CGRectMake(SCREEN_WIDTH - 50, 20, 40, 40);
    [chooseProjectButton addTarget:self action:@selector(chooseProjectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseProjectButton];
    
    trendsClassifyString = @"所有话题";
    //话题选择按钮
    selectButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 33, SCREEN_WIDTH - 100, 22) text:trendsClassifyString icon:@"icon-chevron-down" textAttributes:nil andIconPosition:IconPositionRight];
    [selectButton addTarget:self action:@selector(selectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [selectButton setTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BOLDFONT_17,NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName, nil] forUIControlState:UIControlStateNormal];
    [self.view addSubview:selectButton];
    
    //话题列表
    trendsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT) style:UITableViewStylePlain];
    trendsTableView.delegate = self;
    trendsTableView.dataSource = self;
    [trendsTableView setSectionIndexColor:[UIColor clearColor]];
    [trendsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [trendsTableView setBackgroundView:nil];
    [trendsTableView setBackgroundColor:[UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0]];
    trendsTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:trendsTableView];
    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - trendsTableView.bounds.size.height, trendsTableView.frame.size.width, trendsTableView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [trendsTableView addSubview:_refreshHeaderView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
 
    [self refreshTrendsList];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(runPage) userInfo:nil repeats:YES];
}

- (void)sendSuccess
{
    [trendsTableView setContentOffset:CGPointMake(0,-70) animated:YES];
}

- (void)getTrendsList
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userinfo.userid forKey:@"userid"];
    [dic setObject:userinfo.usertoken forKey:@"usertoken"];
    if (![trendsClassifyString isEqualToString:@"所有话题"]) {
        [dic setObject:trendsClassifyString forKey:@"topic"];
    }
    if (![self isBlankString:projectTypeString]) {
        if (![projectTypeString isEqualToString:@"01"]) {
            [dic setObject:projectTypeString forKey:@"sports"];
        }
        
    }
    if (userinfo.alltrends.count == 0) {
        NSDate *nowDate = [NSDate date];
        NSString *time = [CustomDate getDateString:nowDate];
        [dic setObject:time forKey:@"time"];
    }
    else{
        Trends *trend = [arrayOfTrends lastObject];
        [dic setObject:trend.trendtime forKey:@"time"];
    }
    //NSLog(@"dicdic %@", dic);
    [RTTrendsRequest getTrendsListWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] intValue] ==1000) {
            NSLog(@"获取成功");
            [arrayOfTrends removeAllObjects];
            [arrayOfTrends addObjectsFromArray:[userinfo.alltrends allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
            [arrayOfTrends sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
            //[trendsTableView reloadData];
            if ([[response objectForKey:@"count"] integerValue] != 10) {
                showMore = YES;
            }
            else{
                showMore = NO;
            }
        }
        else{
            NSLog(@"获取失败");
            showMore = YES;
        }
        [trendsTableView reloadData];
        isGetData = NO;
    } failure:^(NSError *error) {
        showMore = YES;
        [trendsTableView reloadData];
        isGetData = NO;
        NSLog(@"获取失败");
    }];
}

- (void)refreshTrendsList
{
    //NSLog(@"xianglinpingxianginping");
    for (Trends *removeTrend in userinfo.alltrends) {
        [removeTrend MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [userinfo.alltrendsSet removeAllObjects];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userinfo.userid forKey:@"userid"];
    [dic setObject:userinfo.usertoken forKey:@"usertoken"];
    NSLog(@"text %@", trendsClassifyString);
    if (![trendsClassifyString isEqualToString:@"所有话题"]) {
        [dic setObject:trendsClassifyString forKey:@"topic"];
    }
    if (![self isBlankString:projectTypeString]) {
        if (![projectTypeString isEqualToString:@"01"]) {
            [dic setObject:projectTypeString forKey:@"sports"];
        }
    }
    NSDate *nowDate = [NSDate date];
    NSString *time = [CustomDate getDateString:nowDate];
    [dic setObject:time forKey:@"time"];
    [RTTrendsRequest getTrendsListWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] intValue] ==1000) {
            NSLog(@"获取成功");
            NSDictionary *valueDic = [response objectForKey:@"ht_data"];
//            NSDictionary *valueDic = [valueArray objectAtIndex:0];
            NSString *picValueString = [valueDic objectForKey:@"value1"];
            NSString *urlValueString = [valueDic objectForKey:@"value2"];
            focusMapArray = [picValueString componentsSeparatedByString:@","];
            focusUrlArray = [urlValueString componentsSeparatedByString:@","];
            
            //焦点图
            UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 112)];
            topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 112)];
            topScrollView.pagingEnabled = YES;
            topScrollView.bounces = NO;
            topScrollView.showsHorizontalScrollIndicator = NO;
            topScrollView.delegate = self;
            for (int i = 0; i < focusMapArray.count; i++) {
                UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(i*topScrollView.frame.size.width, 0, topScrollView.frame.size.width, topScrollView.frame.size.height)];
                imgview.contentMode=UIViewContentModeScaleAspectFill;
                imgview.clipsToBounds=YES;
                imgview.tag = i;
                imgview.userInteractionEnabled = YES;
                [imgview setOnlineImage:[RTUtil urlPhoto:[focusMapArray objectAtIndex:i]]];
                [topScrollView addSubview:imgview];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusMapPress:)];
                [imgview addGestureRecognizer:tap];
            }
            topScrollView.contentSize = CGSizeMake(focusMapArray.count * topScrollView.frame.size.width, 0);
            [topView addSubview:topScrollView];
            trendsTableView.tableHeaderView = topView;
            
            pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 95, 90, 15)];
            pageControl.numberOfPages = focusMapArray.count;
            pageControl.currentPage = 0;
            [topView addSubview:pageControl];
            
            [arrayOfTrends removeAllObjects];
            [arrayOfTrends addObjectsFromArray:[userinfo.alltrends allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"trendtime" ascending:NO];
            [arrayOfTrends sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
            if ([[response objectForKey:@"count"] integerValue] != 10) {
                showMore = YES;
            }
            else{
                showMore = NO;
            }
            
        }
        else{
            NSLog(@"获取失败");
            showMore = YES;
        }
        [self doneLoadingTableViewData];
        isGetData = NO;
    } failure:^(NSError *error) {
        showMore = YES;
        [self doneLoadingTableViewData];
        isGetData = NO;
        NSLog(@"获取失败");
    }];
}

//点击焦点图
- (void)focusMapPress:(UITapGestureRecognizer*)gesture
{
    UIImageView *image = (UIImageView*)gesture.view;
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFocusMapDetailViewController *focusMapDetailController = [[RTFocusMapDetailViewController alloc] init];
    focusMapDetailController.url = [focusUrlArray objectAtIndex:image.tag];
    [appDelegate.rootNavigationController pushViewController:focusMapDetailController animated:YES];
}
//播放焦点图
- (void)runPage{
    NSInteger page = pageControl.currentPage;
    page ++;
    page = page >= focusMapArray.count ? 0 : page;
    pageControl.currentPage = page;
    [self turnPage];
    
}
- (void)turnPage{
     NSInteger page = pageControl.currentPage;
    [UIView animateWithDuration:0.5 animations:^{
        topScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * page, 0);
    }];
}


#pragma mark - tableview delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayOfTrends.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    if (indexPath.row == arrayOfTrends.count){
        return 48;
    }
    else{
        Trends *trend = [arrayOfTrends objectAtIndex:indexPath.row];
        trendsCell = (RTTrendsTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return [trendsCell heightWith:trend];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    static NSString *CellIdentifier = @"TrendsCell";
    //static NSString *ImageCell = @"ImageCell";
    static NSString *LastCell = @"RTLastTableViewCell";
    Trends *trend;
    if (indexPath.row >= arrayOfTrends.count)
    {
        RTLastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LastCell];
        if (cell == nil) {
            cell = [[RTLastTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LastCell];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
        if (showMore) {
            cell.label.text = @"没有更多动态喽~";
            [cell.indicatorView stopAnimating];
        }
        else{
            cell.label.text = @"加载中...";
            [cell.indicatorView startAnimating];
            if (!isGetData) {
                [self getTrendsList];
            }
        }
        return cell;
    }
    //else{
    trend = [arrayOfTrends objectAtIndex:indexPath.row];
     trendsCell = [[RTTrendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier WithData:trend];
    [trendsCell setSelectionStyle:UITableViewCellSelectionStyleGray];
    trendsCell.delegate = self;
    return trendsCell;
    //}

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row < arrayOfTrends.count) {
        RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
        RTTrendDetailViewController *trendDetailView = [[RTTrendDetailViewController alloc] init];
        trendDetailView.delegate = self;
        trendDetailView.trend = [arrayOfTrends objectAtIndex:indexPath.row];
        //[trendDetailView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [appDelegate.rootNavigationController pushViewController:trendDetailView animated:YES];
    }
}


- (void)chooseProjectClick
{
    NSLog(@"选择项目");
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    selectprojectView = [[RTSelectProjectViewController alloc] init];
    selectprojectView.delegate = self;
    [appDelegate.rootNavigationController pushViewController:selectprojectView animated:YES];
}
#pragma mark - RTSelectProjectViewControllerDelegate
- (void)clickProjectView
{
    projectTypeString = selectprojectView.projectSelectedString;
    chooseProjectImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%@.png", projectTypeString]];
    [self refreshTrendsList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击头像
- (void)clickHeadImage:(NSString*)userid{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:userid];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
}
//点击昵称
- (void)clickNicknameButton:(NSString *)userid
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTFriendInfoTableViewController *controller = [[RTFriendInfoTableViewController alloc]initWithFriendid:userid];
    [appDelegate.rootNavigationController pushViewController:controller animated:YES];
}


- (void)selectButtonClick{
    RTAppDelegate *delegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTSelectClassifyViewController *trendsClassifyView = [[RTSelectClassifyViewController alloc] init];
    trendsClassifyView.delegate = self;
    trendsClassifyView.selectedString = trendsClassifyString;
    [trendsClassifyView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [delegate.rootNavigationController presentViewController:trendsClassifyView animated:YES completion:nil];
    
}

#pragma mark - RTSelectClassifyDelegate
- (void)clickClassify:(NSString *)classify
{
    [selectButton setButtonText:classify];
    trendsClassifyString = classify;
    [self refreshTrendsList];
}

#pragma mark - RTTrendsTableViewCell Delegate
- (void)clickDiscussButton
{

}

- (void)clickLikeButton
{
    NSLog(@"点击了喜欢");
}

- (void)clickForwardButton
{
    
}
-(void)clickSmallImage
{
}

- (void)clickTrendsClassfy:(NSString *)classify
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"#"];
    trendsClassifyString = [classify stringByTrimmingCharactersInSet:set];
    [selectButton setButtonText:trendsClassifyString];
    [selectButton setButtonIcon:@"icon-chevron-down"];
    [self refreshTrendsList];
}

- (void)clickDeleteButton
{
    [self refreshTrendsList];
}

#pragma mark - RTTrendDetailDelegate
- (void)clickLabel:(NSString *)labelString
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"#"];
    trendsClassifyString = [labelString stringByTrimmingCharactersInSet:set];
    [selectButton setButtonText:trendsClassifyString];
    [selectButton setButtonIcon:@"icon-chevron-down"];
    [self refreshTrendsList];
}

#pragma mark - UIScrollView Delegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == topScrollView) {
        pageControl.currentPage = floor(scrollView.contentOffset.x/scrollView.frame.size.width);
    }
    else{
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate

- (void)reloadTableViewDataSource{
        _reloading = YES;
        [self refreshTrendsList];
}

- (void)doneLoadingTableViewData{
        _reloading = NO;
        [trendsTableView reloadData];
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:trendsTableView];
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
        return _reloading;
    
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}


//判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
