//
//  RTOwnActivityViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTOwnActivityViewController.h"
#import "RTUnderwayActivityTableViewCell.h"
#import "RTFinishedActivityTableViewCell.h"
#import "RTActivityViewController.h"
#import "RTActivityDetailViewController.h"

@interface RTOwnActivityViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UserInfo *userInfo;
    NSMutableArray *arrayUnderwayActivity;
    NSMutableArray *arrayFinishededActivity;
}

@end

@implementation RTOwnActivityViewController

@synthesize activityTableView = _activityTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RTUserInfo *userdata = [RTUserInfo getInstance];
    userInfo = userdata.userData;
    
    arrayUnderwayActivity = [NSMutableArray arrayWithArray:[userInfo.underwayactivity allObjects]];
    arrayFinishededActivity = [NSMutableArray arrayWithArray:[userInfo.finishedactivity allObjects]];
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"我的活动";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    _activityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
    _activityTableView.delegate = self;
    _activityTableView.dataSource = self;
    _activityTableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    //_activityTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_activityTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return arrayUnderwayActivity.count;
    }
    else{
        return arrayFinishededActivity.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    if (indexPath.section == 0) {
        Activity *activity = [arrayUnderwayActivity objectAtIndex:indexPath.row];
        RTUnderwayActivityTableViewCell *cell = [[RTUnderwayActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withData:activity];
        return cell;
    }
    else{
        Activity *activity = [arrayFinishededActivity objectAtIndex:indexPath.row];
        RTFinishedActivityTableViewCell *cell = [[RTFinishedActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withData:activity];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
    sectionLabel.font = VERDANA_FONT_14;
    sectionLabel.textColor = [UIColor blackColor];
    
    if (section == 0) {
        sectionLabel.text = @"进行中的活动";
        [header addSubview:sectionLabel];
        
        UIButton *addActivityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addActivityButton.frame = CGRectMake(SCREEN_WIDTH - 75, 5, 60, 23);
        [addActivityButton addTarget:self action:@selector(addActivityClick) forControlEvents:UIControlEventTouchUpInside];
        [addActivityButton setImage:[UIImage imageNamed:@"addplan.png"] forState:UIControlStateNormal];
        [header addSubview:addActivityButton];
    }
    else{
        sectionLabel.text = @"已结束的活动";
        [header addSubview:sectionLabel];
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 85;
    }
    else{
        return 30;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    RTActivityDetailViewController *activityDetailView = [[RTActivityDetailViewController alloc]init];
    [appDelegate.rootNavigationController pushViewController:activityDetailView animated:YES];
}

- (void)addActivityClick
{
    RTActivityViewController *addActivityView = [[RTActivityViewController alloc] init];
    [self.navigationController pushViewController:addActivityView animated:YES];
}

@end
