//
//  RTRemindTableViewCell.m
//  RTHealth
//
//  Created by cheng on 15/1/5.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTRemindTableViewCell.h"
#import "MLEmojiLabel.h"

@implementation RTRemindTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(Remind*)remind{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        remindData = remind;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 160, 30)];
        label.font = VERDANA_FONT_16;
        if (remindData.remindtype.integerValue == 2){
            label.text = @"活动邀请";
        }else {
            label.text = @"活动提醒";
        }
        [self addSubview:label];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 0, 130, 30)];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.text = [CustomDate getDateStringToDete:remindData.remindtime];
        timeLabel.font = VERDANA_FONT_12;
        [self addSubview:timeLabel];
        
        [self addSubview:self.replyLabel];
        self.replyLabel.frame = CGRectMake(10, 30, 290, 15);
        [self.replyLabel sizeToFit];
        
    }
    return self;
}

- (MLEmojiLabel *)replyLabel
{
    if (!_replyLabel) {
        _replyLabel = [[MLEmojiLabel alloc]init];
        _replyLabel.numberOfLines = 0;
        _replyLabel.font = VERDANA_FONT_12;
        _replyLabel.emojiDelegate = self;
        _replyLabel.backgroundColor = [UIColor clearColor];
        _replyLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _replyLabel.isNeedAtAndPoundSign = YES;
        NSString *text;
        
        [_replyLabel setEmojiText:remindData.remindcontent];
        if (remindData.remindtype.integerValue == 2){
            text = [NSString stringWithFormat:@"你的好友@%@ 邀请你一起参与 #%@#",remindData.remindusernickname,remindData.remindsometitle];
            [_replyLabel setEmojiText:text];
        }else if (remindData.remindtype.integerValue == 3){
            text = [NSString stringWithFormat:@"您参与的 #%@# 活动将于 %@ ",remindData.remindsometitle,remindData.remindcontent];
            [_replyLabel setEmojiText:text];
        }else if (remindData.remindtype.integerValue == 1){
            text = [NSString stringWithFormat:@" @%@ 参与了你的 #%@# 活动",remindData.remindusernickname,remindData.remindsometitle];
            [_replyLabel setEmojiText:text];
        }
    }
    return _replyLabel;
}

- (float)getHeight{
    return self.replyLabel.frame.size.height+40;
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
        case MLEmojiLabelLinkTypeEmail:{
            NSLog(@"点击了邮箱%@",link);
        }break;
        case MLEmojiLabelLinkTypeAt:{
            NSLog(@"点击了@ %@",link);
            if ([[NSString stringWithFormat:@"@%@",remindData.remindusernickname] isEqualToString:link]){
                NSLog(@"点击了自己%@",link);
                [self.delegate clickUser:remindData.reminduserid];
            }
        }break;
        case MLEmojiLabelLinkTypePoundSign:{
            NSLog(@"点击了话题%@",link);
            if ([[NSString stringWithFormat:@"#%@#",remindData.remindsometitle] isEqualToString:link]){
                NSLog(@"点击了自己%@",link);
                [self.delegate clickActivity:remindData.remindsomeid];
            }
        }break;
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
