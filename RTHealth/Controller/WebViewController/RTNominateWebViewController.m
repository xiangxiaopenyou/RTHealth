//
//  RTNominateWebViewController.m
//  RTHealth
//
//  Created by cheng on 15/1/6.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTNominateWebViewController.h"

@interface RTNominateWebViewController ()<LXActivityDelegate>

@end

@implementation RTNominateWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMessage.frame = CGRectMake(SCREEN_WIDTH - 67, (NAVIGATIONBAR_HEIGHT - 44) +6 , 57, 32);
    [btnMessage addTarget:self action:@selector(settingCilck) forControlEvents:UIControlEventTouchUpInside];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"settingplan.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnMessage];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = [RTUtil isEmpty:self.title]?@"每日推荐":self.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    [self refreshPage];

}
- (void)refreshPage{
    if ([RTUtil isEmpty: self.url]) {
        return;
    }
    [webView_ loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)settingCilck{
    NSArray *shareButtonTitleArray = @[@"新浪微博",@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"];
    NSArray *shareButtonImageNameArray = @[@"sns_icon_1",@"sns_icon_22",@"sns_icon_23",@"sns_icon_24",@"sns_icon_40"];
    
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self.view];
    
}

#pragma mark - LXActivityDelegate

- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    NSLog(@"%d",(int)imageIndex);
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    switch ((int)imageIndex) {
        case 0:{
            [appDelegate sharedWeiboTimeLine:self.title Description:self.content objectID:self.title url:self.url photo:[NSData dataWithContentsOfURL:[NSURL URLWithString:[RTUtil urlZoomPhoto:self.photo]]]];
        }break;
        case 1:{
            [appDelegate sendLinkContent:self.title Description:self.content Url:self.url Photo:[RTUtil urlZoomPhoto:self.photo]];
        }break;
        case 2:{
            [appDelegate sendLinkContentTimeLine:self.title Description:self.content Url:self.url Photo:[RTUtil urlZoomPhoto:self.photo]];
        }break;
        case 3:{
            [appDelegate sharedQQFriendTitle:self.title description:self.content url:self.url Photo:[RTUtil urlZoomPhoto:self.photo]];
        }break;
        case 4:{
            [appDelegate sharedQZoneTitle:self.title description:self.content url:self.url Photo:[RTUtil urlZoomPhoto:self.photo]];
        }break;
        default:
            break;
    }
}

- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}

#pragma mark - UIWebViewDelegate


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"1 %@",request.URL);
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSLog(@" url %@",request.URL);
    }
    
    else if (navigationType == UIWebViewNavigationTypeBackForward) {
        NSLog(@"back forward");
        if (![webView_ canGoBack]) {
        }
    }return YES;
}

@end
