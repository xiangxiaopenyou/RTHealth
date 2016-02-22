//
//  RTTrendsTableViewCell.h
//  RTHealth
//
//  Created by 项小盆友 on 14/10/27.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLEmojiLabel.h"
#import "RTDiscussViewController.h"
@protocol RTTrendsTableViewCellDelegate <NSObject>
@optional

- (void)clickHeadImage:(NSString*)userid;
- (void)clickSmallImage;
- (void)clickNicknameButton:(NSString*)userid;
- (void)clickDiscussButton;
- (void)clickLikeButton;
- (void)clickForwardButton;
- (void)clickTrendsClassfy:(NSString*)classify;
- (void)clickDeleteButton;

@end

@interface RTTrendsTableViewCell : UITableViewCell<MLEmojiLabelDelegate, RTCommentViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate, LXActivityDelegate>
{
    Trends *trendT;
    
    UILabel *discussLabel;
    UIImageView *discussImage;
    UILabel *likeLabel;
    UIImageView *likeImage;
    UILabel *forwardLabel;
    UIImageView *forwardImage;
    UILabel *labelline;
    UILabel *labelline1;
    UIImageView *endView;
    UILabel *line;
    UserInfo *userinfo;
}

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *headImageView;  //头像
@property (nonatomic, strong) UILabel *nicknameLabel; //昵称
@property (nonatomic, strong) UILabel *userTypeLabel; //用户类型
@property (nonatomic, strong) UIButton *nicknameButton;
@property (nonatomic, strong) UILabel *timeLabel;  //发布时间
@property (nonatomic, strong) UIImageView *projectType; //项目类型
@property (nonatomic, strong) MLEmojiLabel *contentLabel;  //内容
@property (nonatomic, strong) UIView *pictureView;  //图片内容
@property (nonatomic, strong) UIImageView *smallImageView; //缩略图
@property (nonatomic, strong) UIView *bottomView;  //底部评论点赞转发
@property (nonatomic, strong) UIButton *discussButton;  //评论按钮
@property (nonatomic, strong) UIButton *likeButton;  //点赞按钮
@property (nonatomic, strong) UIButton *forwardButton; //转发按钮
@property (nonatomic, strong) NSArray *pictureArray;

@property (nonatomic, assign) id<RTTrendsTableViewCellDelegate>delegate;

@property (nonatomic, assign)NSInteger iHeihgt;
@property (nonatomic, assign) NSInteger imageTag;
@property (nonatomic, strong) NSMutableArray *photos;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithData:(Trends*)trend;


//算出高度
- (int)heightWith:(Trends *)trend;

//根据图片内容计算高度
//+ (int) heightText:(NSString *)text withpicArray:(NSArray*)picArray;
- (int)heightPic:(NSArray*)picArray;


@end
