//
//  RTFriendSmallPlanTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFriendSmallPlanTableViewCell : UITableViewCell{
    CGSize framesize;
    UILabel *contentLabel;
    UILabel *labelOfMark;
    UIImageView *typeImageView;
    UILabel *stateLabel;
    UILabel *timeLabel;
    UILabel *costLabel;
    UILabel *finishLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(SmallHealthPlan*)smallPlanData;
- (float)getheight;

@end
