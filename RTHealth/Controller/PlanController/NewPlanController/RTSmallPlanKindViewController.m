//
//  RTSmallPlanKindViewController.m
//  RTHealth
//
//  Created by cheng on 14/12/8.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTSmallPlanKindViewController.h"
#import "RTProjectSelectView.h"

@interface RTSmallPlanKindViewController (){
    NSArray *projectName;
}

@end

@implementation RTSmallPlanKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    projectName = sports;
    
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
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    [self addView];
    
}

- (void)addView
{
    for (int i = 3; i < projectName.count; i++) {
        RTProjectSelectView *viewSelect = [[RTProjectSelectView alloc]init];
        viewSelect.frame = CGRectMake(((i-3)%4)*80, 20+NAVIGATIONBAR_HEIGHT+95*((i-3)/4), 80, 95);
        viewSelect.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%02d.png",i]];
        NSLog(@"%@",[NSString stringWithFormat:@"sports%02d.png",i]);
        viewSelect.labelName.text = [projectName objectAtIndex:i];
        viewSelect.tag = i;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
        [viewSelect addGestureRecognizer:gesture];
        [self.view addSubview:viewSelect];
    }
}

- (void)clickImage:(UITapGestureRecognizer*)tap
{
    RTProjectSelectView *view = (RTProjectSelectView*)tap.view;
    NSString *string = [NSString stringWithFormat:@"%02ld",(long)view.tag];
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(string);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)returnString:(ReturnStringBlock)block {
    self.returnTextBlock = block;
}
@end
