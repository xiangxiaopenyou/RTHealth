//
//  RTImportPlanTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/11/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTImportNumber.h"

@interface RTImportPlanTableViewCell : UITableViewCell{
    HealthPlan *healthPlan;
}
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) RTImportNumber *importnumber;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithData:(HealthPlan*)plan;

@end
