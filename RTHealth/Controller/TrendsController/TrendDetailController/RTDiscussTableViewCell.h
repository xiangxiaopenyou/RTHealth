//
//  RTDiscussTableViewCell.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/13.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLEmojiLabel.h"

@protocol RTDiscussTableViewCellDelegate <NSObject>
@optional

- (void)clickReplyButton;
- (void)clickDeleteCommentButton;
- (void)clickCommentHeadImage:(NSString*)idString;
- (void)clickCommentNickname:(NSString*)idString;

@end

@interface RTDiscussTableViewCell : UITableViewCell<MLEmojiLabelDelegate>
{
    NSDictionary *commentDic;
    UILabel *nicknameLabel;
    UILabel *commentNicknameLabel;
}


@property (nonatomic, strong)MLEmojiLabel *contentLabel;
@property (nonatomic, assign)id<RTDiscussTableViewCellDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithData:(NSDictionary *)dic;

@end
