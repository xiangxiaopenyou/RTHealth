//
//  RTPersonalInfoTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTPersonalInfoTableViewCellDelegate <NSObject>
@optional

- (void)clickHeadImageView:(UIImageView*)image;
- (void)clickMyFans;
- (void)clickMyAttention;

@end

@interface RTPersonalInfoTableViewCell : UITableViewCell

@property (nonatomic,strong) UserInfo *userinfo;
@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) UILabel *labelPoint;
@property (nonatomic,strong) UILabel *labelInstruction;
@property (nonatomic,strong) UIImageView *imageLeft;
@property (nonatomic,strong) UIImageView *imagesex;
@property (nonatomic,strong) UILabel *labelName;
@property (nonatomic,strong) UILabel *labelAge;
@property (nonatomic,strong) UIButton *fansBtn;
@property (nonatomic,strong) UIButton *attentionBtn;

@property (nonatomic,assign) id<RTPersonalInfoTableViewCellDelegate>delegate;

@end
