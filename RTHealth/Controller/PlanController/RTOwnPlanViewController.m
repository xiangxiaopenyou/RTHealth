//
//  RTOwnPlanViewController.m
//  RTHealth
//
//  Created by cheng on 14/10/30.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTOwnPlanViewController.h"
#import "RTStartPlanTableViewCell.h"
#import "RTOwnPlanTableViewCell.h"
#import "RTFinishPlanTableViewCell.h"
#import "RTPlanDetailViewController.h"
#import "RTImportPlanViewController.h"
#import "RTPlanRequest.h"

@interface RTOwnPlanViewController ()<UITableViewDataSource,UITableViewDelegate,RTOwnPlanTableViewCellDelegate>{
    UserInfo *userInfo;
    NSMutableArray *arrayStartPlan;
    NSMutableArray *arrayFinishedPlan;
}

@end

@implementation RTOwnPlanViewController

@synthesize tableview = _tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RTUserInfo *userdata = [RTUserInfo getInstance];
    userInfo = userdata.userData;
    
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"plancreatetime" ascending:NO];
    arrayFinishedPlan = [NSMutableArray arrayWithArray:[userInfo.finishedplan allObjects]];
    [arrayFinishedPlan sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
    arrayStartPlan = [NSMutableArray arrayWithArray:[userInfo.canstartplan allObjects]];
    [arrayStartPlan sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"计划";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    
    UIButton *btnAddPlan = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAddPlan.frame = CGRectMake(SCREEN_WIDTH - 75, 27, 65, 30);
    [btnAddPlan addTarget:self action:@selector(addPlanClick) forControlEvents:UIControlEventTouchUpInside];
    [btnAddPlan setBackgroundImage:[UIImage imageNamed:@"addplan.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnAddPlan];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    [self.view addSubview:_tableview];
    
    if (_refreshHeaderView ==nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, 0-_tableview.bounds.size.height, _tableview.frame.size.width, _tableview.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        _refreshHeaderView.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
        [_tableview addSubview:_refreshHeaderView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshTable];
}
- (void)reloadTableView{
    
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"plancreatetime" ascending:NO];
    arrayFinishedPlan = [NSMutableArray arrayWithArray:[userInfo.finishedplan allObjects]];
    [arrayFinishedPlan sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
    arrayStartPlan = [NSMutableArray arrayWithArray:[userInfo.canstartplan allObjects]];
    [arrayStartPlan sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
    [_tableview reloadData];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"RTStartPlanTableViewCell";
    NSInteger i = indexPath.section;
    NSInteger j = indexPath.row;
    if (indexPath.section == 0) {
        HealthPlan *plan = userInfo.healthplan;
        NSInteger dateInterval = [CustomDate getDayToDate:plan.planbegindate];
        if (userInfo.healthplan == nil || dateInterval >= [plan.plancycleday intValue]*[plan.plancyclenumber intValue]) {
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.textLabel.text = @"没有开始中的计划,去导入";
            return cell;
        }
        
        RTStartPlanTableViewCell *cell = [[RTStartPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier withData:userInfo.healthplan];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else if(indexPath.section == 1){
        if (arrayStartPlan.count == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.textLabel.text = @"没有开始中的计划,去导入";
            return cell;
        }else{
            HealthPlan *plan = [arrayStartPlan objectAtIndex:indexPath.row];
            RTOwnPlanTableViewCell *cell = [[RTOwnPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier withData:plan];
            cell.delegate = self;
            return cell;
        }
        
    }else{
        
        HealthPlan *plan = [arrayFinishedPlan objectAtIndex:indexPath.row];
        RTFinishPlanTableViewCell *cell = [[RTFinishPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier withData:plan];
        
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:{
            if (arrayStartPlan.count == 0) {
                return 1;
            }else{
                return arrayStartPlan.count;
            }
        }
            break;
            case 2:
            return arrayFinishedPlan.count;break;
        default:
            break;
    }return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:{
            HealthPlan *plan = userInfo.healthplan;
            NSInteger dateInterval = [CustomDate getDayToDate:plan.planbegindate];
            if (userInfo.healthplan == nil || dateInterval >= [plan.plancycleday intValue]*[plan.plancyclenumber intValue]) {
                RTImportPlanViewController *importPlanController = [[RTImportPlanViewController alloc]init];
                [self.navigationController pushViewController:importPlanController animated:YES];
                return;
            }
            
            RTPlanDetailViewController *detail = [[RTPlanDetailViewController alloc]initWith:plan Type:0];
            [self.navigationController pushViewController:detail animated:YES];}
            break;
        case 1:{
            if (arrayStartPlan.count == 0) {
                RTImportPlanViewController *importPlanController = [[RTImportPlanViewController alloc]init];
                [self.navigationController pushViewController:importPlanController animated:YES];
                return;
            }else{
                HealthPlan *plan = [arrayStartPlan objectAtIndex:indexPath.row];
                RTPlanDetailViewController *detail = [[RTPlanDetailViewController alloc]initWith:plan Type:1];
                [self.navigationController pushViewController:detail animated:YES];
            }
        }break;
        case 2:{
            
            HealthPlan *plan = [arrayFinishedPlan objectAtIndex:indexPath.row];
            RTPlanDetailViewController *detail = [[RTPlanDetailViewController alloc]initWith:plan Type:1];
            [self.navigationController pushViewController:detail animated:YES];
        }break;
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    sectionLabel.font = VERDANA_FONT_14;
    sectionLabel.textColor = [UIColor blackColor];
    if (section == 0) {
        sectionLabel.text = @"进行的计划";
        [headerView addSubview:sectionLabel];
    }else if(section ==1 ){
        
        
        sectionLabel.text = @"我的计划";
        [headerView addSubview:sectionLabel];
    }
    else if(section == 2){
        
        sectionLabel.text = @"完成的计划";
        [headerView addSubview:sectionLabel];
    }
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        HealthPlan *plan = userInfo.healthplan;
        NSInteger dateInterval = [CustomDate getDayToDate:plan.planbegindate];
        if (userInfo.healthplan == nil || dateInterval >= [plan.plancycleday intValue]*[plan.plancyclenumber intValue]) {
            return 44;
        }
        return 88;
    }else if(indexPath.section ==1 ){
        if (arrayStartPlan.count == 0) {
            return 44;
        }
        return 70;
    }
    else if(indexPath.section == 2){
        return 70;
    }
    return 40;
}


- (void)addPlanClick
{
    RTImportPlanViewController *importPlanController = [[RTImportPlanViewController alloc]init];
    [self.navigationController pushViewController:importPlanController animated:YES];
}

- (void)refreshTable{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    
    [RTPlanRequest getMyPlan:parameter success:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self doneLoadingTableViewData];
        }
    }failure:^(NSError *error){
    }];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)reloadTableViewDataSource{
    _reloading = YES;
    [self refreshTable];
}

- (void)doneLoadingTableViewData{
    
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"plancreatetime" ascending:NO];
    arrayFinishedPlan = [NSMutableArray arrayWithArray:[userInfo.finishedplan allObjects]];
    [arrayFinishedPlan sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
    arrayStartPlan = [NSMutableArray arrayWithArray:[userInfo.canstartplan allObjects]];
    [arrayStartPlan sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
    
    [_tableview reloadData];
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableview];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}

#pragma mark RTOwnPlanTableView Delegate

- (void)shouldReload{
    [self doneLoadingTableViewData];
}

@end
