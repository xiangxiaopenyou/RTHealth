//
//  RTImportNumber.m
//  RTHealth
//
//  Created by cheng on 14/10/31.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTImportNumber.h"

@implementation RTImportNumber
- (id)initWithImportNumber:(NSString*)string
{
    self = [super init];
    
    if (self) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 11)];
        imageview.image = [UIImage imageNamed:@"renqi"];
        [self addSubview:imageview];
        
        UILabel *labelNumber = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 11)];
        labelNumber.text = string;
        labelNumber.textColor = [UIColor lightGrayColor];
        labelNumber.font = VERDANA_FONT_10;
        [self addSubview:labelNumber];
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
