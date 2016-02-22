//
//  RTUnderwayActivityTableViewCell.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/3.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTUnderwayActivityTableViewCell : UITableViewCell{
    Activity *healthActivity;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *numberCount;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(Activity*)activity;
@end
