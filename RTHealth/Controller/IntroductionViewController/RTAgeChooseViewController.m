//
//  RTAgeChooseViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 15/1/5.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTAgeChooseViewController.h"

@interface RTAgeChooseViewController ()<UIScrollViewDelegate, IZValueSelectorViewDataSource, IZValueSelectorViewDelegate>{
    UILabel *ageLabel;
    UIImageView *imageView;
    UIButton *backButton;
    UIButton *forwardButton;
    UserInfo *userInfo;
}

@end

@implementation RTAgeChooseViewController
@synthesize yearSelector;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    RTUserInfo *userData = [RTUserInfo getInstance];
    userInfo = userData.userData;
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    //后退按钮
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(12, 40, 60, 60);
    [backButton setImage:[UIImage imageNamed:@"last.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //前进按钮
    forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(SCREEN_WIDTH - 72, 40, 60, 60);
    [forwardButton setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(forwardButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forwardButton];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 120, 300, 233)];
    if ([userInfo.usersex integerValue] == 1) {
        imageView.image = [UIImage imageNamed:@"age_boy.png"];
    }
    else{
        imageView.image = [UIImage imageNamed:@"age_girl.png"];
    }
    [self.view addSubview:imageView];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(12, 354, SCREEN_WIDTH - 24, 55)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    yearSelector = [[IZValueSelectorView alloc] initWithFrame:CGRectMake(12, 354, SCREEN_WIDTH - 24, 55)];
    yearSelector.dataSource = self;
    yearSelector.delegate = self;
    yearSelector.shouldBeTransparent = YES;
    yearSelector.horizontalScrolling = YES;
    yearSelector.backgroundColor = [UIColor clearColor];
    [self.view addSubview:yearSelector];
    
    ageLabel = [[UILabel alloc ]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 25, 263, 50, 30)];
    ageLabel.textColor = [UIColor colorWithRed:233/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
    ageLabel.text = @"0岁";
    ageLabel.textAlignment = NSTextAlignmentCenter;
    ageLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:ageLabel];
}

- (void)backButtonClick{
    NSLog(@"点击了返回");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forwardButtonClick{
    NSString *ageString = [ageLabel.text substringWithRange:NSMakeRange(0, [ageLabel.text length] - 1)];
    NSInteger year;
    NSString *nowYearString = [[CustomDate getDateString:[NSDate date]] substringWithRange:NSMakeRange(0, 4)];
    year = [nowYearString integerValue] - [ageString integerValue];
    userInfo.userbirthday = [NSString stringWithFormat:@"%ld-01-01", (long)year];
    RTHeightChooseViewController *heightChooseView = [[RTHeightChooseViewController alloc] init];
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.rootNavigationController pushViewController:heightChooseView animated:YES];
}

#pragma  mark - IZValueSelector dataSource
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector
{
    return 67;
}
- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector
{
    return 55;
}
- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector
{
    return 20;
}

- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index
{
    UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 0, 10, 55)];
    yearLabel.text = [NSString stringWithFormat:@"%d", 2015 - index];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    yearLabel.numberOfLines = 0;
    yearLabel.lineBreakMode = NSLineBreakByCharWrapping;
    yearLabel.textColor = [UIColor colorWithRed:233/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
    yearLabel.font = SMALLFONT_10;
    yearLabel.backgroundColor = [UIColor clearColor];
     return yearLabel;
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector {

    return CGRectMake(yearSelector.frame.size.width/2 - 10, 0.0, 20, 100.0);
   
}
- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index {
    NSLog(@"Selected index %ld",(long)index);
    ageLabel.text = [NSString stringWithFormat:@"%d岁", 0 + index];
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
