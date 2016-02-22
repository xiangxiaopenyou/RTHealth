//
//  RTActivityTableViewCell.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTActivityTableViewCell : UITableViewCell{
    Activity *healthActivity;
}


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *timeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(Activity*)activity;

@end
