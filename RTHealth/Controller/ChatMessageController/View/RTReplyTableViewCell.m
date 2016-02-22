//
//  RTReplyTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/11/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTReplyTableViewCell.h"
#import "MLEmojiLabel.h"

@implementation RTReplyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(Reply*)reply
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        replyData = reply;
        
        heightofcell = 145;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserInfo:)];
        UIView *viewFriend = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, 45)];
        viewFriend.backgroundColor = [UIColor clearColor];
        [viewFriend addGestureRecognizer:tapGesture];
        UIImageView *touxiang = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
        touxiang.layer.cornerRadius = 17.5;
        touxiang.layer.masksToBounds = YES;
        [touxiang setOnlineImage:[RTUtil urlPhoto:reply.replyuserphoto]];
        [viewFriend addSubview:touxiang];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 22)];
        nameLabel.text = reply.replyusernickname;
//        nameLabel.text = @"黄成";
        nameLabel.font = VERDANA_FONT_12;
        nameLabel.textColor = [UIColor blackColor];
        [viewFriend addSubview:nameLabel];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 32, 200, 10)];
        timeLabel.text = reply.replytime;
//        timeLabel.text= @"12:10";
        timeLabel.font = VERDANA_FONT_10;
        timeLabel.textColor = [UIColor grayColor];
        [viewFriend addSubview:timeLabel];
        [self addSubview:viewFriend];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"回复" forState:UIControlStateNormal];
        btn.frame = CGRectMake(270, 15, 40, 20);
        btn.titleLabel.font = VERDANA_FONT_10;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickReply) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        [self addSubview:btn];
        
        
        [self addSubview:self.replyLabel];
        self.replyLabel.frame = CGRectMake(10, 53, 290, 15);
        [self.replyLabel sizeToFit];
        NSLog(@"%f",self.replyLabel.frame.size.height);
        
        UIView *trend = [[UIView alloc]init];
        trend.frame = CGRectMake(0, self.replyLabel.frame.origin.y+self.replyLabel.frame.size.height, SCREEN_WIDTH, 10);
        trend.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [trend sizeToFit];
        [self addSubview:trend];
        
        [self addSubview:self.replyForLabel];
        self.replyForLabel.frame = CGRectMake(10, 0 , 290, 15);
        [self.replyForLabel sizeToFit];
        NSLog(@" reply size %f",self.replyForLabel.frame.size.height);
        [trend addSubview:self.replyForLabel];
        
        UIView *trendContent = [[UIView alloc]initWithFrame:CGRectMake(10, 5+self.replyForLabel.frame.size.height+5, 300, 70)];
        trendContent.backgroundColor = [UIColor whiteColor];
        [trend addSubview:trendContent];
        
        UIImageView *trendImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        NSString *picString;
        if (replyData.trendphoto == nil) {
            picString = replyData.trenduserhead;
        }else{
            NSArray *pictureArray = [replyData.trendphoto componentsSeparatedByString:@";"];
            picString = [pictureArray objectAtIndex:0];
        }
        [trendImageView setOnlineImage:[RTUtil urlZoomPhoto:picString]];
        [trendContent addSubview:trendImageView];
        
        UILabel *trendUsernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 10, 225, 19)];
        trendUsernameLabel.text = [NSString stringWithFormat:@"@%@",replyData.username];
        trendUsernameLabel.font = VERDANA_FONT_14;
        [trendContent addSubview:trendUsernameLabel];
        
        UILabel *trendContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 30, 225, 25)];
        trendContentLabel.font = VERDANA_FONT_10;
        trendContentLabel.text = replyData.trendcontent;
        trendContentLabel.numberOfLines = 0;
        [trendContent addSubview:trendContentLabel];
        
        trend.frame = CGRectMake(0, self.replyLabel.frame.origin.y+self.replyLabel.frame.size.height+10, 320, 90 + self.replyForLabel.frame.size.height);
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self getHeight]);
        
        UIImageView *separator = [[UIImageView alloc]initWithFrame:CGRectMake(0, [self getHeight]-9, SCREEN_WIDTH, 9)];
        separator.image = [UIImage imageNamed:@"fenge.png"];
        [self addSubview:separator];
        
        RTUserInfo *userData = [RTUserInfo getInstance];
        UserInfo *userinfo = userData.userData;
        if ([reply.replyuserid isEqualToString:userinfo.userid]) {
            [btn setHidden:YES];
        }
    }
    return self;
}


- (MLEmojiLabel *)replyForLabel
{
    if (!_replyForLabel) {
        _replyForLabel = [[MLEmojiLabel alloc]init];
        _replyForLabel.numberOfLines = 0;
        _replyForLabel.font = VERDANA_FONT_10;
        _replyForLabel.emojiDelegate = self;
        _replyForLabel.backgroundColor = [UIColor clearColor];
        _replyForLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _replyForLabel.isNeedAtAndPoundSign = YES;
        
        NSString *text;
        
        [_replyForLabel setEmojiText:replyData.replyforusercontent];//撒萨撒旦撒旦撒达说https://github.com/molon/MLEmojiLabel阿苏打@撒旦 哈哈哈哈#撒asd#撒旦撒电话18120136012邮箱18120136012@qq.com旦旦/:dsad旦/::)sss/::~啊是大三的链接:http://baidu.com拉了dudl@qq.com
        if (replyData.replyfriendtpye.integerValue == 2){
            text = [NSString stringWithFormat:@"@%@ 回复@%@ :%@",replyData.replyforusernickname,replyData.replyfriendnickname,replyData.replyforusercontent];
            [_replyForLabel setEmojiText:text];
        }else if (replyData.replytype.integerValue == 2&&replyData.replyfriendtpye.integerValue == 1){
            text = [NSString stringWithFormat:@"@%@ 评论:%@",replyData.replyforusernickname,replyData.replyforusercontent];
            [_replyForLabel setEmojiText:text];
        }else{
            
        }
    }
    return _replyForLabel;
}


- (MLEmojiLabel *)replyLabel
{
    if (!_replyLabel) {
        _replyLabel = [[MLEmojiLabel alloc]init];
        _replyLabel.numberOfLines = 0;
        _replyLabel.font = VERDANA_FONT_10;
        _replyLabel.emojiDelegate = self;
        _replyLabel.backgroundColor = [UIColor clearColor];
        _replyLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _replyLabel.isNeedAtAndPoundSign = YES;
        
        NSString *text;
        if (replyData.replytype.integerValue == 2){
            text = [NSString stringWithFormat:@"回复@%@ :%@",replyData.replyforusernickname,replyData.replycontent];
            [_replyLabel setEmojiText:text];
        }else{
            
            [_replyLabel setEmojiText:replyData.replycontent];
        }
    }
    return _replyLabel;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (float)getHeight{
    return heightofcell + self.replyForLabel.frame.size.height+self.replyLabel.frame.size.height+13;
}

#pragma  mark - MLEmojiLabel Delegate

- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
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
        case MLEmojiLabelLinkTypeAt:{
            if ([[NSString stringWithFormat:@"@%@",replyData.replyusernickname] isEqualToString:link]){
                NSLog(@"点击了自己%@",link);
                [self.delegate pushToUserInfo:replyData.replyuserid];
            } else if ([[NSString stringWithFormat:@"@%@",replyData.replyforusernickname] isEqualToString:link]) {
                NSLog(@"点击了用户%@",link);
                [self.delegate pushToUserInfo:replyData.replyforusernickname];
            }else if ([[NSString stringWithFormat:@"@%@",replyData.replyfriendnickname] isEqualToString:link]) {
                NSLog(@"点击了用户%@",link);
                [self.delegate pushToUserInfo:replyData.replyfriendid];
            }
        }break;
        case MLEmojiLabelLinkTypePoundSign:
            NSLog(@"点击了话题%@",link);
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
    
}

- (void)clickUserInfo:(UIGestureRecognizer*)gesture{
    NSLog(@"click");
    [self.delegate pushToUserInfo:replyData.replyuserid];
}

- (void)clickReply{
    [self.delegate pushToAddReply:replyData];
}
@end
