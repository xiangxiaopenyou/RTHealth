//
//  RTTrendsTableViewCell.m
//  RTHealth
//
//  Created by 项小盆友 on 14/10/27.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTTrendsTableViewCell.h"
#import <CoreText/CoreText.h>
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "RTTrendDetailViewController.h"
#import "RTTrendsRequest.h"


@implementation RTTrendsTableViewCell

@synthesize headView=_headView,headImageView=_headImageView,nicknameLabel=_nicknameLabel, userTypeLabel = _userTypeLabel, nicknameButton = _nicknameButton,  timeLabel=_timeLabel,projectType = _projectType, pictureView=_pictureView, smallImageView = _smallImageView;
@synthesize bottomView;
@synthesize discussButton;
@synthesize likeButton;
@synthesize forwardButton;
@synthesize iHeihgt;
@synthesize pictureArray;
@synthesize imageTag;
@synthesize photos;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithData:(Trends *)trend
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        RTUserInfo *userData = [RTUserInfo getInstance];
        userinfo = userData.userData;
        trendT = trend;
        
        iHeihgt = 0;
        _headView = [[UIView alloc] init];
        _headView.frame = CGRectMake(0, iHeihgt, SCREEN_WIDTH, 56);
        [self.contentView addSubview:_headView];
        
        //头像
        _headImageView = [[UIImageView alloc]init];
        _headImageView.frame = CGRectMake(12, iHeihgt + 4, 40, 40);
        [_headImageView setOnlineImage:[RTUtil urlZoomPhoto:trend.userphoto]];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 20;
        _headImageView.layer.borderWidth = 1;
        _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        UITapGestureRecognizer *clickHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClicked:)];
        [_headImageView addGestureRecognizer:clickHead];
        _headImageView.userInteractionEnabled = YES;
        [_headView addSubview:_headImageView];
        
        //项目类型
        _projectType = [[UIImageView alloc] init];
        _projectType.frame = CGRectMake(SCREEN_WIDTH - 36, iHeihgt + 14, 24, 24);
        _projectType.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%@.png", trend.trendtype]];
        _projectType.layer.masksToBounds = YES;
        _projectType.layer.cornerRadius = 12;
        [_headView addSubview:_projectType];
        
        //昵称
        CGSize nicknameSize = [trend.usernickname sizeWithFont:SMALLFONT_12];
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.frame = CGRectMake(62, iHeihgt + 8, nicknameSize.width, nicknameSize.height);
        _nicknameLabel.text = trend.usernickname;
        _nicknameLabel.textAlignment = NSTextAlignmentLeft;
        _nicknameLabel.font = SMALLFONT_12;
        if ([trend.usersex integerValue] == 1) {
            _nicknameLabel.textColor = [UIColor colorWithRed:6/255.0 green:84/255.0 blue:165/255.0 alpha:1.0];
        }
        else{_nicknameLabel.textColor = [UIColor colorWithRed:232/255.0 green:68/255.0 blue:135/255.0 alpha:1.0];
        }
        [_headView addSubview:_nicknameLabel];
        _nicknameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nicknameButton.frame = _nicknameLabel.frame;
        [_nicknameButton addTarget:self action:@selector(nicknameButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:_nicknameButton];
        
        //用户类型
        _userTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(62 + nicknameSize.width, iHeihgt + 8, 50, nicknameSize.height)];
        
        if (![RTUtil isEmpty:trend.usertype]) {
            if ([trend.usertype isEqualToString:@"2"]) {
                _userTypeLabel.text = @"(教练)";
                _userTypeLabel.textColor = [UIColor colorWithRed:202/255.0 green:103/255.0 blue:22/255.0 alpha:1.0];
            }
            else if([trend.usertype isEqualToString:@"3"]){
                _userTypeLabel.text = @"(达人)";
                _userTypeLabel.textColor = [UIColor colorWithRed:35/255.0 green:160/255.0 blue:57/255.0 alpha:1.0];
            }
            else{
                _userTypeLabel.text = @"";
            }
        }
        _userTypeLabel.textAlignment = NSTextAlignmentLeft;
        _userTypeLabel.font = SMALLFONT_12;
        [_headView addSubview:_userTypeLabel];
        
        //发布时间
        UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(62, iHeihgt + 19 + nicknameSize.height, 10, 10)];
        timeImage.image = [UIImage imageNamed:@"time.png"];
        [_headView addSubview:timeImage];
        
        _timeLabel = [[UILabel alloc] init];
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
        _timeLabel.frame = CGRectMake(73, iHeihgt + 18 + nicknameSize.height, timeSize.width, timeSize.height);
        _timeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _timeLabel.text = timeString;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = SMALLFONT_10;
        [_headView addSubview:_timeLabel];
        
        //隐私图标
        if([trend.ispublic isEqualToString:@"Y"]){
            UIImageView *privateImage = [[UIImageView alloc] initWithFrame:CGRectMake(75 + timeSize.width, iHeihgt + 19 + nicknameSize.height, 7, 9)];
            privateImage.image = [UIImage imageNamed:@"private.png"];
            [_headView addSubview:privateImage];
            
        }
        
        //删除按钮
        if ([userinfo.userid isEqualToString:trend.userid]) {
            UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            deleteButton.frame = CGRectMake(82 + timeSize.width, iHeihgt + 15 + nicknameSize.height, 50, 18);
            [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
            [deleteButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
            deleteButton.titleLabel.font = SMALLFONT_10;
            [deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:deleteButton];
        }
        
        iHeihgt += 56;
        
        
        
        //文字内容
        [self addSubview:self.contentLabel];
        self.contentLabel.frame = CGRectMake(12, iHeihgt, SCREEN_WIDTH - 24, 5);
        [self.contentLabel sizeToFit];

        iHeihgt += self.contentLabel.frame.size.height + 5;
        
        //图片内容
        NSString *imageString = trend.trendphoto;
        if (![self isBlankString:imageString]) {
            _pictureView = [[UIView alloc] init];
            _pictureView.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:_pictureView];
            pictureArray = [imageString componentsSeparatedByString:@";"];
            iHeihgt += 5;
            int x = 0;
            int num = (int)pictureArray.count/3;
            int heightImage =(SCREEN_WIDTH - 30)/3;
            for (UIView *subView in _pictureView.subviews) {
                //避免重用
                [subView removeFromSuperview];
            }
            float picViewHeight = (num + 1) * (heightImage + 3);
            _pictureView.frame = CGRectMake(12, iHeihgt + 5, SCREEN_WIDTH - 24, picViewHeight);
            iHeihgt += picViewHeight + 10;
            
            if (pictureArray.count%3 == 0) {
                iHeihgt -=heightImage+3;
            }
            
            for (int i=0; i<pictureArray.count; i++) {
                NSString *strUrl = [pictureArray objectAtIndex:i];
                //NSLog(@"%@", strUrl);
                _smallImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, (i/3)*(heightImage+3), heightImage, heightImage)];
                _smallImageView.userInteractionEnabled = YES;
                [_smallImageView setOnlineImage:[RTUtil urlZoomPhoto:strUrl]];
                _smallImageView.tag = i;
                [_smallImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smallImageTap:)]];
                _smallImageView.contentMode = UIViewContentModeScaleAspectFill;
                _smallImageView.clipsToBounds = YES;
                x+=heightImage+3;
                if ((i+1)%3 == 0) {
                    x = 0;
                }
                [_pictureView addSubview:_smallImageView];
            }
        }
        //位置信息
        if(![RTUtil isEmpty:trend.useraddress]){
            UIImageView *positionImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, iHeihgt + 5, 15, 15)];
            positionImage.image = [UIImage imageNamed:@"activity_distance.png"];
            [self.contentView addSubview:positionImage];
            
            UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, iHeihgt + 5, SCREEN_WIDTH - 40, 15)];
            positionLabel.text = trend.useraddress;
            positionLabel.textColor = [UIColor colorWithRed:45/255.0 green:173/255.0 blue:226/255.0 alpha:1.0];
            positionLabel.font = [UIFont systemFontOfSize:10];
            positionLabel.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:positionLabel];
            iHeihgt += 25;
        }
        
        //底部view
        bottomView = [[UIView alloc] init];
        bottomView.frame = CGRectMake(0, iHeihgt, SCREEN_WIDTH, 34);
        [self.contentView addSubview:bottomView];
        
        //横分割线
        line =[[UILabel alloc] init];
        line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        line.backgroundColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        [bottomView addSubview:line];
        
        //评论
        discussButton = [UIButton buttonWithType:UIButtonTypeCustom];
        discussButton.frame = CGRectMake(0, 0.5, SCREEN_WIDTH/3, bottomView.frame.size.height-1);
        [discussButton addTarget:self action:@selector(discussButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:discussButton];
        
        discussLabel= [[UILabel alloc] init];
        discussLabel.frame = CGRectMake(SCREEN_WIDTH/6, 1, SCREEN_WIDTH/6 - 20, bottomView.frame.size.height-3);
        [bottomView addSubview:discussLabel];
        discussLabel.text = trend.trendcommentnumber;
        discussLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        discussLabel.textAlignment = NSTextAlignmentCenter;
        
        discussImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6 - 25, 6, 22, 22)];
        discussImage.image = [UIImage imageNamed:@"discuss.png"];
        [bottomView addSubview:discussImage];
        
        //点赞
        likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        likeButton.frame = CGRectMake(SCREEN_WIDTH/3, 0.5, SCREEN_WIDTH/3, bottomView.frame.size.height-1);
        [likeButton addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:likeButton];
        
        likeLabel= [[UILabel alloc] init];
        likeLabel.frame = CGRectMake(SCREEN_WIDTH/2, 1, SCREEN_WIDTH/6 - 20, bottomView.frame.size.height-3);
        [bottomView addSubview:likeLabel];
        likeLabel.text = trend.trendfavoritenumber;
        likeLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        likeLabel.textAlignment = NSTextAlignmentCenter;
        
        
        likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 25, 6, 22, 22)];
        NSLog(@"%@", trend.isfavorite);
        if ([trend.isfavorite integerValue] == 1) {
            likeImage.image = [UIImage imageNamed:@"like.png"];
        }else{
            likeImage.image = [UIImage imageNamed:@"dislike.png"];
        }
        
        [bottomView addSubview:likeImage];
        
        //转发
        forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        forwardButton.frame = CGRectMake(SCREEN_WIDTH/3*2, 1, SCREEN_WIDTH/3, bottomView.frame.size.height-1);
        [forwardButton addTarget:self action:@selector(forwardButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:forwardButton];
        
        forwardImage = [[UIImageView alloc] initWithFrame:CGRectMake(5 * SCREEN_WIDTH/6 - 11, 6, 22, 22)];
        forwardImage.image = [UIImage imageNamed:@"forward.png"];
        [bottomView addSubview:forwardImage];
        
        //两个分割线
        labelline = [[UILabel alloc]init];
        labelline.backgroundColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        labelline.frame = CGRectMake(SCREEN_WIDTH/3, 5, 0.5, bottomView.frame.size.height-10);
        [bottomView addSubview:labelline];
        labelline1 = [[UILabel alloc]init];
        labelline1.backgroundColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        labelline1.frame = CGRectMake(2*SCREEN_WIDTH/3, 5, 0.5, bottomView.frame.size.height-10);
        [bottomView addSubview:labelline1];
        
        endView = [[UIImageView alloc] initWithFrame:CGRectMake(0, iHeihgt + 34, SCREEN_WIDTH, 10)];
        [endView setImage:[UIImage imageNamed:@"bottom_line.png"]];
        [self.contentView addSubview:endView];
        
        iHeihgt += 44;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
        NSLog(@"type %@", contentString);
        if (![self isBlankString:contentString]) {
            contentString = [contentString stringByAppendingString:trendT.trendcontent];
        }
        else{
            contentString = trendT.trendcontent;
        }
        
       // NSLog(@"%@", contentString);
        _contentLabel.emojiText = contentString;
    }

    return _contentLabel;
}

- (int)heightWith:(Trends *)trend
{
    int iHeight = 0;
    iHeight += 56;
    iHeight += self.contentLabel.frame.size.height + 5;
    //iHeight += 5;
    
    NSString *imageString = trend.trendphoto;
    if (![self isBlankString:imageString]) {
        pictureArray = [imageString componentsSeparatedByString:@";"];
        iHeight += [self heightPic:pictureArray];
    }
    if (![RTUtil isEmpty:trend.useraddress]) {
        
        iHeight += 25;
    }
    iHeight += 44;
    return iHeight;
}

- (int)heightPic:(NSArray*)picArray
{
    
    int height = 5;
    int num = (int)[picArray count]/3;
    int heightImage = (SCREEN_WIDTH-30)/3;
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

- (void)nicknameButtonClick
{
    [self.delegate clickNicknameButton:trendT.userid];

    NSLog(@"点击了昵称");
}

//缩略图点击
- (void)smallImageTap:(UITapGestureRecognizer*)guesture
{
    NSInteger imageCount = pictureArray.count;
    photos = [NSMutableArray arrayWithCapacity:imageCount];
    for (int i = 0; i < imageCount; i ++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:[RTUtil urlPhoto:pictureArray[i]]];
        photo.srcImageView = _pictureView.subviews[i];
        [photos addObject:photo];
    }
    NSLog(@"%@", photos);
    //显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    //[[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    browser.currentPhotoIndex = guesture.view.tag;
    browser.photos = photos;
    [browser show];

   // [self.delegate clickSmallImage];
}

- (void)discussButtonClick
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
    RTDiscussViewController *discussView = [[RTDiscussViewController alloc] init];
    discussView.delegate = self;
    discussView.discussString = @"评论 ";
    discussView.ownerString = trendT.usernickname;
    discussView.trendID = trendT.trendid;
    //discussView.trendUserID = trendT.userid;
    [appDelegate.rootNavigationController pushViewController:discussView animated:YES];
    //[self.delegate clickDiscussButton];
}
#pragma mark - RTCommentViewDelegate
- (void)commentSuccess
{
    NSInteger commentNum = [trendT.trendcommentnumber integerValue];
    commentNum += 1;
    trendT.trendcommentnumber = [NSString stringWithFormat:@"%ld", (long)commentNum];
    discussLabel.text = trendT.trendcommentnumber;
}

- (void)likeButtonClick
{
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userinfo.userid, @"userid", userinfo.usertoken, @"usertoken", trendT.trendid, @"trendid",  nil];
    NSLog(@"%@", dic);
    if ([trendT.isfavorite integerValue] == 2) {
        likeImage.image = [UIImage imageNamed:@"like.png"];
        NSInteger favoirteNum = [trendT.trendfavoritenumber integerValue];
        favoirteNum += 1;
        trendT.trendfavoritenumber = [NSString stringWithFormat:@"%ld", (long)favoirteNum];
        likeLabel.text = trendT.trendfavoritenumber;
        trendT.isfavorite = @"1";
        [RTTrendsRequest trendLikeWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"点赞成功");
            }
            else{
                NSLog(@"点赞失败");
            }
        } failure:^(NSError *error) {
            NSLog(@"错误信息");
        }];
    }
    else{
        likeImage.image = [UIImage imageNamed:@"dislike.png"];
        NSInteger favoirteNum = [trendT.trendfavoritenumber integerValue];
        favoirteNum -= 1;
        trendT.trendfavoritenumber = [NSString stringWithFormat:@"%ld", (long)favoirteNum];
        likeLabel.text = trendT.trendfavoritenumber;
        trendT.isfavorite = @"2";
        [RTTrendsRequest trendDislikeWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"取消点赞成功");
            }
            else{
                NSLog(@"失败");
            }
        } failure:^(NSError *error) {
            NSLog(@"错误信息");
        }];
    }
    
    //[self.delegate clickLikeButton];
}

- (void)forwardButtonClick
{
    NSArray *shareButtonTitleArray = @[@"新浪微博",@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"];
    NSArray *shareButtonImageNameArray = @[@"sns_icon_1",@"sns_icon_22",@"sns_icon_23",@"sns_icon_24",@"sns_icon_40"];
    
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self];
    //[self.delegate clickForwardButton];
}

#pragma mark - LXActivityDelegate
- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    switch ((int)imageIndex) {
        case 0:
            [appDelegate sharedWeiboTimeLine:@"健身坊分享" Description:trendT.trendcontent objectID:trendT.trendid url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trendT.trendid, trendT.userid]];
            break;
            
        case 1:{
            if (pictureArray.count > 0) {
                    [appDelegate sendLinkContent:@"健身坊分享" Description:trendT.trendcontent Url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE, URL_TREND_SHARED, trendT.trendid, trendT.userid] Photo:[RTUtil urlWeixinPhoto:[pictureArray objectAtIndex:0]]];
            }
            else{
                [appDelegate sendLinkContent:@"健身坊分享" Description:trendT.trendcontent Url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE,URL_TREND_SHARED, trendT.trendid, trendT.userid] Photo:[RTUtil urlWeixinPhoto:@"icon"]];
            }
        }
            break;
        case 2:{
                if (pictureArray.count > 0) {
                    [appDelegate sendLinkContentTimeLine:trendT.trendcontent Description:trendT.trendcontent Url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE,URL_TREND_SHARED, trendT.trendid, trendT.userid] Photo:[RTUtil urlWeixinPhoto:[pictureArray objectAtIndex:0]]];
                }
                else{
                    [appDelegate sendLinkContentTimeLine:trendT.trendcontent Description:trendT.trendcontent Url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE,URL_TREND_SHARED, trendT.trendid, trendT.userid] Photo:[RTUtil urlWeixinPhoto:@"icon"]];
                }
            }
            break;
        case 3:{
            if (pictureArray.count > 0) {
                [appDelegate sharedQQFriendTitle:@"健身坊分享" description:trendT.trendcontent url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE,URL_TREND_SHARED, trendT.trendid, trendT.userid] Photo:[RTUtil urlZoomPhoto:[pictureArray objectAtIndex:0]]];
            }
            else{
                [appDelegate sharedQQFriendTitle:@"健身坊分享" description:trendT.trendcontent url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE,URL_TREND_SHARED, trendT.trendid, trendT.userid] Photo:[RTUtil urlZoomPhoto:@"icon"]];
            }
        }
            break;
        case 4:{
            if (pictureArray.count > 0) {
                [appDelegate sharedQZoneTitle:@"健身坊分享" description:trendT.trendcontent url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE,URL_TREND_SHARED, trendT.trendid, trendT.userid] Photo:[RTUtil urlZoomPhoto:[pictureArray objectAtIndex:0]]];
            }
            else{
                [appDelegate sharedQZoneTitle:@"健身坊分享" description:trendT.trendcontent url:[NSString stringWithFormat:@"%@%@?id=%@&userid=%@",URL_BASE,URL_TREND_SHARED, trendT.trendid, trendT.userid] Photo:[RTUtil urlZoomPhoto:@"icon"]];
            }
        }
            break;
        default:
            break;
    }
}



- (void)clickDeleteButton
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userinfo.userid, @"userid", userinfo.usertoken, @"usertoken", trendT.trendid, @"trendid", nil];
        [RTTrendsRequest deleteMyTrendWith:dic success:^(id response) {
            if ([[response objectForKey:@"state"] integerValue] == 1000) {
                NSLog(@"删除成功");
                [self.delegate clickDeleteButton];
            }
            else{
                NSLog(@"删除失败");
            }
        } failure:^(NSError *error) {
            NSLog(@"失败");
        }];
    }
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
            [self.delegate clickTrendsClassfy:link];
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
}

//判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}



@end
