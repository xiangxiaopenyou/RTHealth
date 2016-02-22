//
//  RTFriendInfoTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RTFriendInfoTableViewCellDelegate <NSObject>
@optional

- (void)clickFriendHeadImageView:(UIImageView*)image;
- (void)clickHisFans;
- (void)clickHisAttention;

@end


@interface RTFriendInfoTableViewCell : UITableViewCell{
    UIButton *attentionBtn;
}

@property (nonatomic,strong) FriendsInfo *friendInfo;
@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) UILabel *labelPoint;
@property (nonatomic,strong) UILabel *labelInstruction;
@property (nonatomic,strong) UIImageView *imageLeft;
@property (nonatomic,strong) UIImageView *imagesex;
@property (nonatomic,strong) UILabel *labelName;
@property (nonatomic,strong) UILabel *labelAge;
@property (nonatomic,strong) UIButton *fansBtn;
@property (nonatomic,strong) UIButton *attentionBtn;

@property (nonatomic,assign) id<RTFriendInfoTableViewCellDelegate>delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(FriendsInfo*)friendInfo;
@end
