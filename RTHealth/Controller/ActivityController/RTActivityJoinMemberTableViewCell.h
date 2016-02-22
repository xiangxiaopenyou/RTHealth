//
//  RTActivityJoinMemberTableViewCell.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTActivityJoinMemberTableViewCell : UITableViewCell{
    BOOL isPayAttention;
}

@property (nonatomic, strong) UIButton *payAttentionButton;
//@property (nonatomic, strong) id<RTActivityJoinMemberTableViewCellDelegate>delegate;
@property (nonatomic, strong) NSDictionary *memberDic;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDic:(NSDictionary*)dic;

@end
