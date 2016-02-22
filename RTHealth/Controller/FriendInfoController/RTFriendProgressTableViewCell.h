//
//  RTFriendProgressTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFriendProgressTableViewCell : UITableViewCell{
    UIImageView *progressImage;
    UILabel *progressLabel;
    UILabel *labelDays;
}

@property (nonatomic,strong) UILabel *titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(FriendsInfo*)friendInfo;

@end
