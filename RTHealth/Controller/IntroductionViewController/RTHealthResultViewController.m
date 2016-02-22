//
//  RTHealthResultViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 15/1/7.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTHealthResultViewController.h"
#import "RTRecommendedPlanViewController.h"
#import "RTPersonalRequest.h"

#define PER 4.97297297

@interface RTHealthResultViewController (){
    UIImageView *imageView;
    
    UserInfo *_userinfo;
}

@end

@implementation RTHealthResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    RTUserInfo *userData = [RTUserInfo getInstance];
    _userinfo = userData.userData;
    
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
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 110, 288, 356)];
    if ([_userinfo.usersex integerValue] == 1) {
        
        imageView.image = [UIImage imageNamed:@"health_result_boy.png"];
    }
    else{
        imageView.image = [UIImage imageNamed:@"health_result_girl.png"];
    }
    
    [self.view addSubview:imageView];
    
    //体重
    UILabel *wLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 347.5, 50, 15)];
    wLabel.text = [NSString stringWithFormat:@"%@KG", _userinfo.userweight];
    wLabel.font = SMALLFONT_12;
    wLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self.view addSubview:wLabel];
    
    //身高
    UILabel *hLabel = [[UILabel alloc] initWithFrame:CGRectMake(187, 347.5, 50, 15)];
    hLabel.text = [NSString stringWithFormat:@"%@cm",_userinfo.userheight];
    hLabel.font = SMALLFONT_12;
    hLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self.view addSubview:hLabel];
    
    //计算BMI
    float BMIValue = [_userinfo.userweight floatValue]/(([_userinfo.userheight floatValue]*[_userinfo.userheight floatValue])/10000);
    
    //BMI
    UILabel *BMIMapLabel = [[UILabel alloc] initWithFrame:CGRectMake(79, 379.5, BMIValue * PER, 14)];
    if (BMIValue >= 40.6) {
        BMIMapLabel.frame = CGRectMake(79, 379.5, 202, 14);
    }
    if (BMIValue < 18.5) {
        BMIMapLabel.backgroundColor = [UIColor colorWithRed:169/255.0 green:99/255.0 blue:68/255.0 alpha:1.0];
    }
    else if (BMIValue >= 18.5 && BMIValue <= 24){
        BMIMapLabel.backgroundColor = [UIColor colorWithRed:233/255.0 green:77/255.0 blue:75/255.0 alpha:1.0];
    }
    else{
        BMIMapLabel.backgroundColor = [UIColor colorWithRed:226/255.0 green:59/255.0 blue:57/255.0 alpha:1.0];
    }
    [self.view addSubview:BMIMapLabel];
    
    //BMI值
    UILabel *BMIValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 +BMIValue * PER - 40, 379.5, 35, 14)];
    if (BMIValue >= 40.6) {
        BMIValueLabel.frame = CGRectMake(242, 379.5, 35, 14);
    }
    BMIValueLabel.text = [NSString stringWithFormat:@"%.1f", BMIValue];
    BMIValueLabel.textAlignment = NSTextAlignmentRight;
    BMIValueLabel.font = SMALLFONT_12;
    BMIValueLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:BMIValueLabel];
    
    //得分
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 190, 66, 40)];
    int score;
    if (BMIValue <= 21.25) {
        score = 4.7 * BMIValue;
    }
    else if (BMIValue > 21.25 && BMIValue <= 24){
        score = 240 - 6.7*BMIValue;
    }
    else if (BMIValue > 24 && BMIValue <= 28){
        score = 200 - 5.1 * BMIValue;
    }
    else if (BMIValue > 28 && BMIValue <= 100){
        score = 83 - 0.83 * BMIValue;
    }
    else{
        score = 0;
    }
    scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    //scoreLabel.text = @"100";
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.font = [UIFont systemFontOfSize:36];
    scoreLabel.textColor = [UIColor colorWithRed:233/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
    [self.view addSubview:scoreLabel];
    
    //超过多少用户
    UILabel *percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(217, 278.2, 30, 20)];
    int percent;
    if (score <= 60) {
        percent = 0.5*score;
    }
    else{
        percent = 1.7*score - 71;
    }
    percentLabel.text = [NSString stringWithFormat:@"%d%@", percent, @"%"];
    percentLabel.font = SMALLFONT_12;
    percentLabel.textColor = [UIColor colorWithRed:233/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
    [self.view addSubview:percentLabel];
    
    
}

- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forwardButtonClick{
    
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    RTRecommendedPlanViewController *recommendedPlanViewController = [[RTRecommendedPlanViewController alloc] init];
    [appDelegate.rootNavigationController pushViewController:recommendedPlanViewController animated:YES];
    
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
