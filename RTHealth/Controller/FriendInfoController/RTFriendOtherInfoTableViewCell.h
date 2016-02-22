//
//  RTFriendOtherInfoTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTFriendOtherInfoTableViewCellDelegate <NSObject>

@optional

- (void)clickfriendPlan;
- (void)clickfriendTrend;
- (void)clickfriendActivity;

@end
@interface RTFriendOtherInfoTableViewCell : UITableViewCell{
    FriendsInfo *friendInfo;
}
@property (nonatomic,assign) id<RTFriendOtherInfoTableViewCellDelegate>delegate;

@property (nonatomic,strong) UILabel *fansLabel;
@property (nonatomic,strong) UILabel *attentionLabel;
@property (nonatomic,strong) UILabel *activityLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(FriendsInfo*)InfoData;

@end
