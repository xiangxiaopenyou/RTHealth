//
//  RTPlanOtherWebViewController.m
//  RTHealth
//
//  Created by cheng on 15/1/7.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTPlanOtherWebViewController.h"
#import "PopoverView.h"
#import "RTOtherSmallPlanViewController.h"
#import "RTPlanRequest.h"
#import "RTPlanPopView.h"

@interface RTPlanOtherWebViewController ()<PopoverViewDelegate,RTPlanPopViewDelegate,LXActivityDelegate>{
    PopoverView *settingPlanView;
}

@end

@implementation RTPlanOtherWebViewController

@synthesize plan = plan;


- (id)initWith:(HealthPlan*)healthPlan{
    self = [super init];
    if (self) {
        plan = healthPlan;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"计划概要";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    UIButton *btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMessage.frame = CGRectMake(SCREEN_WIDTH - 67, (NAVIGATIONBAR_HEIGHT - 44) +6 , 57, 32);
    [btnMessage addTarget:self action:@selector(settingCilck) forControlEvents:UIControlEventTouchUpInside];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"settingplan.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnMessage];
    
    [RTPlanRequest detailWithPlan:plan success:^(id response){
        if ([[response objectForKey:@"state"] integerValue] == URL_NORMAL) {
        
        }else{
            
        }
    }failure:^(NSError *error){
        
    }];
    
    [self refreshPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)settingCilck
{
    CGPoint point = CGPointMake(SCREEN_WIDTH - 22.5, NAVIGATIONBAR_HEIGHT);
    RTPlanPopView *popoverView = [[RTPlanPopView alloc]initWithFrame:CGRectMake(0, 0, 150,150)];
    popoverView.delegate = self;
    
    settingPlanView = [[PopoverView alloc]init];
    settingPlanView.delegate = self;
    [settingPlanView showAtPoint:point inView:self.view withContentView:popoverView];
}

#pragma mark - PopoverViewDelegate Methods

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    
    [popoverView showImage:[UIImage imageNamed:@"success"] withMessage:@"123"];
    //Dismiss the PopoverView after 0.5 seconds
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - RTPopOverViewDelegate

- (void)clickPlanPopItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:{
            [RTPlanRequest importWithPlan:plan success:^(id response){
                type = 1;
                
            }failure:^(NSError *error){
                
            }];
        }break;
        case 1:{
            if (![RTUtil isEmpty: plan.plancreateuserid]) {
                    RTFriendInfoTableViewController *friendInfo = [[RTFriendInfoTableViewController alloc]initWithFriendid:plan.plancreateuserid];
                    [self.navigationController pushViewController:friendInfo animated:YES];
                }
        }break;
        case 2:{
            //分享给朋友
            [self sharedCilck];
        }break;
        default:
            break;
    }
    
    [settingPlanView dismiss];
}

- (void)sharedCilck{
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
            [appDelegate sharedWeiboTimeLine:plan.plantitle Description:plan.plancontent objectID:plan.planid url:webView_.request.URL.absoluteString photo:UIImageJPEGRepresentation(([UIImage imageNamed:@"icon.png"]), 1.0)];
        }break;
        case 1:{
            [appDelegate sendLinkContent:plan.plantitle Description:plan.plancontent Url:webView_.request.URL.absoluteString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 2:{
            [appDelegate sendLinkContentTimeLine:plan.plantitle Description:plan.plancontent Url:webView_.request.URL.absoluteString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 3:{
            [appDelegate sharedQQFriendTitle:plan.plantitle description:plan.plancontent url:webView_.request.URL.absoluteString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        case 4:{
            [appDelegate sharedQZoneTitle:plan.plantitle description:plan.plancontent url:webView_.request.URL.absoluteString Photo:[RTUtil urlZoomPhoto:@"icon"]];
        }break;
        default:
            break;
    }
}

- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}

#pragma mark -- fresh

- (void)refreshPage{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?userid=%@&planid=%@",URL_BASE,URL_PLAN_WEBDETAIL,self.friendInfo.friendid,plan.planid];
    NSLog(@"%@,",url);
    [webView_ loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark - UIWebViewDelegate


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"1 %@",request.URL);
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSLog(@" url %@",request.URL);
        RTOtherSmallPlanViewController *smallPlanController = [[RTOtherSmallPlanViewController alloc]init];
        smallPlanController.url = request.URL.absoluteString;
        [self.navigationController pushViewController:smallPlanController animated:YES];
        return NO;
    }
    
    else if (navigationType == UIWebViewNavigationTypeBackForward) {
        NSLog(@"back forward");
        if (![webView_ canGoBack]) {
        }
    }return YES;
}

@end
