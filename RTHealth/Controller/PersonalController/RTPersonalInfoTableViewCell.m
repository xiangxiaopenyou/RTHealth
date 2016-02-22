//
//  RTPersonalInfoTableViewCell.m
//  RTHealth
//
//  Created by cheng on 14/12/18.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPersonalInfoTableViewCell.h"
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

@implementation RTPersonalInfoTableViewCell

@synthesize imageview = _imageview , labelInstruction = _labelInstruction , labelPoint = _labelPoint , imageLeft = _imageLeft , imagesex = _imagesex,labelName = _labelName,labelAge = _labelAge,fansBtn = _fansBtn,attentionBtn = _attentionBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        RTUserInfo *userdata =[RTUserInfo getInstance];
        self.userinfo = userdata.userData;
        self.backgroundColor = [UIColor blackColor];
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        backgroundView.image = [UIImage imageNamed:@"infobackground.png"];
        [self addSubview:backgroundView];
        
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getImageInfo:)];
        
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, TOUXIANG_SIZE, TOUXIANG_SIZE)];
        [_imageview setOnlineImage:[RTUtil urlZoomPhoto:self.userinfo.userphoto]];
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
        [_fansBtn setTitle:[NSString stringWithFormat:@"粉丝(%d)",[self.userinfo.userfansnumber intValue]] forState:UIControlStateNormal];
        [_fansBtn addTarget:self action:@selector(clickFans) forControlEvents:UIControlEventTouchUpInside];
        _fansBtn.titleLabel.textColor = [UIColor whiteColor];
        _fansBtn.titleLabel.font = VERDANA_FONT_12;
        [self addSubview:_fansBtn];
        
        UILabel *labelline = [[UILabel alloc]initWithFrame:CGRectMake(60, 85, 1, 20)];
        labelline.backgroundColor = [UIColor whiteColor];
        [self addSubview:labelline];
        
        _attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionBtn.frame = CGRectMake(61, 80, 55, 30);
        [_attentionBtn setTitle:[NSString stringWithFormat:@"关注(%d)",[self.userinfo.userattentionnumber intValue]] forState:UIControlStateNormal];
        [_attentionBtn addTarget:self action:@selector(clickAttention) forControlEvents:UIControlEventTouchUpInside];
        _attentionBtn.titleLabel.textColor = [UIColor whiteColor];
        _attentionBtn.titleLabel.font = VERDANA_FONT_12;
        [self addSubview:_attentionBtn];
        
#pragma mark
        
        _imagesex = [[UIImageView alloc]initWithFrame:CGRectMake(POINT_X, POINT_Y, 15, 17)];
        if ([self.userinfo.usersex integerValue]==1) {
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
        
        if (![RTUtil isEmpty:self.userinfo.userbirthday]) {
            _labelAge.text = [NSString stringWithFormat:@"%ld",(long)[CustomDate getAgeToDate:self.userinfo.userbirthday]];
        }else{
            _labelAge.text = @"0";
        }
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(POINT_X, 15, 160, 20)];
        _labelName.text = self.userinfo.usernickname;
        _labelName.textColor = [UIColor whiteColor];
        _labelName.font = VERDANA_FONT_14;
        [self addSubview:_labelName];
        
        _labelInstruction = [[UILabel alloc]initWithFrame:CGRectMake(POINT_X, POINT_Y+POINT_HEIGHT, POINT_WIDTH, INSTRUCTION_HEIGHT)];
        _labelInstruction.text = self.userinfo.userintroduce;
        _labelInstruction.numberOfLines = 0;
        _labelInstruction.textAlignment = NSTextAlignmentLeft;
        _labelInstruction.font = VERDANA_FONT_14;
        _labelInstruction.textColor = [UIColor whiteColor];
        [self addSubview:_labelInstruction];
        

    }
    return self;
}

- (void)getImageInfo:(UIGestureRecognizer*)gesture{
    //回调
//    [self.delegate clickHeadImageView:_imageview];
    
    MJPhoto *photo = [[MJPhoto alloc]init];
    [photo setUrl:[NSURL URLWithString:[RTUtil urlPhoto:self.userinfo.userphoto]]];
    photo.srcImageView = _imageview;
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    browser.photos = [[NSMutableArray alloc]initWithObjects:photo, nil];
    browser.currentPhotoIndex = 0;
    [browser show];
}

#pragma mark 粉丝和关注的人点击delegate

- (void)clickFans{
    
    [self.delegate clickMyFans];
}

- (void)clickAttention{
    [self.delegate clickMyAttention];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
