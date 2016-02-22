//
//  RTFriendInfoTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFriendInfoTableViewCell.h"
#import "UIImageView+OnlineImage.h"
#import "RTFriendRequest.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

//控件边界距离20
#define BORDER_DISTANCE 20
//头像大小60*60
#define TOUXIANG_SIZE 60
//成就的x值
#define POINT_X 130
//成就的y值
#define POINT_Y 20*2
//成就的宽
#define POINT_WIDTH 180
//成就的高
#define POINT_HEIGHT 20
//个人介绍的高度
#define INSTRUCTION_HEIGHT 40


@implementation RTFriendInfoTableViewCell

@synthesize imageview = _imageview , labelInstruction = _labelInstruction , labelPoint = _labelPoint , imageLeft = _imageLeft , imagesex = _imagesex,labelName = _labelName,labelAge = _labelAge,fansBtn = _fansBtn,attentionBtn = _attentionBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(FriendsInfo*)friendInfo{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.friendInfo = friendInfo;UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        backgroundView.image = [UIImage imageNamed:@"infobackground.png"];
        [self addSubview:backgroundView];
        
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getDetailInfo:)];
        
        
        
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, TOUXIANG_SIZE, TOUXIANG_SIZE)];
        [_imageview setOnlineImage:[RTUtil urlZoomPhoto:self.friendInfo.friendphoto]];
        _imageview.layer.masksToBounds = YES;
        _imageview.layer.cornerRadius = TOUXIANG_SIZE/2;
        _imageview.layer.borderWidth = 1;
        _imageview.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageview.userInteractionEnabled = YES;
        [_imageview addGestureRecognizer:tap];
        [self addSubview:_imageview];
        
#pragma mark 粉丝和关注
        
        _fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fansBtn.frame = CGRectMake(5, 80, 55, 30);
        [_fansBtn setTitle:[NSString stringWithFormat:@"粉丝(%d)",[self.friendInfo.friendfansnumber intValue]] forState:UIControlStateNormal];
        [_fansBtn addTarget:self action:@selector(clickFans) forControlEvents:UIControlEventTouchUpInside];
        _fansBtn.titleLabel.textColor = [UIColor whiteColor];
        _fansBtn.titleLabel.font = VERDANA_FONT_12;
        [self addSubview:_fansBtn];
        
        UILabel *labelline = [[UILabel alloc]initWithFrame:CGRectMake(60, 85, 1, 20)];
        labelline.backgroundColor = [UIColor whiteColor];
        [self addSubview:labelline];
        
        _attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionBtn.frame = CGRectMake(61, 80, 55, 30);
        [_attentionBtn setTitle:[NSString stringWithFormat:@"关注(%d)",[self.friendInfo.friendattentionnumber intValue]] forState:UIControlStateNormal];
        [_attentionBtn addTarget:self action:@selector(clickHisAttention) forControlEvents:UIControlEventTouchUpInside];
        _attentionBtn.titleLabel.textColor = [UIColor whiteColor];
        _attentionBtn.titleLabel.font = VERDANA_FONT_12;
        [self addSubview:_attentionBtn];
        
#pragma mark
        
        _imagesex = [[UIImageView alloc]initWithFrame:CGRectMake(POINT_X, POINT_Y, 15, 17)];
        if ([self.friendInfo.friendsex integerValue]==1) {
            _imagesex.image = [UIImage imageNamed:@"sex_boy_image.png"];
        }else{
            _imagesex.image = [UIImage imageNamed:@"sex_girl_image.png"];
        }
        [self addSubview:_imagesex];
        
        _labelAge = [[UILabel alloc]initWithFrame:CGRectMake(POINT_X+17, POINT_Y, TOUXIANG_SIZE-_imagesex.frame.size.width, 17)];
        _labelAge.textAlignment = NSTextAlignmentLeft;
        _labelAge.textColor = [UIColor whiteColor];
        _labelAge.font = VERDANA_FONT_12;
        [self addSubview:_labelAge];
        
        if (![RTUtil isEmpty:self.friendInfo.friendbirthday]) {
            _labelAge.text = [NSString stringWithFormat:@"%ld",(long)[CustomDate getAgeToDate:self.friendInfo.friendbirthday]];
        }else{
            _labelAge.text = @"0";
        }
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(POINT_X, 15, 160, 20)];
        _labelName.text = self.friendInfo.friendnickname;
        _labelName.textColor = [UIColor whiteColor];
        _labelName.font = VERDANA_FONT_14;
        [self addSubview:_labelName];
        
        _labelInstruction = [[UILabel alloc]initWithFrame:CGRectMake(POINT_X, POINT_Y+POINT_HEIGHT, POINT_WIDTH, INSTRUCTION_HEIGHT)];
        _labelInstruction.text = self.friendInfo.friendintroduce;
        _labelInstruction.numberOfLines = 0;
        _labelInstruction.textAlignment = NSTextAlignmentLeft;
        _labelInstruction.font = VERDANA_FONT_14;
        _labelInstruction.textColor = [UIColor whiteColor];
        [self addSubview:_labelInstruction];

        attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        attentionBtn.frame = CGRectMake(320-85, (120.0-22)/2, 45, 22);
        attentionBtn.titleLabel.textColor = [UIColor grayColor];
        if ([friendInfo.friendflag intValue] == FRIENDS_SIGNAL || [friendInfo.friendflag intValue] == FRIENDS_HEATTENTION){
            [attentionBtn setBackgroundImage:[UIImage imageNamed:@"notattention.png"] forState:UIControlStateNormal];
        }else if ([friendInfo.friendflag intValue] == FRIENDS_EACHOTHER){
            [attentionBtn setBackgroundImage:[UIImage imageNamed:@"attentioned.png"] forState:UIControlStateNormal];
        }else if ([friendInfo.friendflag intValue] == FRIENDS_IATTENTION){
            [attentionBtn setBackgroundImage:[UIImage imageNamed:@"attentioned.png"] forState:UIControlStateNormal];
        }
        [attentionBtn addTarget:self action:@selector(clickAttention) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:attentionBtn];
        
        RTUserInfo *userdata = [RTUserInfo getInstance];
        UserInfo *userinfo = userdata.userData;
        if ([friendInfo.friendid intValue] == [userinfo.userid intValue]) {
            [attentionBtn setHidden:YES];
        }
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

- (void)clickAttention{
    if ([self.friendInfo.friendflag intValue] == FRIENDS_SIGNAL){
        [RTFriendRequest fansCreateFriend:self.friendInfo Success:^(id response){
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                self.friendInfo.friendflag = [NSString stringWithFormat:@"%d",FRIENDS_IATTENTION];
                [self reloadBtn];
            }
        }failure:^(NSError *error){
            
        }];
    }else if ([self.friendInfo.friendflag intValue] == FRIENDS_EACHOTHER){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"取消关注" message:@"确定取消关注" delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if ([self.friendInfo.friendflag intValue] == FRIENDS_IATTENTION){
        [RTFriendRequest fansDeleteFriend:self.friendInfo Success:^(id response){
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                self.friendInfo.friendflag = [NSString stringWithFormat:@"%d",FRIENDS_SIGNAL];
                [self reloadBtn];
            }
        }failure:^(NSError *error){
            
        }];
        
    }else if ([self.friendInfo.friendflag intValue] == FRIENDS_HEATTENTION){
        [RTFriendRequest fansCreateFriend:self.friendInfo Success:^(id response){
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                self.friendInfo.friendflag = [NSString stringWithFormat:@"%d",FRIENDS_EACHOTHER];
                [self reloadBtn];
            }
        }failure:^(NSError *error){
            
        }];
        
    }

}
- (void)reloadBtn{
    
    if ([self.friendInfo.friendflag intValue] == FRIENDS_SIGNAL || [self.friendInfo.friendflag intValue] == FRIENDS_HEATTENTION){
        [attentionBtn setBackgroundImage:[UIImage imageNamed:@"notattention.png"] forState:UIControlStateNormal];
    }else if ([self.friendInfo.friendflag intValue] == FRIENDS_EACHOTHER){
        [attentionBtn setBackgroundImage:[UIImage imageNamed:@"attentioned.png"] forState:UIControlStateNormal];
    }else if ([self.friendInfo.friendflag intValue] == FRIENDS_IATTENTION){
        [attentionBtn setBackgroundImage:[UIImage imageNamed:@"attentioned.png"] forState:UIControlStateNormal];
    }
}
- (void)getDetailInfo:(UIGestureRecognizer*)gesture{
    //回调
//    [self.delegate clickFriendHeadImageView:_imageview];
    
    MJPhoto *photo = [[MJPhoto alloc]init];
    [photo setUrl:[NSURL URLWithString:[RTUtil urlPhoto:self.friendInfo.friendphoto]]];
    photo.srcImageView = _imageview;
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    browser.photos = [[NSMutableArray alloc]initWithObjects:photo, nil];
    browser.currentPhotoIndex = 0;
    [browser show];
}


- (void)clickFans
{
    NSLog(@"点击我的粉丝");
    [self.delegate clickHisFans];
}
- (void)clickHisAttention
{
    NSLog(@"点击我的关注");
    [self.delegate clickHisAttention];
}
@end
