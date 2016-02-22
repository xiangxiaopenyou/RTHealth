//
//  RTReplyTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/11/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLEmojiLabel.h" 

@protocol RTReplyTableViewCellDelegate <NSObject>

@optional

- (void)pushToUserInfo:(NSString*)userid;
- (void)pushToAddReply:(Reply*)reply;

@end

@interface RTReplyTableViewCell : UITableViewCell<MLEmojiLabelDelegate>{
    float heightofcell;
    Reply *replyData;
}

@property (nonatomic, strong) MLEmojiLabel *replyLabel;
@property (nonatomic, strong) MLEmojiLabel *replyForLabel;
@property (nonatomic, assign) id<RTReplyTableViewCellDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(Reply*)reply;

- (float)getHeight;



@end
