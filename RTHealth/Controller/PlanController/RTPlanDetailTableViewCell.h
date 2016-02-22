//
//  RTPlanDetailTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTPlanDetailTableViewCell : UITableViewCell{
    CGSize framesize;
    HealthPlan *healthPlan;
}

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *progressLabel;
@property (nonatomic,strong) UIImageView *progressImageView;
@property (nonatomic,strong) UIImageView *imageview;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(HealthPlan*)plan;

@end
