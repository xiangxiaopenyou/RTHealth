//
//  RTProjectSelectView.m
//  RTHealth
//
//  Created by cheng on 14/11/24.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTProjectSelectView.h"

#define PI 3.14159265358979323846


@implementation RTProjectSelectView

- (id)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selected = NO;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self addSubview:self.imageView];
        
        self.labelName = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 60, 25)];
        self.labelName.textAlignment = NSTextAlignmentCenter;
        self.labelName.font = VERDANA_FONT_14;
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
        CGContextAddArc(context, 40, 40, 30, 0, 2*PI, 0);CGContextSetLineWidth(context, 5.0);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

@end
