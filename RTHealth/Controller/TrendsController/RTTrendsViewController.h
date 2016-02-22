//
//  RTTrendsViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/10/23.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTTrendsViewController : UIViewController<EGORefreshTableHeaderDelegate, UIScrollViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

//@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
//@property (strong, nonatomic) IBOutlet UIImageView *selectImage;

//- (IBAction)selectButtonClick:(id)sender;

@property (nonatomic, strong) UITableView *trendsTableView;

@property (nonatomic, strong) NSMutableArray *trendsListArray;

@end
