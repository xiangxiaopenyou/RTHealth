//
//  RTRealationshipTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/12/19.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTRealationshipTableViewCell : UITableViewCell{
    FriendsInfo *friendInfo;
    UIButton *btn;
}

@property (nonatomic,strong) UILabel *labelSort;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(FriendsInfo*)friendinfo;

@end
