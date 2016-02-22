//
//  RTActivityJoinMemberTableViewCell.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTActivityJoinMemberTableViewCell.h"

@implementation RTActivityJoinMemberTableViewCell
@synthesize payAttentionButton, memberDic;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDic:(NSDictionary *)dic
{
    NSLog(@"%@", dic);
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        RTUserInfo *userData = [RTUserInfo getInstance];
        UserInfo *userinfo = userData.userData;
        
        memberDic = dic;
        
        if ([[dic objectForKey:@"flag"] integerValue] == 1) {
            isPayAttention = NO;
        }
        else{
            isPayAttention = YES;
        }
        
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 40, 40)];
        [headImage setOnlineImage:[RTUtil urlPhoto:[dic objectForKey:@"userheadportrait"]]];
        headImage.layer.masksToBounds = YES;
        headImage.layer.cornerRadius = 20;
        headImage.layer.borderWidth = 1;
        headImage.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:headImage];
        
        UILabel *nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(62, 15, 200, 30)];
        if ([RTUtil isEmpty:[dic objectForKey:@"nickname"]]) {
            nicknameLabel.text = @"";
        }
        else{
            nicknameLabel.text = [dic objectForKey:@"nickname"];
        }
        nicknameLabel.font = SMALLFONT_14;
        nicknameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:nicknameLabel];
        
        payAttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        payAttentionButton.frame = CGRectMake(SCREEN_WIDTH - 50, 19, 45, 22);
        if (![userinfo.userid isEqualToString:[dic objectForKey:@"userid"]]) {
            if ([[dic objectForKey:@"flag"] integerValue] == 1) {
                [payAttentionButton setBackgroundImage:[UIImage imageNamed:@"notattention.png"] forState:UIControlStateNormal];
            }
            else{
                [payAttentionButton setBackgroundImage:[UIImage imageNamed:@"attentioned.png"] forState:UIControlStateNormal];
            }
            //[payAttentionButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            //payAttentionButton.titleLabel.font = SMALLFONT_14;
            [payAttentionButton addTarget:self action:@selector(payAttentionButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:payAttentionButton];
        }
        UILabel *line =[[UILabel alloc] initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.3];
        [self addSubview:line];
        
    }
    return self;
}

- (void)payAttentionButtonClick
{
    NSLog(@"点击了关注按钮");
    //[self.delegate clickPayAttentionButton];
    FriendsInfo *friendInfo = [FriendsInfo MR_createEntity];
    friendInfo.friendid = [memberDic objectForKey:@"userid"];
    if (!isPayAttention) {
        [RTFriendRequest fansCreateFriend:friendInfo Success:^(id response) {
            if([[response objectForKey:@"state"] integerValue] == 1000){
                NSLog(@"关注成功");
                [payAttentionButton setBackgroundImage:[UIImage imageNamed:@"attentioned.png"] forState:UIControlStateNormal];
                isPayAttention = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:ATTENTIONACTION object:@YES];
            }
            else{
                NSLog(@"关注失败");
            }
        } failure:^(NSError *error) {
            NSLog(@"失败");
        }];
    }
    else{
        [RTFriendRequest fansDeleteFriend:friendInfo Success:^(id response) {
            if ([[response objectForKey:@"state"]  integerValue] == 1000) {
                NSLog(@"取消关注成功");
                [payAttentionButton setBackgroundImage:[UIImage imageNamed:@"notattention.png"] forState:UIControlStateNormal];
                isPayAttention = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:ATTENTIONACTION object:@YES];
            }
            else{
                NSLog(@"取消关注失败");
            }
        } failure:^(NSError *error) {
            NSLog(@"失败");
        }];
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
