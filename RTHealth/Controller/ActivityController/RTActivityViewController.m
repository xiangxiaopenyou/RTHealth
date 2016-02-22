//
//  RTActivityViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTActivityViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "RTActivityTableViewCell.h"
#import "RTOrganizeActivityViewController.h"

@interface RTActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *viewPage;
    UITableView *tableViewTime;
    UITableView *tableViewDistance;
    NSInteger currentIndex;
    UserInfo *userInfo;
    NSMutableArray *arrayOfTime;
    NSMutableArray *arrayOfDistance;
}
@end

@implementation RTActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    RTUserInfo *userData = [RTUserInfo getInstance];
    userInfo = userData.userData;
    arrayOfTime = [[NSMutableArray alloc] initWithArray:[userInfo.addactivitytime allObjects]];
    arrayOfDistance = [[NSMutableArray alloc] initWithArray:[userInfo.addactivitydistance allObjects]];
    currentIndex = 0;
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIButton *organizeActivityButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 35, 60, 20) text:@"组织" icon:@"icon-plus" textAttributes:nil andIconPosition:IconPositionLeft];
    [organizeActivityButton setTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil] forUIControlState:UIControlStateNormal];
    [organizeActivityButton addTarget:self action:@selector(organizeActivityClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:organizeActivityButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"活动";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    //添加segment
    [self setupSegment];
    
    //两个tableview
    tableViewDistance = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50)];
    tableViewDistance.tag = 10;
    tableViewDistance.delegate = self;
    tableViewDistance.dataSource = self;
    [tableViewDistance setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [viewPage addSubview:tableViewDistance];
    
    tableViewTime = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50)];
    
    tableViewTime.tag = 11;
    tableViewTime.delegate = self;
    tableViewTime.dataSource = self;
    [tableViewTime setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [viewPage addSubview:tableViewTime];

}

- (void)setupSegment
{
    PPiFlatSegmentedControl *segmented2=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-250)/2, NAVIGATIONBAR_HEIGHT+10, 250, 30)
                                                                                 items:[NSArray arrayWithObjects:
                                                                                        [NSDictionary dictionaryWithObjectsAndKeys:@"距离",@"text",@"icon-map-marker",@"icon", nil],
                                                                                        [NSDictionary dictionaryWithObjectsAndKeys:@"时间",@"text",@"icon-time",@"icon", nil] ,nil]
                                                                          iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                              
                                                                              switch (segmentIndex) {
                                                                                  case 0:{
                                                                                      currentIndex = 0;
                                                                                      [UIView animateWithDuration:0.2 animations:^(void){
                                                                                          viewPage.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50);
                                                                                      }completion:^(BOOL finished){
                                                                                          viewPage.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50);
                                                                                      }];
                                                                                  }break;
                                                                                  case 1:{
                                                                                      currentIndex = 1;
                                                                                      [UIView animateWithDuration:0.2 animations:^(void){
                                                                                          viewPage.frame = CGRectMake(-SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50);
                                                                                      }completion:^(BOOL finished){
                                                                                          viewPage.frame = CGRectMake(-SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50);
                                                                                      }];
                                                                                  }break;
                                                                                  default:
                                                                                      break;
                                                                              }
                                                                              
                                                                          }];
    segmented2.color = [UIColor whiteColor];
    segmented2.borderWidth = 0.5;
    segmented2.borderColor = [UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1];
    segmented2.selectedColor = [UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1];
    segmented2.textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil];
    segmented2.selectedTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.view addSubview:segmented2];
    
    viewPage = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50)];
    [self.view addSubview:viewPage];
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

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)organizeActivityClick
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
    RTOrganizeActivityViewController *organizeActivityView = [[RTOrganizeActivityViewController alloc] init];
    [appDelegate.rootNavigationController pushViewController:organizeActivityView animated:YES];
}

#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTActivityTableViewCell *cell = [[RTActivityTableViewCell alloc] init];
    return 35 + cell.contentLabel.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    Activity *activity;
    if (tableView.tag == 10) {
        activity = [arrayOfDistance objectAtIndex:indexPath.row];
    }
    else{
        activity = [arrayOfTime objectAtIndex:indexPath.row];
    }
    
    RTActivityTableViewCell *cell = [[RTActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withData:activity];
    if (tableView.tag == 10) {
        cell.distanceLabel.textColor = [UIColor greenColor];
    }
    else{
        cell.timeLabel.textColor = [UIColor greenColor];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10) {
        return  arrayOfDistance.count;
    }
    else{
        return arrayOfTime.count;
    }
}

@end
