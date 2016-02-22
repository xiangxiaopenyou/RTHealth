//
//  RTPhotoNominateTableViewCell.m
//  RTHealth
//
//  Created by cheng on 15/1/7.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTPhotoNominateTableViewCell.h"

@implementation RTPhotoNominateTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 310, 95)];
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
