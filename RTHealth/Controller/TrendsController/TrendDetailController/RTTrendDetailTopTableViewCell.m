//
//  RTTrendDetailTopTableViewCell.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/6.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTTrendDetailTopTableViewCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@implementation RTTrendDetailTopTableViewCell

@synthesize  headImageView, nicknameLabel, nicknameButton, userTypeLabel, timeLabel, projectTypeImage, picView;
@synthesize trendT;
@synthesize pictureArray;
@synthesize smallImageView = _smallImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithData:(Trends *)trend
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        trendT = trend;
        int height = 0;
        
        //头像
        headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, height + 4, 40, 40)];
        [headImageView setOnlineImage:[RTUtil urlPhoto:trend.userphoto]];
        headImageView.layer.masksToBounds = YES;
        headImageView.layer.cornerRadius = 20;
        headImageView.layer.borderWidth = 1;
        headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        UITapGestureRecognizer *clickHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClicked:)];
        [headImageView addGestureRecognizer:clickHead];
        headImageView.userInteractionEnabled = YES;
        [self addSubview:headImageView];
        
        //昵称
        CGSize nicknameSize = [trend.usernickname sizeWithFont:SMALLFONT_12];
        nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(62, height+8, nicknameSize.width, nicknameSize.height)];
        nicknameLabel.text = trend.usernickname;
        if ([trend.usersex integerValue] == 1) {
            nicknameLabel.textColor = [UIColor colorWithRed:6/255.0 green:84/255.0 blue:165/255.0 alpha:1.0];
        }
        else{
            nicknameLabel.textColor = [UIColor colorWithRed:232/255.0 green:68/255.0 blue:135/255.0 alpha:1.0];
        }
        nicknameLabel.textAlignment = NSTextAlignmentLeft;
        nicknameLabel.font = SMALLFONT_12;
        [self addSubview:nicknameLabel];
        
        nicknameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        nicknameButton.frame = nicknameLabel.frame;
        [nicknameButton addTarget:self action:@selector(nicknameClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nicknameButton];
        
        //用户类型
        userTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(62 + nicknameSize.width, height + 8, 50, nicknameSize.height)];
        
        if (![RTUtil isEmpty:trend.usertype]) {
            if ([trend.usertype isEqualToString:@"2"]) {
                userTypeLabel.text = @"(教练)";
                userTypeLabel.textColor = [UIColor colorWithRed:202/255.0 green:103/255.0 blue:22/255.0 alpha:1.0];
            }
            else if([trend.usertype isEqualToString:@"3"]){
                userTypeLabel.text = @"(达人)";
                userTypeLabel.textColor = [UIColor colorWithRed:35/255.0 green:160/255.0 blue:57/255.0 alpha:1.0];
            }
            else{
                userTypeLabel.text = @"";
            }
        }
        userTypeLabel.textAlignment = NSTextAlignmentLeft;
        userTypeLabel.font = SMALLFONT_12;
        [self addSubview:userTypeLabel];
        
        //发布时间
        UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(62, height + 19 + nicknameSize.height, 10, 10)];
        timeImage.image = [UIImage imageNamed:@"time.png"];
        [self addSubview:timeImage];
        
        timeLabel = [[UILabel alloc] init];
        NSString *timeString;
        NSDate *date = [CustomDate getTimeDate:trend.trendtime];
        if ([[CustomDate compareDate:date] isEqualToString:@"今天"]) {
            timeString = [trend.trendtime substringWithRange:NSMakeRange(11, 5)];
        }
        else if ([[CustomDate compareDate:date] isEqualToString:@"昨天"]){
            timeString = @"昨天";
            //timeString = [timeString stringByAppendingString:@" "];
            timeString = [timeString stringByAppendingString:[trend.trendtime substringWithRange:NSMakeRange(11, 5)]];
        }
        else{
            timeString = [trend.trendtime substringWithRange:NSMakeRange(5, 11)];
        }
        CGSize timeSize = [timeString sizeWithFont:SMALLFONT_10];
        timeLabel.frame = CGRectMake(73, height + 18 + nicknameSize.height, timeSize.width, timeSize.height);
        timeLabel.text = timeString;
        timeLabel.font = SMALLFONT_10;
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        [self addSubview:timeLabel];
        
        //项目类型
        projectTypeImage = [[UIImageView alloc] init];
        projectTypeImage.frame = CGRectMake(SCREEN_WIDTH - 36, height + 10, 24, 24);
        projectTypeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%@.png", trend.trendtype]];
        projectTypeImage.layer.masksToBounds = YES;
        projectTypeImage.layer.cornerRadius = 12;
        projectTypeImage.layer.borderWidth = 1;
        projectTypeImage.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:projectTypeImage];
        
        height += 56;
        
        //文字内容
        [self addSubview:self.contentLabel];
        self.contentLabel.frame = CGRectMake(10, height + 5, SCREEN_WIDTH - 20, 15);
        [self.contentLabel sizeToFit];
        
        height += self.contentLabel.frame.size.height + 5;
        
        //图片内容
        NSString *imageString = trend.trendphoto;
        if (![RTUtil isEmpty:imageString]) {
            picView = [[UIView alloc] init];
            [picView setBackgroundColor:[UIColor clearColor]];
            [self addSubview:picView];
            pictureArray = [imageString componentsSeparatedByString:@";"];
            height += 10;
            int x = 0;
            int num = (int)pictureArray.count/3;
            int heightImage =(SCREEN_WIDTH - 30)/3;
            for (UIView *subView in picView.subviews) {
                //避免重用
                [subView removeFromSuperview];
            }
            float picViewHeight = (num + 1) * (heightImage + 3);
            picView.frame = CGRectMake(12, height + 5, SCREEN_WIDTH - 24, picViewHeight);
            height += picViewHeight + 10;
            
            if (pictureArray.count%3 == 0) {
                height -=heightImage+3;
            }
            
            for (int i=0; i<pictureArray.count; i++) {
                NSString *strUrl = [pictureArray objectAtIndex:i];
                //NSLog(@"%@", strUrl);
                _smallImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, (i/3)*(heightImage+3), heightImage, heightImage)];
                _smallImageView.contentMode = UIViewContentModeScaleAspectFill;
                _smallImageView.clipsToBounds = YES;
                _smallImageView.userInteractionEnabled = YES;
                //[_smallImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]]]];
                [_smallImageView setOnlineImage:[RTUtil urlZoomPhoto:strUrl]];
                _smallImageView.tag = i;
                [_smallImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smallImagesTap:)]];
                x+=heightImage+3;
                if ((i+1)%3 == 0) {
                    x = 0;
                }
                [picView addSubview:_smallImageView];
            }
        }
        //位置信息
        if(![RTUtil isEmpty:trend.useraddress]){
            UIImageView *positionImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, height + 5, 15, 15)];
            positionImage.image = [UIImage imageNamed:@"activity_distance.png"];
            [self.contentView addSubview:positionImage];
            
            UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, height + 5, SCREEN_WIDTH - 40, 15)];
            positionLabel.text = trend.useraddress;
            positionLabel.textColor = [UIColor colorWithRed:45/255.0 green:173/255.0 blue:226/255.0 alpha:1.0];
            positionLabel.font = [UIFont systemFontOfSize:10];
            positionLabel.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:positionLabel];
            height += 25;
        }
        
        //底部分割
        UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 10)];
        bottomView.image = [UIImage imageNamed:@"bottom_line.png"];
        [self addSubview:bottomView];
        height += 10;
    }
    return self;
}


- (MLEmojiLabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[MLEmojiLabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = SMALLFONT_14;
        _contentLabel.emojiDelegate = self;
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLabel.isNeedAtAndPoundSign = YES;
        NSString *contentString = trendT.trendclassify;
        if (![RTUtil isEmpty:contentString]) {
            contentString = [contentString stringByAppendingString:trendT.trendcontent];
        }
        else
        {
            contentString = trendT.trendcontent;
        }
        _contentLabel.emojiText = contentString;
    }
    
    return _contentLabel;
}



- (int)heightWith:(Trends *)trend
{
    int height = 56;
    height += self.contentLabel.frame.size.height + 5;
    
    NSString *imageString = trend.trendphoto;
    if (![RTUtil isEmpty:imageString]) {
        pictureArray = [imageString componentsSeparatedByString:@";"];
        height += [self heightPic:pictureArray];
    }
    if (![RTUtil isEmpty:trend.useraddress]) {
        
        height += 25;
    }
    height += 10;
    
    return height;
}
- (int)heightPic:(NSArray*)picArray
{
    
    int height = 5;
    int num = (int)[picArray count]/3;
    int heightImage = (SCREEN_WIDTH - 30)/3;
    height += ((num+1) * (heightImage+3)) + 10;
    if (picArray.count % 3 == 0) {
        height -= heightImage + 3;
    }
    
    return height;
    
    
}

- (void)headClicked:(UITapGestureRecognizer*)gesture
{
    NSLog(@"点击了头像");
    
    [self.delegate clickHeadImage:trendT.userid];
}

- (void)nicknameClick
{
    NSLog(@"点击了昵称");
    [self.delegate clickNicknameButton:trendT.userid];
}

- (void)smallImagesTap:(UITapGestureRecognizer*)gesture
{
    NSLog(@"点击了缩略图");
    NSInteger imageCount = pictureArray.count;
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:imageCount];
    for (int i = 0; i < imageCount; i ++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:[RTUtil urlPhoto:pictureArray[i]]];
        photo.srcImageView = picView.subviews[i];
        [photos addObject:photo];
    }
    NSLog(@"%@", photos);
    //显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = gesture.view.tag;
    browser.photos = photos;
    [browser show];
    [self.delegate clickSmallPicView];
}
#pragma mark - MLEmojiLabel Delegate
- (void)mlEmojiLabel:(MLEmojiLabel *)emojiLabel didSelectLink:(NSString *)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL:
            NSLog(@"点击了链接%@",link);
            break;
        case MLEmojiLabelLinkTypePhoneNumber:
            NSLog(@"点击了电话%@",link);
            break;
        case MLEmojiLabelLinkTypeEmail:
            NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt:
            NSLog(@"点击了用户%@",link);
            break;
        case MLEmojiLabelLinkTypePoundSign:
            NSLog(@"点击了话题%@",link);
            [self.delegate clickTrendClassify:link];
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
