//
//  RTFriendsTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/11/6.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFriendsTableViewCell : UITableViewCell{
    FriendsInfo *friendInfo;
    UIButton *btn;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(FriendsInfo*)friendinfo;

@end
