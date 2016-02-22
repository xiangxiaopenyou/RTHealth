//
//  RTLevelView.m
//  RTHealth
//
//  Created by cheng on 14/10/31.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTLevelView.h"

@implementation RTLevelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithLevel:(NSInteger)index
{
    self = [super init];
    
    if (self) {
        if (index <= 5 && index >= 0) {
            for (int i = 0; i < 5; i ++) {
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(i*14, 0, 13, 13)];
                if (i < index) {
                    image.image = [UIImage imageNamed:@"level_01.png"];
                }else{
                    image.image = [UIImage imageNamed:@"level_02.png"];
                }
                [self addSubview:image];
            }
        }
    }
    
    return self;
}

@end
