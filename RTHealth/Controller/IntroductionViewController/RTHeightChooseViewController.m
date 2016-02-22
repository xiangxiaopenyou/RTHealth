//
//  RTHeightChooseViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 15/1/5.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTHeightChooseViewController.h"
#import "IZValueSelectorView.h"
#import "RTWeightChooseViewController.h"

@interface RTHeightChooseViewController ()<IZValueSelectorViewDataSource, IZValueSelectorViewDelegate>{
    UIImageView *imageView;
    IZValueSelectorView *selectorView;
    UILabel *heightLabel;
    UIButton *secretButton;
    UILabel *secretLabel;
    
    BOOL isSecret;
    
    UserInfo *userInfo;
}

@end

@implementation RTHeightChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userInfo = userData.userData;
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
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
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 120, 264, 322)];
    if ([userInfo.usersex integerValue] == 1) {
        imageView.image = [UIImage imageNamed:@"height_boy.png"];
    }
    else{
        imageView.image = [UIImage imageNamed:@"height_girl.png"];
    }
    
    [self.view addSubview:imageView];
    
    selectorView = [[IZValueSelectorView alloc] initWithFrame:CGRectMake(231, 215, 42, 208)];
    selectorView.dataSource = self;
    selectorView.delegate = self;
    selectorView.shouldBeTransparent = YES;
    selectorView.horizontalScrolling = NO;
    selectorView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:selectorView];
    
    heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(96, 258, 50, 30)];
    heightLabel.text = @"120cm";
    heightLabel.font = [UIFont systemFontOfSize:15];
    heightLabel.textColor = [UIColor colorWithRed:233/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
    heightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:heightLabel];
    
    isSecret = NO;
    
    //帮我保密
    secretButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secretButton.frame = CGRectMake(90, 340, 27, 27);
    [secretButton setImage:[UIImage imageNamed:@"not_secret.png"] forState:UIControlStateNormal];
    [secretButton addTarget:self action:@selector(secretClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secretButton];
    
    secretLabel = [[UILabel alloc] initWithFrame:CGRectMake(119, 340, 60, 27)];
    secretLabel.text = @"帮我保密";
    secretLabel.font = SMALLFONT_14;
    [self.view addSubview:secretLabel];
}

- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forwardButtonClick{
    
    userInfo.userheight = [heightLabel.text substringWithRange:NSMakeRange(0, 3)];
    if (!isSecret) {
        userInfo.userheightpublic = [NSNumber numberWithInt:1];
    }
    else{
        userInfo.userheightpublic = [NSNumber numberWithInt:0];
    }
    
    RTWeightChooseViewController *weightChooseView = [[RTWeightChooseViewController alloc] init];
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.rootNavigationController pushViewController:weightChooseView animated:YES];
}

- (void)secretClick{
    if (!isSecret) {
        [secretButton setImage:[UIImage imageNamed:@"is_secret.png"] forState:UIControlStateNormal];
        isSecret = YES;
    }
    else{
        [secretButton setImage:[UIImage imageNamed:@"not_secret.png"] forState:UIControlStateNormal];
        isSecret = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - IZValueSelector dataSource
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector
{
    return 100;
}
- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector
{
    return 20;
}
- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector
{
    return 42;
}

- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index
{
    UILabel *height = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    height.text = [NSString stringWithFormat:@"%ld", 120 + index];
    height.textAlignment = NSTextAlignmentCenter;
    height.textColor = [UIColor colorWithRed:233/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
    height.font = [UIFont systemFontOfSize:10];
    height.backgroundColor = [UIColor clearColor];
    return height;
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector {
    
    return CGRectMake(0.0, 98, 42, 20);
    
}
- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index {
    NSLog(@"Selected index %ld",index);
    //ageLabel.text = [NSString stringWithFormat:@"%ld岁", 35 - index];
    heightLabel.text = [NSString stringWithFormat:@"%ldcm", 120 + index];
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
