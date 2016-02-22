//
//  RTSearchViewController.m
//  RTHealth
//
//  Created by cheng on 14/12/23.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTSearchViewController.h"
#import "RTRealationshipTableViewCell.h"
#import "RTDiscoverRequest.h"
#import "RTFriendInfoTableViewController.h"

@interface RTSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate>{
    NSMutableArray *dataArray;
    UITableView *tableview;
    UISearchBar *searchbar;
}

@end

@implementation RTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArray = [[NSMutableArray alloc]init];
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"查找";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    tableview = [[UITableView alloc]init];
    tableview.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT+44, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT - 44);
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 320, 44)];
    searchbar.placeholder = @"请输入用户昵称或手机号";
    searchbar.delegate = self;
    [searchbar becomeFirstResponder];
    [self.view addSubview:searchbar];
    
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
- (void)loadMoreData{
    
}
#pragma mark - UITableView Delegate DataSource

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuserIndentifier = @"Cell";
    if (indexPath.row >= dataArray.count) {
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
        RTRealationshipTableViewCell *cell = [[RTRealationshipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:[dataArray objectAtIndex:indexPath.row]];
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RTFriendInfoTableViewController *friendInfoController = [[RTFriendInfoTableViewController alloc]init];
    friendInfoController.friendInfo = [dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:friendInfoController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataArray.count<NUMBER_CELL){
        return dataArray.count;
    }
    return dataArray.count;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (searchbar) {
        [searchbar resignFirstResponder];
    }
}
#pragma UISearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [dataArray removeAllObjects];
    [RTDiscoverRequest getSearchWithArray:dataArray Key:searchbar.text success:^(id response){
        [tableview reloadData];
    } failure:^(NSError *error){
        [tableview reloadData];
    }];
}

@end
