//
//  RTStartPlanTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/10/31.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTStartPlanTableViewCell : UITableViewCell{
    HealthPlan *healthPlan;
}

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *progressLabel;
@property (nonatomic,strong) UIImageView *progressImageView;
@property (nonatomic,strong) UIImageView *imageview;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(HealthPlan*)plan;
@end
