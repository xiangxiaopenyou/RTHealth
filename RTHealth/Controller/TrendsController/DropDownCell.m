//
//  DropDownCell.m
//  RTHealth
//
//  Created by 项小盆友 on 14/10/23.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "DropDownCell.h"


@implementation DropDownCell

@synthesize textLabel, arrow_up, arrow_down, isOpen;

- (void) setOpen 
{
    [arrow_down setHidden:YES];
    [arrow_up setHidden:NO];
    [self setIsOpen:YES];
}

- (void) setClosed
{
    [arrow_down setHidden:NO];
    [arrow_up setHidden:YES];
    [self setIsOpen:NO];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
