//
//  RTChatMessageTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/11/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTChatMessageTableViewCell.h"

@implementation RTChatMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 50, 50)];
        _imageview.layer.cornerRadius = 20;
        _imageview.layer.masksToBounds = YES;
        [self addSubview:_imageview];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(65, 10, 150, 40)];
        _label.font = VERDANA_FONT_16;
        _label.textColor = [UIColor blackColor];
        [self addSubview:_label];
        
        
        _labelnotread = [[UILabel alloc]initWithFrame:CGRectMake(260, 30-12.5, 25, 25)];
        _labelnotread.backgroundColor = [UIColor redColor];
        _labelnotread.layer.cornerRadius = 12.5;
        _labelnotread.layer.masksToBounds = YES;
        _labelnotread.font = VERDANA_FONT_10;
        _labelnotread.textAlignment = NSTextAlignmentCenter;
        _labelnotread.textColor = [UIColor whiteColor];
        [self addSubview:_labelnotread];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
