//
//  RTPersonalSmallPlanTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBFPopFlatButton.h"

@interface RTPersonalSmallPlanTableViewCell : UITableViewCell<LXActivityDelegate>{
    CGSize framesize;
    UILabel *contentLabel;
    UILabel *labelOfMark;
    UIImageView *typeImageView;
    UILabel *timeLabel;
    UILabel *costLabel;
    
    UILabel *finishLabel;
    VBFPopFlatButton *modifyButton;
    
    UIView *background;
    SmallHealthPlan *smallPlanData;
    
    NSInteger clickIndex;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(SmallHealthPlan*)smallPlandata;
- (float)getheight;

@end
