//
//  RTPraiseTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/11/11.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPraiseTableViewCell.h"

@implementation RTPraiseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(Praise*)praiseData
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        praise = praiseData;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserInfo:)];
        UIView *viewFriend = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, 45)];
        viewFriend.backgroundColor = [UIColor clearColor];
        [viewFriend addGestureRecognizer:tapGesture];

        
        UIImageView *touxiang = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
        touxiang.layer.cornerRadius = 17.5;
        touxiang.layer.masksToBounds = YES;
        [touxiang setOnlineImage:[RTUtil urlPhoto:praise.praiseuserphoto]];
        [viewFriend addSubview:touxiang];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 22)];
        nameLabel.text = praise.praiseusernickname;
        nameLabel.font = VERDANA_FONT_12;
        nameLabel.textColor = [UIColor blackColor];
        [viewFriend addSubview:nameLabel];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 32, 150, 10)];
        timeLabel.text = praise.praisetime;
        timeLabel.font = VERDANA_FONT_10;
        timeLabel.textColor = [UIColor grayColor];
        [viewFriend addSubview:timeLabel];
        
        [self addSubview:viewFriend];
        
        UILabel *labelcontent = [[UILabel alloc]initWithFrame:CGRectMake(10, 48, 290, 15)];
        labelcontent.text = @"赞了这条动态";
        labelcontent.font = VERDANA_FONT_12;
        labelcontent.textColor = [UIColor blackColor];
        [self addSubview:labelcontent];
        
        UIView *trend = [[UIView alloc]init];
        trend.frame = CGRectMake(0, 63, SCREEN_WIDTH, 90);
        trend.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [trend sizeToFit];
        [self addSubview:trend];
        
        
        UIView *trendContent = [[UIView alloc]initWithFrame:CGRectMake(10, 5+5, 300, 70)];
        trendContent.backgroundColor = [UIColor whiteColor];
        [trend addSubview:trendContent];
        
        UIImageView *trendImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        NSString *picString;
        if (praise.trendphoto == nil) {
            picString = praise.trenduserhead;
        }else{
            NSArray *pictureArray = [praise.trendphoto componentsSeparatedByString:@";"];
            picString = [pictureArray objectAtIndex:0];
        }
        [trendImageView setOnlineImage:[RTUtil urlZoomPhoto:picString]];
        [trendContent addSubview:trendImageView];
        
        UILabel *trendUsernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 10, 225, 19)];
        trendUsernameLabel.text = [NSString stringWithFormat:@"@%@",praise.username];
        trendUsernameLabel.font = VERDANA_FONT_14;
        [trendContent addSubview:trendUsernameLabel];
        
        UILabel *trendContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 30, 225, 25)];
        trendContentLabel.font = VERDANA_FONT_10;
        trendContentLabel.text = praise.trendcontent;
        trendContentLabel.numberOfLines = 0;
        [trendContent addSubview:trendContentLabel];
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
        
        UIImageView *separator = [[UIImageView alloc]initWithFrame:CGRectMake(0,160-9, SCREEN_WIDTH, 9)];
        separator.image = [UIImage imageNamed:@"fenge.png"];
        [self addSubview:separator];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)clickUserInfo:(UIGestureRecognizer*)gesture{
    NSLog(@"click");
    [self.delegate clickToUserInfo:praise.praiseuserid];
}
@end
