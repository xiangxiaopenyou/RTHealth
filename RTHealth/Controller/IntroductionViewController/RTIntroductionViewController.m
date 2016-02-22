//
//  RTIntroductionViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 15/1/5.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTIntroductionViewController.h"
#import "RTAgeChooseViewController.h"

@interface RTIntroductionViewController (){
    UserInfo *userInfo;
}

@end

@implementation RTIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    RTUserInfo *userData = [RTUserInfo getInstance];
    userInfo = userData.userData;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
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

- (IBAction)boyButtonClick:(id)sender {
    
    userInfo.usersex = @"1";
    RTAgeChooseViewController *ageChooseViewController = [[RTAgeChooseViewController alloc] init];
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.rootNavigationController pushViewController:ageChooseViewController animated:YES];
}

- (IBAction)girlButtonClick:(id)sender {
    userInfo.usersex = @"2";
    RTAgeChooseViewController *ageChooseViewController = [[RTAgeChooseViewController alloc] init];
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.rootNavigationController pushViewController:ageChooseViewController animated:YES];
}
@end
