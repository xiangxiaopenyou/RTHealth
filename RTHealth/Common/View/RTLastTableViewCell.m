//
//  RTLastTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/11/25.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTLastTableViewCell.h"

@implementation RTLastTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.indicatorView = [[UIActivityIndicatorView alloc]init];
        self.indicatorView.frame = CGRectMake(115, 12, 20, 20);
        self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:self.indicatorView];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(100, 12, 120, 20)];
        self.label.text = @"加载中";
        self.label.font = [UIFont systemFontOfSize:12.0];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        [self addSubview:self.label];
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
