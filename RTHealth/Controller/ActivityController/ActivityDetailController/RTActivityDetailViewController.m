//
//  RTActivityDetailViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/7.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTActivityDetailViewController.h"
#import "RTActivityJoinMemberViewController.h"
#import "RTActivtyRequest.h"
#import "RTInviteMemberViewController.h"
@interface RTActivityDetailViewController ()<MKMapViewDelegate, UIActionSheetDelegate, CLLocationManagerDelegate, UIAlertViewDelegate, LXActivityDelegate>{
    UIScrollView *scrollView;
    UserInfo *userinfo;
    
    UIAlertView *exitActivityAlert;
    UIAlertView *cancelActivityAlert;
    
    UIView *bigMapView;
    
    int contentHeight;
    float latitude;
    float longitude;
    BOOL isJoin;
    CGSize size;
    
    float positionX;
    float positionY;
    
    CLLocationManager *locationManager;
}

@property (nonatomic, assign) UIActivityIndicatorViewStyle indicatorStyle;

@end

@implementation RTActivityDetailViewController
@synthesize activity;
@synthesize joinButton;
//@synthesize isJoin;
@synthesize joinMemberArray;

- (id)initWithActivityId:(NSString *)activityId
{
    self = [super init];
    if (self) {
        if ([RTUtil isEmpty:activityId]) {
            return self;
        }
        if ([RTUtil isEmpty:self.idString]) {
            self.idString = activityId;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    isJoin = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(attentionAction) name:ATTENTIONACTION object:nil];
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"活动详情";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - 51)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    //底部View
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 51, SCREEN_WIDTH, 51)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    labelLine.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:labelLine];
    
    //邀请
    UIButton *inviteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    inviteButton.frame = CGRectMake(30, 10, 24, 28);
    [inviteButton setImage:[UIImage imageNamed:@"activity_invite.png"] forState:UIControlStateNormal];
    [inviteButton addTarget:self action:@selector(inviteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:inviteButton];
    
    UILabel *inviteLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 38, 24, 10)];
    inviteLabel.text = @"邀请";
    inviteLabel.textAlignment = NSTextAlignmentCenter;
    inviteLabel.font = SMALLFONT_10;
    inviteLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    [bottomView addSubview:inviteLabel];
    
    //转发
    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(69, 10, 24, 28);
    [forwardButton setImage:[UIImage imageNamed:@"activity_share.png"] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(forwardButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:forwardButton];
    
    UILabel *forwardLabel = [[UILabel alloc] initWithFrame:CGRectMake(69, 38, 24, 10)];
    forwardLabel.text = @"转发";
    forwardLabel.textAlignment = NSTextAlignmentCenter;
    forwardLabel.font = SMALLFONT_10;
    forwardLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    [bottomView addSubview:forwardLabel];
    
    //参加按钮
    joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    joinButton.frame = CGRectMake(SCREEN_WIDTH - 117, 11, 93, 30);
    joinButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"activity_join.png"]];
    [joinButton addTarget:self action:@selector(joinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:joinButton];
   // if ([isJoin isEqualToString:@"0"]) {
        joinButton.hidden = YES;
   // }
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        locationManager.distanceFilter = 1000.0f;
        [locationManager startUpdatingLocation];
    }
    else{
        NSLog(@"请开启定位功能");
        [self getActivityDetail];
    }
    
}

- (void)attentionAction{
    [self getJoinActivityMember];
}

#pragma mark - CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations objectAtIndex:0];
    
    positionX = location.coordinate.latitude;
    positionY = location.coordinate.longitude;
    
    [self getActivityDetail];
}

- (void)getActivityDetail
{
    if (![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:@"正在加载..."];
    }
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userinfo.userid, @"userid", userinfo.usertoken, @"usertoken", self.idString, @"activityid", nil];
    if (![RTUtil isEmpty:[NSString stringWithFormat:@"%f", positionX]]) {
        [dic setObject:[NSString stringWithFormat:@"%f", positionX] forKey:@"positionX"];
        [dic setObject:[NSString stringWithFormat:@"%f", positionY] forKey:@"positionY"];
    }
    else{
        [dic setObject:@"0" forKey:@"positionX"];
        [dic setObject:@"0" forKey:@"positionY"];
    }
    [RTActivtyRequest getActivityDetailWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"获取活动详情成功");
            activity = userinfo.activitydetail;
            [self setContentView];
            [self getJoinActivityMember];
        }
        else{
            NSLog(@"失败");
            [JDStatusBarNotification showWithStatus:@"获取活动详情失败" dismissAfter:1.4];
        }
    } failure:^(NSError *error) {
        NSLog(@"网络问题");
        [JDStatusBarNotification showWithStatus:@"请检查网络" dismissAfter:1.4];
    }];
}

- (void)setContentView
{
    //活动名称
    UILabel *activityTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, SCREEN_WIDTH - 24, 20)];
    activityTitleLabel.textAlignment = NSTextAlignmentLeft;
    activityTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    activityTitleLabel.text = activity.activitytitle;
    activityTitleLabel.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0];
    [scrollView addSubview:activityTitleLabel];
    
    //活动内容
    NSString *contentString = activity.activitycontent;
    CGSize contentSize = [contentString sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    contentHeight = contentSize.height;
    UILabel *activityContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 48, SCREEN_WIDTH - 24, contentHeight + 5)];
    activityContentLabel.font = [UIFont systemFontOfSize:13];
    activityContentLabel.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
    activityContentLabel.textAlignment = NSTextAlignmentLeft;
    activityContentLabel.text = contentString;
    activityContentLabel.numberOfLines = 0;
    activityContentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [scrollView addSubview:activityContentLabel];
    
    //活动时间
    UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 68 + contentHeight, 15, 15)];
    timeImage.image = [UIImage imageNamed:@"activity_time.png"];
    [scrollView addSubview:timeImage];
    
    size = [activity.activitytelephone sizeWithFont:[UIFont systemFontOfSize:13]];
    UILabel *activityTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 68 + contentHeight, SCREEN_WIDTH - 53, size.height)];
    activityTimeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    activityTimeLabel.textAlignment = NSTextAlignmentLeft;
    NSString *beginTimeString = [activity.activitybegintime substringWithRange:NSMakeRange(5, 11)];
    NSString *endTimeString = [activity.activityendtime substringWithRange:NSMakeRange(5, 11)];
    activityTimeLabel.text = [NSString stringWithFormat:@"%@ -- %@", beginTimeString, endTimeString];
    activityTimeLabel.font = [UIFont systemFontOfSize:13];
    [scrollView addSubview:activityTimeLabel];
    
    //活动地点
    UIImageView *placeImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 78 + size.height + contentHeight, 15, 15)];
    placeImage.image = [UIImage imageNamed:@"activity_place.png"];
    [scrollView addSubview:placeImage];
    UILabel *activityPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 78 + size.height + contentHeight, SCREEN_WIDTH - 53, size.height)];
    activityPlaceLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    activityPlaceLabel.textAlignment = NSTextAlignmentLeft;
    activityPlaceLabel.text = activity.activityplace;
    activityPlaceLabel.font = [UIFont systemFontOfSize:13];
    [scrollView addSubview:activityPlaceLabel];
    
    //联系人
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 88 + 2*size.height + contentHeight, 15, 15)];
    phoneImage.image = [UIImage imageNamed:@"activity_telephone.png"];
    [scrollView addSubview:phoneImage];
    UILabel *activityPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 88 + 2*size.height + contentHeight, SCREEN_WIDTH - 53, size.height)];
    activityPhoneLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    activityPhoneLabel.textAlignment = NSTextAlignmentLeft;
    activityPhoneLabel.text = [NSString stringWithFormat:@"%@ (%@)", activity.activitytelephone, activity.activityownernickname];
    activityPhoneLabel.textColor = [UIColor colorWithRed:252/255.0 green:95/255.0 blue:0 alpha:1.0];
    activityPhoneLabel.font = SMALLFONT_14;
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = activityPhoneLabel.frame;
    [phoneButton addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:activityPhoneLabel];
    [scrollView addSubview:phoneButton];
    
    //距离
    UIImageView *distanceImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 98 + 3*size.height + contentHeight, 15, 15)];
    distanceImage.image = [UIImage imageNamed:@"activity_distance.png"];
    [scrollView addSubview:distanceImage];
    UILabel *activityDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 98 + 3*size.height+ contentHeight, SCREEN_WIDTH - 53, size.height)];
    activityDistanceLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    activityDistanceLabel.textAlignment = NSTextAlignmentLeft;
    float distanceF = [activity.activitydistance floatValue];
    NSString *distanceString;
    if (distanceF <= 0.9) {
        distanceF *= 1000;
        NSString *distanceM = [NSString stringWithFormat:@"%.f", distanceF];
        distanceString = [NSString stringWithFormat:@"%@米", distanceM];
    }
    else{
        NSString *distanceKM = [NSString stringWithFormat:@"%.1f", distanceF];
        distanceString = [NSString stringWithFormat:@"%@公里", distanceKM];
    }
    activityDistanceLabel.text = distanceString;
    activityDistanceLabel.font = SMALLFONT_14;
    [scrollView addSubview:activityDistanceLabel];
    
    //地图位置
    latitude = [activity.positionlatitude floatValue];
    longitude = [activity.positionlongitude floatValue];
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 110 + 4*size.height + contentHeight, SCREEN_WIDTH, 120)];
    mapView.delegate = self;
    //mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeStandard;
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressMap:)];
    [mapView addGestureRecognizer:tap];
    [scrollView addSubview:mapView];
    
    CLLocationCoordinate2D coor2d = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coor2d, 1500, 1500);
    [mapView setRegion:region animated:NO];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coor2d;
    annotation.title = @"活动位置";
    [mapView addAnnotation:annotation];
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,  380 + contentHeight);
    
}

//点击联系人
- (void)phoneClick
{
//    NSURL *url = [NSURL URLWithString:@"tel:%@", activity.activitytelephone];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://%@",activity.activitytelephone]];
    UIWebView *callWebview =[[UIWebView alloc] init];
    NSString *phoneString = [NSString stringWithFormat:@"tel:%@", activity.activitytelephone];
    NSURL *telURL =[NSURL URLWithString:phoneString];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

//点击地图
- (void)pressMap:(UIGestureRecognizer*)gesture
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionFade];
    [animation setSubtype: kCATransitionFromLeft];
    [self.view.layer addAnimation:animation forKey:@"Reveal"];
    bigMapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //bigMapView.backgroundColor = [UIColor redColor];
    MKMapView *bigMap = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bigMap.delegate = self;
    bigMap.mapType = MKMapTypeStandard;
    UITapGestureRecognizer *bigViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressBigMap:)];
    [bigMap addGestureRecognizer:bigViewTap];
    [bigMapView addSubview:bigMap];
    [self.view addSubview:bigMapView];
    CLLocationCoordinate2D coor2d = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coor2d, 1000, 1000);
    [bigMap setRegion:region animated:NO];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coor2d;
    annotation.title = @"活动位置";
    [bigMap addAnnotation:annotation];
}

//点击大地图
- (void)pressBigMap:(UIGestureRecognizer*)gesture
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionFade];
    [animation setSubtype: kCATransitionFromLeft];
    [self.view.layer addAnimation:animation forKey:@"Reveal"];
    [bigMapView removeFromSuperview];
}

#pragma mark - MKMapView Delegate
- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* customPinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
    if (!customPinView) {
        customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        customPinView.pinColor = MKPinAnnotationColorRed;//设置大头针的颜色
        customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES;
        customPinView.draggable = NO;
    }
    else{
        customPinView.annotation = annotation;
    }
    return customPinView;
}

- (void)getJoinActivityMember
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userinfo.userid, @"userid", userinfo.usertoken, @"usertoken", activity.activityid, @"activityid", nil];
    [RTActivtyRequest getJoinActivityMemberWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"获取成员成功");
            //NSLog(@"response %@", response);
            
            //参与的人View
            UIView *joinMemberView = [[UIView alloc] initWithFrame:CGRectMake(0, 230 + 4*size.height + contentHeight, SCREEN_WIDTH, 90)];
            [scrollView addSubview:joinMemberView];
            //scrollView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 320 + 4*size.height + contentHeight);
            scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 320 + 4*size.height + contentHeight);
            self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
            
            UILabel *memberLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 150, 20)];
            memberLabel.text = @"参与的人";
            memberLabel.textAlignment = NSTextAlignmentLeft;
            memberLabel.font = [UIFont systemFontOfSize:15];
            memberLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
            [joinMemberView addSubview:memberLabel];
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
            [joinMemberView addSubview:line];
            
            
            if (![RTUtil isEmpty:[response objectForKey:@"data"]]) {
                joinMemberArray = [[NSMutableArray alloc] init];
                joinMemberArray = [response objectForKey:@"data"];
                
                //判断是否已经参加了该活动
                for (int i = 0; i < [joinMemberArray count]; i++) {
                    NSDictionary *dictionary = [[NSDictionary alloc] init];
                    dictionary = [joinMemberArray objectAtIndex:i];
                    if ([[dictionary objectForKey:@"userid"] isEqualToString:userinfo.userid]) {
                        isJoin = YES;
                    }
                }
                if (isJoin) {
                    joinButton.hidden = YES;
                    UIButton *cancelActivityButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    cancelActivityButton.frame = CGRectMake(SCREEN_WIDTH - 70, 22, 70, 40);
                    //[cancelActivityButton setTitle:@"取消活动" forState:UIControlStateNormal];
                    cancelActivityButton.titleLabel.font = [UIFont systemFontOfSize:15];
                    if ([userinfo.userid isEqualToString:activity.activityownerid]) {
                        [cancelActivityButton setTitle:@"取消活动" forState:UIControlStateNormal];;
                    }
                    else{
                        [cancelActivityButton setTitle:@"退出活动" forState:UIControlStateNormal];
                    }
                    [cancelActivityButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
                    [cancelActivityButton addTarget:self action:@selector(cancelActivityClick) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:cancelActivityButton];
                }
                else{
                    joinButton.hidden = NO;
                }
                
                if ([joinMemberArray count] >= 5) {
                    for (int i = 0; i < 5; i++){
                        UIImageView *memberImage = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH/6 + 10, 39, 42, 42)];
                        memberImage.layer.masksToBounds = YES;
                        memberImage.layer.cornerRadius = 21;
                        NSDictionary *dic = [joinMemberArray objectAtIndex:i];
                        [memberImage setOnlineImage:[RTUtil urlPhoto:[dic objectForKey:@"userheadportrait"]]];
                        [joinMemberView addSubview:memberImage];
                    }
                    UIImageView *moreImage = [[UIImageView alloc ] initWithFrame:CGRectMake(5 * SCREEN_WIDTH/6 + 7, 43, 43, 33)];
                    [moreImage setImage:[UIImage imageNamed:@"join_member_more.png"]];
                    [joinMemberView addSubview:moreImage];
                }
                else{
                    for (int i = 0; i < [joinMemberArray count]; i++){
                        UIImageView *memberImage = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH/6 + 10, 39, 42, 42)];
                        memberImage.layer.masksToBounds = YES;
                        memberImage.layer.cornerRadius = 21;
                        NSDictionary *dic = [joinMemberArray objectAtIndex:i];
                        [memberImage setOnlineImage:[RTUtil urlPhoto:[dic objectForKey:@"userheadportrait"]]];
                        [joinMemberView addSubview:memberImage];
                    }
                }
                
                UITapGestureRecognizer *joinMemberTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(joinMemberClick:)];
                [joinMemberView addGestureRecognizer:joinMemberTap];
                joinMemberView.userInteractionEnabled = YES;
                
                [JDStatusBarNotification showWithStatus:@"获取活动详情成功√" dismissAfter:1.4f];
            }
            else{
                [JDStatusBarNotification showWithStatus:@"获取成员失败" dismissAfter:1.4f];
            }
        }
        else{
            NSLog(@"获取失败");
            [JDStatusBarNotification showWithStatus:@"获取成员失败咯~" dismissAfter:1.4];
        }
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)inviteButtonClick
{
    NSLog(@"点击了邀请");
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTInviteMemberViewController *inviteViewController = [[RTInviteMemberViewController alloc] init];
    inviteViewController.activityId = activity.activityid;
    [appDelegate.rootNavigationController pushViewController:inviteViewController animated:YES];
}

- (void)forwardButtonClick
{
    NSArray *shareButtonTitleArray = @[@"新浪微博",@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"];
    NSArray *shareButtonImageNameArray = @[@"sns_icon_1",@"sns_icon_22",@"sns_icon_23",@"sns_icon_24",@"sns_icon_40"];
    
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self.view];
}

#pragma mark - LXActivityDelegate
- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    switch ((int)imageIndex) {
        case 0:
            [appDelegate sharedWeiboTimeLine:@"健身坊活动分享" Description:activity.activitytitle objectID:activity.activityid url:[NSString stringWithFormat:@"%@%@?activityid=%@&userid=%@", URL_BASE, URL_ACTIVITY_SHARE, activity.activityid, activity.activityownerid]];
            break;
            
        case 1:
            [appDelegate sendLinkContent:@"健身坊活动分享" Description:activity.activitytitle Url:[NSString stringWithFormat:@"%@%@?activityid=%@&userid=%@", URL_BASE, URL_ACTIVITY_SHARE, activity.activityid, activity.activityownerid] Photo:[RTUtil urlZoomPhoto:@"icon"]];
            break;
        case 2:
            [appDelegate sendLinkContentTimeLine:[NSString stringWithFormat:@"健身坊活动分享--%@", activity.activitytitle]  Description:activity.activitytitle Url:[NSString stringWithFormat:@"%@%@?activityid=%@&userid=%@", URL_BASE, URL_ACTIVITY_SHARE, activity.activityid, activity.activityownerid] Photo:[RTUtil urlZoomPhoto:@"icon"]];
            break;
        case 3:
            [appDelegate sharedQQFriendTitle:@"健身坊活动分享" description:activity.activitytitle url:[NSString stringWithFormat:@"%@%@?activityid=%@&userid=%@", URL_BASE, URL_ACTIVITY_SHARE, activity.activityid, activity.activityownerid] Photo:[RTUtil urlZoomPhoto:@"icon"]];
            break;
        case 4:
            [appDelegate sharedQZoneTitle:@"健身坊活动分享" description:activity.activitytitle url:[NSString stringWithFormat:@"%@%@?activityid=%@&userid=%@", URL_BASE, URL_ACTIVITY_SHARE, activity.activityid, activity.activityownerid] Photo:[RTUtil urlZoomPhoto:@"icon"]];
            break;
        default:
            break;
    }
}

- (void)joinButtonClick
{
    joinButton.enabled = NO;
    NSLog(@"点击了参加");
    if (![JDStatusBarNotification isVisible]) {
        self.indicatorStyle = UIActivityIndicatorViewStyleGray;
        [JDStatusBarNotification showWithStatus:@"加入活动中..."];
    }
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:self.indicatorStyle];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userinfo.userid, @"userid", userinfo.usertoken, @"usertoken", activity.activityid, @"activityid", nil];
    [RTActivtyRequest joinActivityWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"]  integerValue] == 1000) {
            NSLog(@"参加活动成功");
            [JDStatusBarNotification showWithStatus:@"成功加入活动√" dismissAfter:1.4];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:CREATEACTIVITYSUCCESS object:@YES];
        }
        else{
            NSLog(@"参加活动失败");
            [JDStatusBarNotification showWithStatus:@"加入活动失败喽~" dismissAfter:1.4];
            joinButton.enabled = YES;
        }
    } failure:^(NSError *error) {
        NSLog(@"失败");
        [JDStatusBarNotification dismiss];
        joinButton.enabled = YES;
    }];
}

- (void)cancelActivityClick
{
    
    if (![userinfo.userid isEqualToString:activity.activityownerid]) {
        exitActivityAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出该活动吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [exitActivityAlert show];
        NSLog(@"点击了退出活动");
        
    }
    else{
        NSLog(@"点击了取消活动");
        cancelActivityAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要取消该活动吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [cancelActivityAlert show];
        
    }
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == exitActivityAlert) {
        if (buttonIndex == 1) {
            if (![JDStatusBarNotification isVisible]) {
                self.indicatorStyle = UIActivityIndicatorViewStyleGray;
                [JDStatusBarNotification showWithStatus:@"退出活动中..."];
            }
            [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:self.indicatorStyle];
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userinfo.userid, @"userid", userinfo.usertoken, @"usertoken", activity.activityid, @"activityid", nil];
            [RTActivtyRequest exitActivityWith:dic success:^(id response) {
                if ([[response objectForKey:@"state"] integerValue] == 1000) {
                    NSLog(@"退出活动成功");
                    [JDStatusBarNotification showWithStatus:@"退出活动成功√" dismissAfter:1.4];
                    [[NSNotificationCenter defaultCenter] postNotificationName:CREATEACTIVITYSUCCESS object:@YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    NSLog(@"退出活动失败");
                    [JDStatusBarNotification showWithStatus:@"退出活动失败" dismissAfter:1.4];
                }
            } failure:^(NSError *error) {
                NSLog(@"失败");
                [JDStatusBarNotification dismiss];
            }];
        }
    }
    else{
        if (buttonIndex == 1) {
            if (![JDStatusBarNotification isVisible]) {
                self.indicatorStyle = UIActivityIndicatorViewStyleGray;
                [JDStatusBarNotification showWithStatus:@"取消活动中..."];
            }
            [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:self.indicatorStyle];
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userinfo.userid, @"userid", userinfo.usertoken, @"usertoken", activity.activityid, @"activityid", nil];
            [RTActivtyRequest cancelActivityWith:dic success:^(id response) {
                if ([[response objectForKey:@"state"] integerValue] == 1000) {
                    NSLog(@"取消活动成功");
                    [JDStatusBarNotification showWithStatus:@"取消活动成功√" dismissAfter:1.4];
                    [self.navigationController popViewControllerAnimated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:CREATEACTIVITYSUCCESS object:@YES];
                }
                else{
                    NSLog(@"取消活动失败");
                    [JDStatusBarNotification showWithStatus:@"取消活动失败" dismissAfter:1.4];
                }
            } failure:^(NSError *error) {
                NSLog(@"失败");
                [JDStatusBarNotification dismiss];
            }];
        }
    }
}

- (void)joinMemberClick:(UITapGestureRecognizer*)gesture
{
    NSLog(@"点击了参加的人");
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTActivityJoinMemberViewController *joinMemberView = [[RTActivityJoinMemberViewController alloc] init];
    joinMemberView.joinArray = joinMemberArray;
    [appDelegate.rootNavigationController pushViewController:joinMemberView animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
