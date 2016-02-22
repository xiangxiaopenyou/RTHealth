//
//  RTDiscussTableViewCell.m
//  RTHealth
//file:///Users/AIR/Downloads/10.20演示图html/images/评论详情/u0.jpg
//  Created by 项小盆友 on 14/11/13.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTDiscussTableViewCell.h"
#import "RTDiscussViewController.h"
#import "RTTrendReplyViewController.h"
#import "RTTrendsRequest.h"


@implementation RTDiscussTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithData:(NSDictionary *)dic
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        commentDic = dic;
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [headImageView setOnlineImage:[RTUtil urlPhoto:[dic objectForKey:@"userheadportrait"]]];
        headImageView.layer.masksToBounds = YES;
        headImageView.layer.cornerRadius = 20;
        [self addSubview:headImageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageClick:)];
        [headImageView addGestureRecognizer:tap];
        headImageView.userInteractionEnabled = YES;
        
        CGSize nicknameSize;
        if(![RTUtil isEmpty:[dic objectForKey:@"nickname"]]){
            nicknameSize = [[dic objectForKey:@"nickname"] sizeWithFont:SMALLFONT_12];
            nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, nicknameSize.width, 20)];
            nicknameLabel.text = [dic objectForKey:@"nickname"];
            
        }
        else{
            nicknameSize = [@"XX" sizeWithFont:SMALLFONT_12];
            nicknameLabel  = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, nicknameSize.width, 20)];
            nicknameLabel.text = @"XX";
            
        }
        nicknameLabel.textAlignment = NSTextAlignmentLeft;
        nicknameLabel.font = SMALLFONT_12;
        [self addSubview:nicknameLabel];
        
        if ([[dic objectForKey:@"type"] integerValue] == 2) {
            
            UILabel *replyLabel = [[UILabel alloc] initWithFrame:CGRectMake(65 + nicknameSize.width, 10, 30, 20)];
            replyLabel.font = SMALLFONT_12;
            replyLabel.text = @"回复";
            [self addSubview:replyLabel];
            
            CGSize commentNicknameSize;
            if (![RTUtil isEmpty:[dic objectForKey:@"commentnickname"]]) {
                commentNicknameSize = [[dic objectForKey:@"commentnickname"] sizeWithFont:SMALLFONT_12];
                commentNicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 + nicknameSize.width, 10, commentNicknameSize.width, 20)];
                commentNicknameLabel.text =[dic objectForKey:@"commentnickname"];
            }
            else{
                commentNicknameSize = [@"XX" sizeWithFont:SMALLFONT_12];
                commentNicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 + nicknameSize.width, 10, commentNicknameSize.width, 20)];
                commentNicknameLabel.text = @"XX";
            }
            commentNicknameLabel.textAlignment = NSTextAlignmentLeft;
            commentNicknameLabel.font = SMALLFONT_12;
            commentNicknameLabel.textColor = [UIColor blueColor];
            [self addSubview:commentNicknameLabel];
            
            UIButton *commentNicknameButton = [UIButton buttonWithType:UIButtonTypeCustom];
            commentNicknameButton.frame = commentNicknameLabel.frame;
            [commentNicknameButton addTarget:self action:@selector(commentNicknameClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:commentNicknameButton];
        }
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, 100, 15)];
        NSString *timeString;
        NSDate *date = [CustomDate getTimeDate:[dic objectForKey:@"created_time"]];
        if ([[CustomDate compareDate:date] isEqualToString:@"今天"]) {
            timeString = [[dic objectForKey:@"created_time"] substringWithRange:NSMakeRange(11, 5)];
        }
        else if ([[CustomDate compareDate:date] isEqualToString:@"昨天"]){
            timeString = @"昨天";
            timeString = [timeString stringByAppendingString:@" "];
            timeString = [timeString stringByAppendingString:[[dic objectForKey:@"created_time"] substringWithRange:NSMakeRange(11, 5)]];
        }
        else{
            timeString = [[dic objectForKey:@"created_time"] substringWithRange:NSMakeRange(5, 11)];
        }
        timeLabel.text = timeString;
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.font = SMALLFONT_12;
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:timeLabel];
        
        [self addSubview:self.contentLabel];
        self.contentLabel.frame = CGRectMake(60, 65, SCREEN_WIDTH - 120, 15);
        [self.contentLabel sizeToFit];
        
        RTUserInfo *userData = [RTUserInfo getInstance];
        UserInfo *userinfo = userData.userData;
        if (![userinfo.userid isEqualToString:[commentDic objectForKey:@"userid"] ]) {
            //回复按钮
            UIButton *replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
            replyButton.frame = CGRectMake(SCREEN_WIDTH - 50, 35, 35, 25);
            [replyButton setTitle:@"回复" forState:UIControlStateNormal];
            replyButton.titleLabel.font = SMALLFONT_14;
            [replyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [replyButton addTarget:self action:@selector(replyButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:replyButton];

        }
        else
        {
            //删除按钮
            UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            deleteButton.frame = CGRectMake(SCREEN_WIDTH - 50, 35, 35, 25);
            [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
            deleteButton.titleLabel.font = SMALLFONT_14;
            [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:deleteButton];
        }
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
        if ([[commentDic objectForKey:@"type"] integerValue] == 1) {
            _contentLabel.emojiText = [commentDic objectForKey:@"content"];
        }
        else{
            _contentLabel.emojiText = [commentDic objectForKey:@"commentcontent"];
        }
    }
    
    return _contentLabel;
}

- (void)replyButtonClick
{
   
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    RTTrendReplyViewController *replyView = [[RTTrendReplyViewController alloc] init];
    replyView.replyString = @"回复 ";
    replyView.ownerString = [commentDic objectForKey:@"nickname"];
    replyView.trendID = [commentDic objectForKey:@"dynamicid"];
    replyView.commentID = [commentDic objectForKey:@"id"];
    replyView.commentUserID = [commentDic objectForKey:@"userid"];
    //replyView.replyUserNickname = [commentDic objectForKey:@"commentnickname"];
    [appDelegate.rootNavigationController pushViewController:replyView animated:YES];
    [self.delegate clickReplyButton];
}
- (void)deleteButtonClick
{
    RTUserInfo *userinfo = [RTUserInfo getInstance];
    UserInfo *user = userinfo.userData;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:user.userid forKey:@"userid"];
    [dic setObject:user.usertoken forKey:@"usertoken"];
    [dic setObject:[commentDic objectForKey:@"id"] forKey:@"commentid"];
    [dic setObject:[commentDic objectForKey:@"type"] forKey:@"type"];
    [RTTrendsRequest deleteCommentWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"删除成功");
            [self.delegate clickDeleteCommentButton];
        }
        else{
            NSLog(@"删除失败");
        }
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
}

- (void)commentNicknameClick
{
    NSLog(@"进入个人主页");
    [self.delegate clickCommentNickname:[commentDic objectForKey:@"commentuserid"]];
}

- (void)headImageClick:(UITapGestureRecognizer*)gesture
{
    NSLog(@"点击了头像");
    [self.delegate clickCommentHeadImage:[commentDic objectForKey:@"userid"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
