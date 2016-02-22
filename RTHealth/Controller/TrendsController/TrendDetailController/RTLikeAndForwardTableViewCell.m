//
//  RTLikeAndForwardTableViewCell.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/13.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTLikeAndForwardTableViewCell.h"

@implementation RTLikeAndForwardTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithData:(NSDictionary *)dic
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [headImageView setOnlineImage:[RTUtil urlPhoto:[dic objectForKey:@"userheadportrait"]]];
        headImageView.layer.masksToBounds = YES;
        headImageView.layer.cornerRadius = 20;
        [self addSubview:headImageView];
        
        UILabel *nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 200, 30)];
        if ([RTUtil isEmpty:[dic objectForKey:@"nickname"]]) {
            nicknameLabel.text = @"";
        }
        else{
            nicknameLabel.text = [dic objectForKey:@"nickname"];
        }
        nicknameLabel.textAlignment = NSTextAlignmentLeft;
        nicknameLabel.font = SMALLFONT_14;
        [self addSubview:nicknameLabel];
        
        UILabel *lineLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 59, self.bounds.size.width, 1)];
        lineLabel.backgroundColor = [UIColor colorWithWhite:0.85 alpha:0.5];
        [self addSubview:lineLabel];
        
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

@end
