//
//  RTProjectSelectViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/24.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTProjectSelectViewController.h"
#import "RTProjectSelectView.h"

@interface RTProjectSelectViewController (){
    NSArray *sportsname;
}

@end

@implementation RTProjectSelectViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (!self.selectarray){
        self.selectarray = [[NSMutableArray alloc]init];
    }
    sportsname = sports;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"项目选择";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];

    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setFrame:CGRectMake(SCREEN_WIDTH-75, (44-26)/2+20, 65, 26)];
    [saveBtn setImage:[UIImage imageNamed:@"sure_right.png"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    [self addView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addView{
    for (int i = 3; i < sportsname.count; i++) {
        RTProjectSelectView *viewSelect = [[RTProjectSelectView alloc]init];
        viewSelect.frame = CGRectMake(((i-3)%4)*80, 20+NAVIGATIONBAR_HEIGHT+95*((i-3)/4), 80, 95);
        viewSelect.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%02d.png",i]];
        NSLog(@"%@",[NSString stringWithFormat:@"sports%02d.png",i]);
        viewSelect.labelName.text = [sportsname objectAtIndex:i];
        viewSelect.tag = i;
        if ([self.selectarray containsObject:[NSString stringWithFormat:@"%02d",i]]) {
            viewSelect.selected = YES;
        }
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
        [viewSelect addGestureRecognizer:gesture];
        [self.view addSubview:viewSelect];
    }
}

- (void)clickImage:(UITapGestureRecognizer*)tap{
    RTProjectSelectView *view = (RTProjectSelectView*)tap.view;
    if (view.selected == YES){
        view.selected =NO;
        [self.selectarray removeObject:[NSString stringWithFormat:@"%02ld",(long)view.tag]];
    }else{
        view.selected = YES;
        [self.selectarray addObject:[NSString stringWithFormat:@"%02ld",(long)view.tag]];
    }
    [view setNeedsDisplay];
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)returnArray:(ReturnArrayBlock)block {
    self.returnTextBlock = block;
}
- (void)saveClick{
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(self.selectarray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated {
}
@end
