//
//  RTCountView.m
//  RTHealth
//
//  Created by cheng on 15/1/8.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTCountView.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation RTCountView

- (id)initWithFrame:(CGRect)frame time:(long)timelong{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.timecount = timelong;
        
        UIView *viewCount = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [self addSubview:viewCount];
        
        UILongPressGestureRecognizer *tapGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnView:)];
        [viewCount addGestureRecognizer:tapGesture];
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        _progress = 0.0;
        _progressTrack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
        [_progressTrack setBackgroundColor:[UIColor colorWithRed:176/255.0 green:77/255.0 blue:58/255.0 alpha:1.0]];
        [viewCount addSubview:_progressTrack];
        
        self.counterLabel = [[RTCounterLaebl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [self.counterLabel setBoldFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20]];
        [self.counterLabel setRegularFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
        
        // The font property of the label is used as the font for H,M,S and MS
        [self.counterLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:12]];
        
        // Default label properties
        self.counterLabel.textColor = [UIColor whiteColor];
        self.counterLabel.countDirection = kCountDirectionDown;
        self.counterLabel.startValue = self.timecount;
        self.counterLabel.delegate = self;
        // After making any changes we need to call update appearance
        [self.counterLabel updateApperance];
        [viewCount addSubview:self.counterLabel];
        
        [self.counterLabel progressReturn:^(float number){
            _progress = number;
            
            if (0.0f <= _progress && _progress < 1.1f)
            {
                float units = self.frame.size.width / 1;
                
                [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^
                 {
                     _progressTrack.frame = CGRectMake(0, 0, units * _progress, self.frame.size.height);
                 }
                                 completion:nil];
            }else if (_progress >= 1.1f){
                float units = self.frame.size.width / 1;
                [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^
                 {
                     _progressTrack.frame = CGRectMake(0, 0, units, self.frame.size.height);
                 }
                                 completion:nil];
            }
        }];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 75, 0, 65, 39)];
        imageView.image = [UIImage imageNamed:@"stopcount.png"];
        [self addSubview:imageView];

        startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        startBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        [startBtn setBackgroundImage:[UIImage imageNamed:@"startcount.png"] forState:UIControlStateNormal];
        [startBtn addTarget:self action:@selector(clickCount:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
    }
    return self;
}

- (void)clickCount:(id)sender{
    [startBtn setHidden:YES];
    [self.counterLabel start];
}

- (void)tapOnView:(UIGestureRecognizer*)gestureRecognizer{
    
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
        
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        //暂停开始
        if (self.counterLabel.isRunning) {
            [self.counterLabel stop];
            [startBtn setHidden:NO];
        }else{
            [self.counterLabel start];
        }
    }
    
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
        
    {
    }
    
    else if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
        
    {
    }
}

#pragma mark -  RTCounterLabel Delegate

- (void)countDidEnd{
    
    float units = self.frame.size.width / 1;
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^
     {
         _progressTrack.frame = CGRectMake(0, 0, units, self.frame.size.height);
     }
                     completion:nil];
    
    [self.delegate timerDidEnd];
}

- (void)stop{
    [self.counterLabel stop];
}
@end
