//
//  RTFoodWebViewController.m
//  RTHealth
//
//  Created by cheng on 15/1/9.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTFoodWebViewController.h"

@interface RTFoodWebViewController ()

@end

@implementation RTFoodWebViewController

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
    [self refreshPage];
}


- (void)refreshPage{
    if ([RTUtil isEmpty: self.url]) {
        return;
    }
    [webView_ loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (void)backClick{
    [CATransaction begin];
    //foo
    [self.navigationController popViewControllerAnimated:YES];
    [CATransaction commit];
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

@end
