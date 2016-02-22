//
//  RTTrendDetailTopTableViewCell.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/6.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLEmojiLabel.h"
@protocol RTTrendDetailTopTableViewCellDelegate <NSObject>
@optional

- (void)clickHeadImage:(NSString*)idString;
- (void)clickNicknameButton:(NSString*)idString;
- (void)clickSmallPicView;
- (void)clickTrendClassify:(NSString*)classifyString;

@end

@interface RTTrendDetailTopTableViewCell : UITableViewCell<MLEmojiLabelDelegate>{
    
}

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UIButton *nicknameButton;
@property (nonatomic, strong) UILabel *userTypeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *projectTypeImage;
@property (nonatomic, strong) MLEmojiLabel *contentLabel;
@property (nonatomic, strong) UIView *picView;
@property (nonatomic, strong) Trends *trendT;
@property (nonatomic, strong) NSArray *pictureArray;
@property (nonatomic, strong) UIImageView *smallImageView;

@property (nonatomic, assign) id<RTTrendDetailTopTableViewCellDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithData:(Trends*)trend;

//设置内容
//- (void)setContent:(NSMutableDictionary *)dictionary;

//计算高度
- (int)heightWith:(Trends *)trend;

@end
