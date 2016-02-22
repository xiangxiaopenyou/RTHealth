//
//  RTWeightChooseViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 15/1/6.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTWeightChooseViewController.h"
#import "IZValueSelectorView.h"
#import "RTSportsChooseViewController.h"

@interface RTWeightChooseViewController ()<IZValueSelectorViewDelegate, IZValueSelectorViewDataSource>{
    UIImageView *imageView;
    IZValueSelectorView *selectorView;
    UILabel *weightLabel;
    
    UIButton *secretButton;
    UILabel *secretLabel;
    
    BOOL isSecret;
    
    UserInfo *userInfo;
}

@end

@implementation RTWeightChooseViewController

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
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(54, 120, 212, 256)];
    if ([userInfo.usersex integerValue] == 1) {
        imageView.image = [UIImage imageNamed:@"weight_boy.png"];
    }
    else{
        imageView.image = [UIImage imageNamed:@"weight_girl.png"];
    }
    
    [self.view addSubview:imageView];
    
    selectorView = [[IZValueSelectorView alloc] initWithFrame:CGRectMake(96, 333, 126, 35)];
    selectorView.dataSource = self;
    selectorView.delegate = self;
    selectorView.shouldBeTransparent = YES;
    selectorView.horizontalScrolling = YES;
    selectorView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:selectorView];
    
    weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(134, 250, 60, 30)];
    weightLabel.text = @"30KG";
    weightLabel.font = [UIFont systemFontOfSize:15];
    weightLabel.textColor = [UIColor colorWithRed:233/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
    weightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:weightLabel];
    
    isSecret = NO;
    
    //帮我保密
    secretButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secretButton.frame = CGRectMake(115, 390, 27, 27);
    [secretButton setImage:[UIImage imageNamed:@"not_secret.png"] forState:UIControlStateNormal];
    [secretButton addTarget:self action:@selector(secretClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secretButton];
    
    secretLabel = [[UILabel alloc] initWithFrame:CGRectMake(144, 390, 60, 27)];
    secretLabel.text = @"帮我保密";
    secretLabel.font = SMALLFONT_14;
    [self.view addSubview:secretLabel];
}

- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forwardButtonClick{
    if (!isSecret) {
        userInfo.userweightpublic = [NSNumber numberWithInt:1];
    }
    else{
        userInfo.userweightpublic = [NSNumber numberWithInt:0];
    }
    
    userInfo.userweight = [weightLabel.text substringWithRange:NSMakeRange(0, weightLabel.text.length - 2)];
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTSportsChooseViewController *sportsChooseViewController = [[RTSportsChooseViewController alloc] init];
    [appDelegate.rootNavigationController pushViewController:sportsChooseViewController animated:YES];
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

#pragma  mark - IZValueSelector dataSource
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector
{
    return 120;
}
- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector
{
    return 35;
}
- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector
{
    return 50;
}

- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index
{
    UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    yearLabel.text = [NSString stringWithFormat:@"%d", 30 + index];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    yearLabel.textColor = [UIColor colorWithRed:18/255.0 green:122/255.0 blue:134/255.0 alpha:1.0];
    yearLabel.font = [UIFont systemFontOfSize:15];
    yearLabel.backgroundColor = [UIColor clearColor];
    return yearLabel;
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector {
    
    return CGRectMake(selectorView.frame.size.width/2 - 24, 0.0, 50.0, 35.0);
    
}
- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index {
    NSLog(@"Selected index %ld",(long)index);
    weightLabel.text = [NSString stringWithFormat:@"%dKG", 30 + index];
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
