//
//  RTPersonalOtherInfoTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTPersonalOtherInfoTableViewCellDelegate <NSObject>

@optional

- (void)clickMyPlan;
- (void)clickMyTrend;- (void)clickMyActivity;

@end

@interface RTPersonalOtherInfoTableViewCell : UITableViewCell{
    UserInfo *userinfo;
}

@property (nonatomic,assign) id<RTPersonalOtherInfoTableViewCellDelegate>delegate;

@property (nonatomic,strong) UILabel *fansLabel;
@property (nonatomic,strong) UILabel *attentionLabel;
@property (nonatomic,strong) UILabel *activityLabel;

@end
