//
//  RTAttentionTableViewCell.h
//  RTHealth
//
//  Created by cheng on 14/12/9.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTAttentionTableViewCellDelegate <NSObject>

- (void)shouldReloadData;

@end

@interface RTAttentionTableViewCell : UITableViewCell{
    FriendsInfo *friendInfo;
    UIButton *btn;
}

@property (strong,nonatomic) id<RTAttentionTableViewCellDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(FriendsInfo*)friendinfo;

@end
