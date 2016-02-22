//
//  RTRemindTableViewCell.h
//  RTHealth
//
//  Created by cheng on 15/1/5.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLEmojiLabel.h"

@protocol RTRemindTableViewCellDelegate <NSObject>

@optional

- (void)clickUser:(NSString*)userid;

- (void)clickActivity:(NSString*)activityid;

@end

@interface RTRemindTableViewCell : UITableViewCell<MLEmojiLabelDelegate>{
    Remind *remindData;
}

@property (nonatomic, strong) MLEmojiLabel *replyLabel;

@property (nonatomic,weak) id<RTRemindTableViewCellDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(Remind*)remind;

- (float)getHeight;

@end
