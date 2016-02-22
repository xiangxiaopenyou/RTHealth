//
//  RTSportsChooseViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 15/1/6.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTSportsChooseViewController.h"
#import "RTSportsSelectView.h"
#import "RTHealthResultViewController.h"

@interface RTSportsChooseViewController (){
    UIImageView *imageView;
    
    NSArray *sportsNameArray;
    UserInfo *userInfo;
}

@end

@implementation RTSportsChooseViewController
@synthesize selecctedArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    RTUserInfo *userData = [RTUserInfo getInstance];
    userInfo = userData.userData;
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    sportsNameArray = [NSArray arrayWithObjects:@"跑步", @"慢走", @"力量训练", @"瑜伽", @"骑行", @"篮球", @"足球", @"乒乓球", @"羽毛球",@"网球", nil];
    if (!selecctedArray) {
        selecctedArray = [[NSMutableArray alloc] init];
    }
    
    //后退按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(12, 40, 60, 60);
    [backButton setImage:[UIImage imageNamed:@"last.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //前进按钮
    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(SCREEN_WIDTH - 72, 40, 60, 60);
    [forwardButton setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(forwardButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forwardButton];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 366)];
    if ([userInfo.usersex integerValue]==1) {
        imageView.image = [UIImage imageNamed:@"sports_boy.png"];
    }
    else{
        imageView.image = [UIImage imageNamed:@"sports_girl.png"];
    }
    
    [self.view addSubview:imageView];
    
    [self addView];
    
}

- (void)addView{
    for(int i = 0; i < sportsNameArray.count; i++){
        RTSportsSelectView *viewSelect = [[RTSportsSelectView alloc] init];
        viewSelect.backgroundColor = [UIColor clearColor];
        viewSelect.frame = CGRectMake(45 + i%5 * 46, (i/5)*61 + 318, 46, 61);
        viewSelect.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%02d.png",i + 3]];
        viewSelect.labelName.text = [sportsNameArray objectAtIndex:i];
        viewSelect.tag = i;
        [self.view addSubview:viewSelect];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sportsPress:)];
        [viewSelect addGestureRecognizer:tap];

    }
}

- (void)sportsPress:(UITapGestureRecognizer *)gesture{
    RTSportsSelectView *view = (RTSportsSelectView*)gesture.view;
    if (view.selected == YES){
        view.selected =NO;
        [self.selecctedArray removeObject:[NSString stringWithFormat:@"%02ld",(long)view.tag]];
    }else{
        view.selected = YES;
        [self.selecctedArray addObject:[NSString stringWithFormat:@"%02ld",(long)view.tag]];
    }
    [view setNeedsDisplay];
}

- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forwardButtonClick{
    NSString *sportsString = [[NSString alloc] init];
    for (int i = 0; i < selecctedArray.count; i++) {
        NSNumber *number = [selecctedArray objectAtIndex:i];
        if (i == 0) {
            sportsString = [NSString stringWithFormat:@"%02ld", (long)[number integerValue] + 3];
        }
        else{
            sportsString = [NSString stringWithFormat:@"%@:%02ld", sportsString, (long)[number integerValue] + 3];
        }
    }
    if (selecctedArray.count == 0) {
        userInfo.userfavoritesports = nil;
    }
    else{
        userInfo.userfavoritesports = sportsString;
    }
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTHealthResultViewController *healthResultViewController = [[RTHealthResultViewController alloc] init];
    [appDelegate.rootNavigationController pushViewController:healthResultViewController animated:YES];
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
