//
//  RTNominateTableViewCell.m
//  RTHealth
//
//  Created by cheng on 15/1/5.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTNominateTableViewCell.h"

@implementation RTNominateTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 250, 22)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [self addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 22, 250, 32)];
        self.contentLabel.font = VERDANA_FONT_12;
        self.contentLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        self.contentLabel.numberOfLines = 0;
        [self addSubview:self.contentLabel];
        
        self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 45)];
        [self addSubview:self.photoImage];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
