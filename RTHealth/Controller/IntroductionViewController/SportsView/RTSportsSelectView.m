//
//  RTSportsSelectView.m
//  RTHealth
//
//  Created by 项小盆友 on 15/1/6.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTSportsSelectView.h"

#define PI 3.14159265358979323846

@implementation RTSportsSelectView



- (id)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selected = NO;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 36, 36)];
        [self addSubview:self.imageView];
        
        self.labelName = [[UILabel alloc]initWithFrame:CGRectMake(0, 43, 46, 12)];
        self.labelName.textAlignment = NSTextAlignmentCenter;
        self.labelName.font = SMALLFONT_10;
        [self addSubview:self.labelName];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.selected) {
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
        CGContextSetRGBStrokeColor(context,58.0/255.0, 147.0f/255.0, 209.0f/255.0,  1.0);
        CGContextAddArc(context, 23, 23, 17.5, 0, 2*PI, 0);CGContextSetLineWidth(context, 4.0);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
