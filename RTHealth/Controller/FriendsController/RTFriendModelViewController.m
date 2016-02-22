//
//  RTFriendModelViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/7.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFriendModelViewController.h"
#import "RTLastTableViewCell.h"

@interface RTFriendModelViewController ()

@end

@implementation RTFriendModelViewController

@synthesize tableview = tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showMore = NO;
    self.loading = NO;
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableview];
    
    if (_refreshHeaderView ==nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, 0-tableview.bounds.size.height, tableview.frame.size.width, tableview.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [tableview addSubview:_refreshHeaderView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [tableview setContentOffset:CGPointMake(0,-70) animated:YES];
//    [self refreshTable];
}
- (void)refreshTable{
}

- (void)loadMoreData{
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
    [self.tableview reloadData];
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableview];
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


#pragma mark - UITableView Delegate DataSource

- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPanth
{
    
    static NSString *reuserIndentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier];
    return  cell;
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= self.dataArray.count) {
        RTLastTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"LastCell"];
        if (cell == nil) {
            cell = [[RTLastTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LastCell"];
        }
        if (self.showMore) {
            cell.label.text = @"没有更多数据";
            [cell.indicatorView stopAnimating];
        }else if (!self.showMore){
            cell.label.text = @"加载中";
            NSLog(@"加载");
            [cell.indicatorView startAnimating];
            if (!self.loading) {
                [self loadMoreData];
            }
        }
        return cell;

    }else{
        return [self cellAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= self.dataArray.count) {
        return ;
        
    }else{
        return [self didSelectAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
    if (indexPath.row >= self.dataArray.count) {
        return 60;
        
    }else{
        return [self cellHeightAtIndexPath:indexPath];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count<NUMBER_CELL){
        return self.dataArray.count;
    }
    return self.dataArray.count+1;
}

@end
