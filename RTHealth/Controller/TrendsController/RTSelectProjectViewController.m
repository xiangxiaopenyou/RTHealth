//
//  RTSelectProjectViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTSelectProjectViewController.h"
#import "RTProjectSelectView.h"

@interface RTSelectProjectViewController (){
    NSArray *projectName;
    NSArray *projectPicName;
    
    UIScrollView *scrollView;
}

@end

@implementation RTSelectProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    projectName = [[NSArray alloc] initWithObjects:@"心情", @"综合", @"食物", @"跑步", @"慢走", @"力量训练", @"瑜伽", @"骑行", @"篮球", @"足球", @"乒乓球", @"羽毛球",@"网球",@"游泳",@"舞蹈", @"滑轮", @"有氧操", @"排球", @"桌球", nil];
    projectPicName = [[NSArray alloc] initWithObjects:@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", nil];
    
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"项目选择";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 520);
    [self.view addSubview:scrollView];
    
    [self addView];
 
}

- (void)addView
{
    for (int i = 0; i < 19; i++) {
        RTProjectSelectView *viewSelect = [[RTProjectSelectView alloc]init];
        viewSelect.frame = CGRectMake((i%4)*80, 20+95*(i/4), 80, 95);
        viewSelect.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%02d.png",i]];
        NSLog(@"%@",[NSString stringWithFormat:@"sports%02d.png",i]);
        viewSelect.labelName.text = [projectName objectAtIndex:i];
        viewSelect.labelName.font = SMALLFONT_12;
        viewSelect.tag = i;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
        [viewSelect addGestureRecognizer:gesture];
        [scrollView addSubview:viewSelect];
    }
}

- (void)clickImage:(UITapGestureRecognizer*)tap
{
    RTProjectSelectView *view = (RTProjectSelectView*)tap.view;
    self.projectSelectedString = [projectPicName objectAtIndex:view.tag];
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate clickProjectView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
