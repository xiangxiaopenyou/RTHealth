//
//  RTRecommendedPlanTableViewCell.h
//  RTHealth
//
//  Created by 项小盆友 on 15/1/7.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTRecommendedPlanTableViewCell : UITableViewCell{
    BOOL isImport;
    HealthPlan *healthPlan;
}

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) NSDictionary *planDic;
@property (nonatomic, strong) UIButton *button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDic:(NSDictionary *)dictionary;

@end
