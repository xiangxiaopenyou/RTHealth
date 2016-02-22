//
//  RTPraiseTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/11/11.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTPraiseTableViewCellDelegate <NSObject>

- (void)clickToUserInfo:(NSString*)userid;

@end

@interface RTPraiseTableViewCell : UITableViewCell{
    Praise *praise;
}

@property (nonatomic,assign) id<RTPraiseTableViewCellDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(Praise*)praiseData;

@end
