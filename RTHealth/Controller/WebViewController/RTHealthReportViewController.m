//
//  RTHealthReportViewController.m
//  RTHealth
//
//  Created by cheng on 15/1/15.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTHealthReportViewController.h"

@interface RTHealthReportViewController ()<LXActivityDelegate>{
    
    UIButton *rightBtn;
}

@end

@implementation RTHealthReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = [RTUtil isEmpty:self.title]?@"资讯":self.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 75, (44-26)/2+20, 65, 26);
    [rightBtn addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"showplan_web.png"] forState:UIControlStateNormal];
    [rightBtn setHidden:NO];
    [self.view addSubview:rightBtn];
    
    [self refreshPage];
}
- (void)clickRight{
    NSArray *shareButtonTitleArray = @[@"新浪微博",@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"];
    NSArray *shareButtonImageNameArray = @[@"sns_icon_1",@"sns_icon_22",@"sns_icon_23",@"sns_icon_24",@"sns_icon_40"];
    
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self.view];
}

- (void)refreshPage{
    if ([RTUtil isEmpty: self.url]) {
        return;
    }
    [webView_ loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (void)backClick{
    //foo
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
}

#pragma mark - UIWebViewDelegate


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"url %@",request.URL);
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSLog(@" url %@",request.URL);
    }else if (navigationType == UIWebViewNavigationTypeBackForward) {
        NSLog(@"back forward");
        if (![webView_ canGoBack]) {
        }
    }
    return YES;
}

#pragma mark - LXActivityDelegate

- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    NSLog(@"%d",(int)imageIndex);
    NSString *string = @"这是我的健康报告，围观啦";
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSString *urlString = [NSString stringWithFormat:@"%@%@?userid=%@",URL_BASE,URL_DISCOVER_HELP,userinfo.userid];
    NSString *descrition = @"";
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    switch ((int)imageIndex) {
        case 0:{
            [appDelegate sharedWeiboTimeLine:string Description:descrition objectID:userinfo.userid url:urlString photo:UIImageJPEGRepresentation(([UIImage imageNamed:@"icon.png"]), 1.0)];
        }break;
        case 1:{
            [appDelegate sendLinkContent:string Description:descrition Url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 2:{
            [appDelegate sendLinkContentTimeLine:string Description:descrition Url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 3:{
            [appDelegate sharedQQFriendTitle:string description:descrition url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 4:{
            [appDelegate sharedQZoneTitle:string description:descrition url:urlString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        default:
            break;
    }
}

- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}

@end
