//
//  RTPersonalLetterTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/11/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPersonalLetterTableViewCell.h"

@implementation RTPersonalLetterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(Chat*)chat{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        [imageview setOnlineImage:[RTUtil urlPhoto:chat.chatuserphoto]];
        imageview.layer.cornerRadius = 20;
        imageview.layer.masksToBounds = YES;
        [self addSubview:imageview];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 150, 20)];
        label.text = chat.chatusernickname;
        label.font = VERDANA_FONT_14;
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        
        UILabel *labelContent = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 200, 30)];
        labelContent.text = chat.chatlastcontent;
        labelContent.textColor = [UIColor grayColor];
        labelContent.font = VERDANA_FONT_11;
        [self addSubview:labelContent];
        
        UILabel *labeltime = [[UILabel alloc]initWithFrame:CGRectMake(250, 10, 60, 15)];
        labeltime.text = [CustomDate getDateStringToDete:chat.chatlasttime];
        labeltime.textColor = [UIColor grayColor];
        labeltime.font = VERDANA_FONT_10;
        labeltime.textAlignment = NSTextAlignmentRight;
        [self addSubview:labeltime];
        
        UILabel *labelnotread = [[UILabel alloc]initWithFrame:CGRectMake(285, 30, 25, 25)];
        labelnotread.backgroundColor = [UIColor redColor];
        labelnotread.layer.cornerRadius = 12.5;
        labelnotread.layer.masksToBounds = YES;
        labelnotread.font = VERDANA_FONT_10;
        labelnotread.textAlignment = NSTextAlignmentCenter;
        labelnotread.textColor = [UIColor whiteColor];
        [self addSubview:labelnotread];
        
        NSPredicate *preTemplate = [NSPredicate predicateWithFormat:@"chatisread=='1'"];
        NSMutableArray *arrayNotRead = [NSMutableArray arrayWithArray:[[chat.chatlist allObjects] filteredArrayUsingPredicate:preTemplate]];
        if (arrayNotRead.count ) {
            labelnotread.text = [NSString stringWithFormat:@"%d",arrayNotRead.count];
            labelnotread.hidden = NO;
        }else{
            labelnotread.hidden = YES;
        }
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
