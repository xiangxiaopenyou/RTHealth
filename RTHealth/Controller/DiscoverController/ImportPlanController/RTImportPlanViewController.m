//
//  RTImportPlanViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTImportPlanViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "RTLoginViewController.h"
#import "RTImportPlanTableViewCell.h"
#import "RTImportSelectView.h"
#import "RTCreatePlanFirstStepViewController.h"
#import "RTDiscoverRequest.h"
#import "RTPlanDetailViewController.h"

#define BUTTON_UP @"icon-chevron-up"
#define BUTTON_DOWN @"icon-chevron-down"

@interface RTImportPlanViewController ()<PopoverViewDelegate,UITableViewDataSource,UITableViewDelegate,RTImportSelectViewDelegate>{
    UIView *viewPage;
    UITableView *tableviewTime;
    UITableView *tableviewPopularity;
    NSInteger currentIndex;
    NSInteger currentSelect;
    BOOL showMore;
    BOOL showMore_Time;
    BOOL isGetData;
    BOOL isGetData_time;
    UserInfo *userinfo;
    NSMutableArray *arrayOfTime;
    NSMutableArray *arrayOfPopular;
    PopoverView *popoverview;
    
    NSMutableArray *arrayOfSelect;
}

@end

@implementation RTImportPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    showMore = NO;
    showMore_Time = NO;
    isGetData = NO;
    isGetData_time = NO;
    _isloading = NO;
    _isloading_time = NO;
    
    arrayOfPopular = [[NSMutableArray alloc]initWithArray:[userinfo.importplanrenqi allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"plannumber" ascending:NO];
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"planid" ascending:NO];
    [arrayOfPopular sortUsingDescriptors:[NSArray arrayWithObjects: sort,sort2,nil]];
    
    arrayOfTime = [[NSMutableArray alloc]initWithArray:[userinfo.importplantime allObjects]];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"plancreatetime" ascending:NO];
    [arrayOfTime sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
    
    arrayOfSelect= [[NSMutableArray alloc]initWithObjects:@"全部",@"教练",@"达人",@"系统",@"练耐力",@"练力量",@"练腹肌",@"瘦身",@"美腿", nil];
    currentIndex = 0;
    currentSelect = 0;
    
    [self refreshTitle];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(110,35,100,20) text:@"全部" icon:@"icon-chevron-down" textAttributes:nil andIconPosition:IconPositionRight];
    [self.button setTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName, nil] forUIControlState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(clickSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    UIButton *addNewPlan =[[UIButton alloc] initWithFrame:CGRectMake(260,35,60,20) text:@"创建" icon:@"icon-chevron-up" textAttributes:nil andIconPosition:IconPositionLeft];
//    [addNewPlan setTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName,[UIColor orangeColor],NSForegroundColorAttributeName, nil] forUIControlState:UIControlStateNormal];
//    [addNewPlan addTarget:self action:@selector(addNewPlanClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:addNewPlan];
    
    UIButton *addPlanNew = [UIButton buttonWithType:UIButtonTypeCustom];
    addPlanNew.frame = CGRectMake(260,26,60,32);
    [addPlanNew setBackgroundImage:[UIImage imageNamed:@"addnewplan.png"] forState:UIControlStateNormal];
//    [addPlanNew setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [addPlanNew addTarget:self action:@selector(addNewPlanClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPlanNew];
    
    PPiFlatSegmentedControl *segmented2=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-250)/2, NAVIGATIONBAR_HEIGHT+10, 250, 30)
                                                                                 items:[NSArray arrayWithObjects:
                                                                                        [NSDictionary dictionaryWithObjectsAndKeys:@"人气",@"text",@"icon-user",@"icon", nil],
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
    segmented2.borderColor = [UIColor colorWithRed:33.0f/255.0 green:138.0f/255.0 blue:246.0f/255.0 alpha:1];
    segmented2.selectedColor = [UIColor colorWithRed:33.0f/255.0 green:138.0f/255.0 blue:246.0f/255.0 alpha:1];
    segmented2.textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil];
    segmented2.selectedTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.view addSubview:segmented2];
    
    viewPage = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50)];
    [self.view addSubview:viewPage];
    
    tableviewTime = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50)];
    tableviewTime.tag = 10;
    tableviewTime.delegate = self;
    tableviewTime.dataSource = self;
    tableviewTime.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableviewTime.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    [viewPage addSubview:tableviewTime];
    
    tableviewPopularity = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50)];
    tableviewPopularity.tag = 11;
    tableviewPopularity.delegate = self;
    tableviewPopularity.dataSource = self;
    tableviewPopularity.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableviewPopularity.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    [viewPage addSubview:tableviewPopularity];
    
    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-tableviewPopularity.bounds.size.height, tableviewPopularity.frame.size.width, tableviewPopularity.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        _refreshHeaderView.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
        [tableviewPopularity addSubview:_refreshHeaderView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    if (_refreshHeaderView_time == nil) {
        _refreshHeaderView_time = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-tableviewTime.bounds.size.height, tableviewTime.frame.size.width, tableviewTime.bounds.size.height)];
        _refreshHeaderView_time.delegate = self;
        [_refreshHeaderView_time setBackgroundColor:[UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0]];
        [tableviewTime addSubview:_refreshHeaderView_time];
    }
    [_refreshHeaderView_time refreshLastUpdatedDate];
    
}

- (void)refreshTitle{
    [self.button setButtonText:[arrayOfSelect objectAtIndex:currentSelect]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    arrayOfPopular = [[NSMutableArray alloc]initWithArray:[userinfo.importplanrenqi allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"plannumber" ascending:NO];
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"planid" ascending:NO];
    [arrayOfPopular sortUsingDescriptors:[NSArray arrayWithObjects: sort,sort2,nil]];
    
    arrayOfTime = [[NSMutableArray alloc]initWithArray:[userinfo.importplantime allObjects]];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"plancreatetime" ascending:NO];
    [arrayOfTime sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
    [tableviewPopularity reloadData];
    [tableviewTime reloadData];
    if (arrayOfPopular.count == 0) {
        [tableviewPopularity setContentOffset:CGPointMake(0,-70) animated:YES];
    }
    if (arrayOfTime.count == 0) {
        [tableviewTime setContentOffset:CGPointMake(0,-70) animated:YES];
    }
}

- (void)refreshDataTime{
    
    for (HealthPlan *removePlan in userinfo.importplantime) {
        [removePlan MR_deleteEntity];
    }
    [userinfo.importplantimeSet removeAllObjects];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [arrayOfTime removeAllObjects];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:userinfo.usertoken forKey:@"usertoken"];
    [dictionary setObject:userinfo.userid forKey:@"userid"];
    [dictionary setObject:IMPORTPLAN_FLAG_TIME forKey:@"sorttype"];
    [dictionary setObject:[NSNumber numberWithInteger:currentSelect+1]  forKey:@"planfilter"];
    if (userinfo.importplantime.count == 0) {
        [dictionary setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        HealthPlan *plan = [arrayOfTime lastObject];
        [dictionary setObject:plan.plancreatetime forKey:@"time"];
    }
    [RTDiscoverRequest getPlanWithTime:dictionary success:^(id response){
        
        if ([[response objectForKey:@"state"] integerValue]==URL_NORMAL) {
            
            [arrayOfTime removeAllObjects];
            [arrayOfTime addObjectsFromArray:[userinfo.importplantime allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"plancreatetime" ascending:NO];
            [arrayOfTime sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
            
            if ([[response objectForKey:@"count"]integerValue] != NUMBER_CELL){
                showMore_Time = YES;
            }else{
                showMore_Time = NO;
            }
        }else{
            showMore_Time = YES;
        }
        [self doneLoadingTableViewData];
        isGetData_time = NO;
        
    }failure:^(NSError *error){
        showMore_Time = YES;
        [self doneLoadingTableViewData];
        isGetData_time = NO;
    }];
}

- (void)loadDataTime{
    
    isGetData_time = YES;
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:userinfo.usertoken forKey:@"usertoken"];
    [dictionary setObject:userinfo.userid forKey:@"userid"];
    [dictionary setObject:IMPORTPLAN_FLAG_TIME forKey:@"sorttype"];
    [dictionary setObject:[NSNumber numberWithInteger:currentSelect+1]  forKey:@"planfilter"];
    if (userinfo.importplantime.count == 0) {
        [dictionary setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        HealthPlan *plan = [arrayOfTime lastObject];
        [dictionary setObject:plan.plancreatetime forKey:@"time"];
    }
    [RTDiscoverRequest getPlanWithTime:dictionary success:^(id response){
        
        if ([[response objectForKey:@"state"] integerValue]==URL_NORMAL) {
            
            [arrayOfTime removeAllObjects];
            [arrayOfTime addObjectsFromArray:[userinfo.importplantime allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"plancreatetime" ascending:NO];
            [arrayOfTime sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
            if ([[response objectForKey:@"count"]integerValue] != NUMBER_CELL){
                showMore_Time = YES;
            }
        }else{
            showMore_Time = YES;
        }
        [tableviewTime reloadData];
        isGetData_time = NO;
        
    }failure:^(NSError *error){
        showMore_Time = YES;
        [tableviewTime reloadData];
        isGetData_time = NO;
    }];

}
- (void)refreshDataPopular{
    
    for (HealthPlan *removePlan in userinfo.importplanrenqi) {
        [removePlan MR_deleteEntity];
    }
    [userinfo.importplanrenqiSet removeAllObjects];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [arrayOfPopular removeAllObjects];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:userinfo.usertoken forKey:@"usertoken"];
    [dictionary setObject:userinfo.userid forKey:@"userid"];
    [dictionary setObject:IMPORTPLAN_FLAG_POPULAR forKey:@"sorttype"];
    [dictionary setObject:[NSNumber numberWithInteger:currentSelect+1] forKey:@"planfilter"];
    if (userinfo.importplanrenqi.count == 0) {
        [dictionary setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        HealthPlan *plan = [arrayOfPopular lastObject];
        [dictionary setObject:plan.plannumber forKey:@"popular"];
        [dictionary setObject:plan.plancreatetime forKey:@"time"];
    }
    [RTDiscoverRequest getPlanWithPopular:dictionary success:^(id response){
        if ([[response objectForKey:@"state"] integerValue]==URL_NORMAL) {
            
            [arrayOfPopular removeAllObjects];
            [arrayOfPopular addObjectsFromArray:[userinfo.importplanrenqi allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"plannumber" ascending:NO];
            NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"planid" ascending:NO];
            [arrayOfPopular sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1, nil]];
            if ([[response objectForKey:@"count"]integerValue] != NUMBER_CELL){
                showMore = YES;
            }else{
                showMore = NO;
            }
        }else{
            showMore = YES;
        }
        [self doneLoadingTableViewData];
        isGetData = NO;
        
    }failure:^(NSError *error){
        [self doneLoadingTableViewData];
        isGetData = NO;
        showMore = YES;
    }];
}

- (void)loadDataPopular{
    isGetData_time = YES;
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:userinfo.usertoken forKey:@"usertoken"];
    [dictionary setObject:userinfo.userid forKey:@"userid"];
    [dictionary setObject:IMPORTPLAN_FLAG_POPULAR forKey:@"sorttype"];
    [dictionary setObject:[NSNumber numberWithInteger:currentSelect+1]  forKey:@"planfilter"];
    if (userinfo.importplanrenqi.count == 0) {
        [dictionary setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        HealthPlan *plan = [arrayOfPopular lastObject];
        [dictionary setObject:plan.plannumber forKey:@"popular"];
        [dictionary setObject:plan.plancreatetime forKey:@"time"];
    }
    [RTDiscoverRequest getPlanWithPopular:dictionary success:^(id response){
        if ([[response objectForKey:@"state"] integerValue]==URL_NORMAL) {
            
            [arrayOfPopular removeAllObjects];
            [arrayOfPopular addObjectsFromArray:[userinfo.importplanrenqi allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"plannumber" ascending:NO];
            NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"planid" ascending:NO];
            [arrayOfPopular sortUsingDescriptors:[NSArray arrayWithObjects:sort,sort1, nil]];
            if ([[response objectForKey:@"count"]integerValue] != NUMBER_CELL){
                showMore = YES;
            }
        }else{
            showMore = YES;
        }
        [tableviewPopularity reloadData];
        isGetData = NO;
    }failure:^(NSError *error){
        showMore = YES;
        [tableviewPopularity reloadData];
        isGetData = NO;
    }];

}
- (void)clickSelect:(id)sender
{
    [self.button setButtonIcon:BUTTON_UP];
    CGPoint point = CGPointMake(SCREEN_WIDTH/2, NAVIGATIONBAR_HEIGHT);
    float height;
    if (SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - 30 > 400) {
        height = 396;
    }else{
        height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT -50;
    }
    
    RTImportSelectView *popoverViewImport = [[RTImportSelectView alloc]initWithFrame:CGRectMake(0, 0, 90,height)
                                                                     withArray:arrayOfSelect];
    popoverViewImport.delegate = self;
    popoverview = [[PopoverView alloc]init];
    popoverview.delegate = self;
    [popoverview showAtPoint:point inView:self.view withContentView:popoverViewImport];
    
}

- (void)backClick
{
    [UIView animateWithDuration:0.2 animations:^(void){
        viewPage.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50);
    }completion:^(BOOL finished){
        viewPage.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT+50, SCREEN_WIDTH*2, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-50);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)addNewPlanClick:(UIButton*)btn
{
    RTCreatePlanFirstStepViewController *newPlan = [[RTCreatePlanFirstStepViewController alloc]init];
    [self.navigationController pushViewController:newPlan animated:YES];
}

#pragma mark - PopoverViewDelegate Methods

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    
    [popoverView showImage:[UIImage imageNamed:@"success"] withMessage:@"123"];
    
    //Dismiss the PopoverView after 0.5 seconds
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.button setButtonIcon:BUTTON_DOWN];
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RTLastTableViewCell";
    if (tableView.tag == 10) {
        if (indexPath.row >= arrayOfTime.count) {
            RTLastTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[RTLastTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            if (showMore_Time) {
                cell.label.text = @"没有更多数据";
                [cell.indicatorView stopAnimating];
            }else{
                cell.label.text = @"加载中";
                [cell.indicatorView startAnimating];
                if (!isGetData_time && arrayOfTime.count != 0) {
                    [self loadDataTime];
                }
            }
            return cell;
        }
    }else{
        if (indexPath.row >= arrayOfPopular.count ) {
            RTLastTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[RTLastTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            if (showMore) {
                cell.label.text = @"没有更多数据";
                [cell.indicatorView stopAnimating];
            }else{
                cell.label.text = @"加载中";
                [cell.indicatorView startAnimating];
                if (!isGetData && arrayOfPopular.count != 0) {
                    [self loadDataPopular];
                }
            }
            return cell;
        }
    }
    
    
    static NSString *reuserIndentifer = @"Cell";
    HealthPlan *plan;
    if (tableView.tag == 10) {
        plan = [arrayOfTime objectAtIndex:indexPath.row];
    }else{
        plan = [arrayOfPopular objectAtIndex:indexPath.row];
    }
    
    RTImportPlanTableViewCell *cell = [[RTImportPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifer WithData:plan];
    if (tableView.tag == 10) {
        cell.importnumber.hidden = YES;
        cell.timeLabel.hidden = NO;
    }else{
        cell.importnumber.hidden = NO;
        cell.timeLabel.hidden = YES;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HealthPlan *planInfo;
    if (tableView.tag == 10) {
        
        if (indexPath.row >= arrayOfTime.count){
            return;
        }
        planInfo = [arrayOfTime objectAtIndex:indexPath.row];
    }else{
        if (indexPath.row >= arrayOfPopular.count){
            return;
        }
        planInfo = [arrayOfPopular objectAtIndex:indexPath.row];
        
    }
    RTPlanDetailViewController *detail = [[RTPlanDetailViewController alloc]initWith:planInfo Type:2];
    [self.navigationController pushViewController:detail animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 10) {
        if (arrayOfTime.count < 20) {
            return arrayOfTime.count;
        }
        return arrayOfTime.count + 1;
    }else{
        if (arrayOfPopular.count < 20) {
            return arrayOfPopular.count;
        }
        return arrayOfPopular.count + 1;
    }
}
- (void)clickItemAtIndex:(NSInteger)index
{
    [popoverview dismiss];
    currentSelect = index;
    NSLog(@"click Item");
    [self refreshTitle];
    [self refreshDataTime];
    [self refreshDataPopular];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (currentIndex == 1) {
        
        [_refreshHeaderView_time egoRefreshScrollViewDidScroll:scrollView];
    }else{
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (currentIndex == 1) {
        [_refreshHeaderView_time egoRefreshScrollViewDidEndDragging:scrollView];
    }else{
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (currentIndex == 1) {
        [_refreshHeaderView_time egoRefreshScrollViewDidEndDragging:scrollView];
    }else{
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)reloadTableViewDataSource{
    if (currentIndex == 1) {
        _reloading_time = YES;
        [self refreshDataTime];
    }else{
        _reloading = YES;
        [self refreshDataPopular];
    }
}

- (void)doneLoadingTableViewData{
    if (currentIndex == 1) {
        _reloading_time = NO;
        [tableviewTime reloadData];
        [_refreshHeaderView_time egoRefreshScrollViewDataSourceDidFinishedLoading:tableviewTime];
    }else{
        _reloading = NO;
        [tableviewPopularity reloadData];
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableviewPopularity];
    }
    
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    if (currentIndex == 1) {
        return _reloading_time;
    }else{
        return _reloading; // should return if data source model is reloading
    }
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}
@end
