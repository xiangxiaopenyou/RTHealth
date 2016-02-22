//
//  RTPlanKindTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/12/8.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPlanKindTableViewCell.h"

@implementation RTPlanKindTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.kindImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 6, 31, 31)];
        [self addSubview:self.kindImageView];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(320-105, 0, 80, 44)];
        self.nameLabel.font = VERDANA_FONT_12;
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.nameLabel];
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
