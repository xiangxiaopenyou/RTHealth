//
//  RTFirstLaunchedViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 15/1/9.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTFirstLaunchedViewController.h"
#import "RTLoginViewController.h"
#import "RTRegisterViewController.h"

@interface RTFirstLaunchedViewController ()<UIScrollViewDelegate>{
    UIScrollView *launchedScrollView;
    UIPageControl *pageControl;
    UIButton *enterButton;
}

@end

@implementation RTFirstLaunchedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // Do any additional setup after loading the view from its nib.
    
    launchedScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    launchedScrollView.pagingEnabled = YES;
    launchedScrollView.showsHorizontalScrollIndicator = NO;
    launchedScrollView.bounces = NO;
    launchedScrollView.delegate = self;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*launchedScrollView.frame.size.width, 0, launchedScrollView.frame.size.width, launchedScrollView.frame.size.height)];
        if (SCREEN_HEIGHT <= 480) {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"launched%d_small.png", i + 1]];
        }
        else{
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"launched%d_big.png", i + 1]];
        }
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        [launchedScrollView addSubview:imageView];
        
    }
    launchedScrollView.contentSize = CGSizeMake(3*self.view.frame.size.width, 0);
    [self.view addSubview:launchedScrollView];
    
    
    pageControl = [[UIPageControl alloc] init];
    if (SCREEN_HEIGHT <= 480) {
        pageControl.frame = CGRectMake(106, launchedScrollView.frame.size.height - 100, 108, 30);

    }
    else{
        pageControl.frame = CGRectMake(106, launchedScrollView.frame.size.height - 115, 108, 30);
    }
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
    
    enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (SCREEN_HEIGHT <= 480) {
        enterButton.frame = CGRectMake(2*launchedScrollView.frame.size.width + 25, launchedScrollView.frame.size.height - 151, 271, 37);
    }
    else{
        enterButton.frame = CGRectMake(2*launchedScrollView.frame.size.width + 25, launchedScrollView.frame.size.height - 182, 271, 37);
    }
    [enterButton setImage:[UIImage imageNamed:@"enter_button.png"] forState:UIControlStateNormal];
    [enterButton addTarget:self action:@selector(enterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [launchedScrollView addSubview:enterButton];
    
}

- (void)enterButtonClick{
    RTLoginViewController *loginViewController = [[RTLoginViewController alloc] init];
    //loginViewController.isFirstLaunched = YES;
    [self.navigationController pushViewController:loginViewController animated:YES];
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageControl.currentPage = floor(scrollView.contentOffset.x/scrollView.frame.size.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
