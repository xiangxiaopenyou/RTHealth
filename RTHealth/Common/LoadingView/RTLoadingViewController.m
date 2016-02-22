//
//  RTLoadingViewController.m
//  RTHealth
//
//  Created by cheng on 15/1/16.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTLoadingViewController.h"

@interface RTLoadingViewController ()

@end

@implementation RTLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.6;
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH- 222)/2, (SCREEN_HEIGHT- 132)/2, 222, 82)];
    NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"loading_image1.png"],[UIImage imageNamed:@"loading_image2.png"],[UIImage imageNamed:@"loading_image3.png"],[UIImage imageNamed:@"loading_image4.png"], nil];
    imageView.animationImages = images;
    imageView.animationDuration = 1.2;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
    [self.view addSubview:imageView];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH- 130)/2, (SCREEN_HEIGHT- 132)/2+92, 222, 40)];
    self.label.text = @"正在加载";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont boldSystemFontOfSize:16.0];
    [self.view addSubview:self.label];
}
- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
}
- (void)hide{
    [UIView animateWithDuration:0.2 animations:^(void){
        self.view.alpha = 0.1;
    }completion:^(BOOL finished){
        self.view.alpha = 0.6;
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
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
