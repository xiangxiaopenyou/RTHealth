//
//  RTRealationshipTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/12/19.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTRealationshipTableViewCell.h"
#import "RTFriendRequest.h"
#import <CoreText/CoreText.h>

@implementation RTRealationshipTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(FriendsInfo*)friendinfo{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        friendInfo = friendinfo;
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        [imageview setOnlineImage:[RTUtil urlZoomPhoto:friendInfo.friendphoto]];
        imageview.layer.cornerRadius = 20;
        imageview.layer.masksToBounds = YES;
        [self addSubview:imageview];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 150, 15)];
        label.font = VERDANA_FONT_12;
        [self addSubview:label];
        NSLog(@"friendInfo %@",friendInfo.friendtype);
        label.attributedText = [self getAttributedString];
        
        float x = 60.0;
        float y = 30.0;
        if (![RTUtil isEmpty:friendInfo.friendfavoritesports]) {
            
            NSArray *favorite = [friendInfo.friendfavoritesports componentsSeparatedByString:@":"];
            for (int i = 0; i < 5 &&i < favorite.count; i ++) {
                NSString *string = [favorite objectAtIndex:i];
                x = 60+i *22;
                UIImageView *sportImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, 20, 20)];
                sportImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%02d.png",[string intValue]]];
                sportImageView.layer.cornerRadius = 10;
                sportImageView.layer.masksToBounds = YES;
                [self addSubview:sportImageView];
            }
        }
        
        self.labelSort = [[UILabel alloc]initWithFrame:CGRectMake(240, 12, 70, 16)];
        self.labelSort.textAlignment = NSTextAlignmentRight;
        self.labelSort.font = VERDANA_FONT_11;
        self.labelSort.textColor = [UIColor blackColor];
//        labelSort.text = [NSString stringWithFormat:@"人气:%@",friendInfo.friendfansnumber];
        [self addSubview:self.labelSort];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(270, 30+3, 40, 17);
        if ([friendInfo.friendflag intValue] == FRIENDS_SIGNAL || [friendInfo.friendflag intValue] == FRIENDS_HEATTENTION){
            [btn setBackgroundImage:[UIImage imageNamed:@"notattention.png"] forState:UIControlStateNormal];
        }else if ([friendInfo.friendflag intValue] == FRIENDS_EACHOTHER){
            [btn setBackgroundImage:[UIImage imageNamed:@"attentioned.png"] forState:UIControlStateNormal];
        }else if ([friendInfo.friendflag intValue] == FRIENDS_IATTENTION){
            [btn setBackgroundImage:[UIImage imageNamed:@"attentioned.png"] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 60-1, SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
    }
    
    return self;
}
- (void)displayBtn{
    if ([friendInfo.friendflag intValue] == FRIENDS_SIGNAL || [friendInfo.friendflag intValue] == FRIENDS_HEATTENTION){
        [btn setBackgroundImage:[UIImage imageNamed:@"notattention.png"] forState:UIControlStateNormal];
    }else if ([friendInfo.friendflag intValue] == FRIENDS_EACHOTHER){
        [btn setBackgroundImage:[UIImage imageNamed:@"attentioned.png"] forState:UIControlStateNormal];
    }else if ([friendInfo.friendflag intValue] == FRIENDS_IATTENTION){
        [btn setBackgroundImage:[UIImage imageNamed:@"attentioned.png"] forState:UIControlStateNormal];
    }
}
- (void)clickbtn:(UIButton*)btn{
    
    if ([friendInfo.friendflag intValue] == FRIENDS_SIGNAL){
        [RTFriendRequest fansCreateFriend:friendInfo Success:^(id response){
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                friendInfo.friendflag = [NSString stringWithFormat:@"%d",FRIENDS_IATTENTION];
                [self displayBtn];
            }
        }failure:^(NSError *error){
            
        }];
    }else if ([friendInfo.friendflag intValue] == FRIENDS_EACHOTHER){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"取消关注" message:@"确定取消关注" delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if ([friendInfo.friendflag intValue] == FRIENDS_IATTENTION){
        [RTFriendRequest fansDeleteFriend:friendInfo Success:^(id response){
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                friendInfo.friendflag = [NSString stringWithFormat:@"%d",FRIENDS_SIGNAL];
                [self displayBtn];
            }
        }failure:^(NSError *error){
            
        }];

    }else if ([friendInfo.friendflag intValue] == FRIENDS_HEATTENTION){
        [RTFriendRequest fansCreateFriend:friendInfo Success:^(id response){
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                friendInfo.friendflag = [NSString stringWithFormat:@"%d",FRIENDS_EACHOTHER];
                [self displayBtn];
            }
        }failure:^(NSError *error){
            
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        [RTFriendRequest fansDeleteFriend:friendInfo Success:^(id response){
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                friendInfo.friendflag = [NSString stringWithFormat:@"%d",FRIENDS_HEATTENTION];
                [self displayBtn];
            }
        }failure:^(NSError *error){
            
        }];
    }
}
- (NSAttributedString*)getAttributedString{
    if ([RTUtil isEmpty:friendInfo.friendnickname] || [RTUtil isEmpty:friendInfo]) {
        return nil;
    }
    if ([friendInfo.friendtype intValue] == 1) {
        NSRange range=[friendInfo.friendnickname rangeOfString:friendInfo.friendnickname];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:friendInfo.friendnickname];
//        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        if ([friendInfo.friendsex intValue] == 1) {
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        }else{
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        }
        return attriString;
    }else if ([friendInfo.friendtype intValue] == 2) {
        
        NSString *string = [NSString stringWithFormat:@"%@(教练)",friendInfo.friendnickname];
        NSRange range=[string rangeOfString:friendInfo.friendnickname];
        NSRange range1=[string rangeOfString:@"(教练)"];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
//        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        if ([friendInfo.friendsex intValue] == 1) {
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        }else{
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        }
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor brownColor] range:range1];
        return attriString;
    }else if ([friendInfo.friendtype intValue] == 3) {
        NSString *string = [NSString stringWithFormat:@"%@(达人)",friendInfo.friendnickname];
        NSRange range=[string rangeOfString:friendInfo.friendnickname];
        NSRange range1=[string rangeOfString:@"(达人)"];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
//        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        if ([friendInfo.friendsex intValue] == 1) {
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        }else{
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        }
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range1];
        return  attriString;
    }else{
        NSRange range=[friendInfo.friendnickname rangeOfString:friendInfo.friendnickname];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:friendInfo.friendnickname];
//        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        if ([friendInfo.friendsex intValue] == 1) {
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        }else{
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        }
        return attriString;
    }
}

@end
