//
//  RTOwnPlanTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/10/31.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTOwnPlanTableViewCellDelegate <NSObject>

- (void)shouldReload;

@end

@interface RTOwnPlanTableViewCell : UITableViewCell{
    
    HealthPlan *healthPlan;
}
@property (nonatomic,strong) HealthPlan *healthPlan;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,assign) id<RTOwnPlanTableViewCellDelegate>delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(HealthPlan*)plan;

@end
