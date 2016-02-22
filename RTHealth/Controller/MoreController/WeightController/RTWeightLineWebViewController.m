//
//  RTWeightLineWebViewController.m
//  RTHealth
//
//  Created by cheng on 15/1/6.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTWeightLineWebViewController.h"

@interface RTWeightLineWebViewController ()

@end

@implementation RTWeightLineWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = [RTUtil isEmpty:self.title]?@"体重曲线":self.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    [self refreshPage];
    
}
- (void)refreshPage{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSString *url = [NSString stringWithFormat:@"%@%@?userid=%@",URL_BASE,URL_WEIGHT_LINE,userinfo.userid];
    [webView_ loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
