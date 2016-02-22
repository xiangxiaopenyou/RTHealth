//
//  RTSmallPlanTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTSmallPlanTableViewCell : UITableViewCell{
    
    CGSize framesize;
    UILabel *contentLabel;
    UILabel *labelOfMark;
    UIImageView *typeImageView;
    UILabel *stateLabel;
    UILabel *timeLabel;
    UILabel *costLabel;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(SmallHealthPlan*)smallPlanData;
@end
