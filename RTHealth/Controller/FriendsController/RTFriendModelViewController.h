//
//  RTFriendModelViewController.h
//  RTHealth
//
//  Created by cheng on 14/11/7.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTFriendRequest.h"
#import "RTMessageRequest.h"

@interface RTFriendModelViewController : UIViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,assign) BOOL showMore;
@property (nonatomic,assign) BOOL loading;

/*
 下拉刷新数据
 */
- (void)refreshTable;
/*
 加载更多数据
 */
- (void)loadMoreData;
/*
 返回IndexPath下的CellView
 */
- (UITableViewCell*)cellAtIndexPath:(NSIndexPath*)indexPath;
/*
 返回cell高度
 */
- (CGFloat)cellHeightAtIndexPath:(NSIndexPath*)indexPath;
/*
点击事件
 */
- (void)didSelectAtIndexPath:(NSIndexPath*)indexPath;

- (void)doneLoadingTableViewData;
@end
