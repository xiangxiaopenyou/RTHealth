//
//  RTTrendDetailViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/5.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RTTrendDetailDelegate <NSObject>
@optional
- (void)clickLabel:(NSString*)labelString;
@end

@interface RTTrendDetailViewController : UIViewController


@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIButton *nicknameButton;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIView *picView;
@property (nonatomic, strong) UIImageView *smallPicView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *discussLabel;
@property (nonatomic, strong) UIButton *discussButton;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic ,strong) UILabel *forwardLabel;
@property (nonatomic, strong) UIButton *forwardButton;
@property (nonatomic, strong) Trends *trend;
@property (nonatomic, strong) NSArray *commentArray;

@property (nonatomic, strong) id<RTTrendDetailDelegate>delegate;
@end
