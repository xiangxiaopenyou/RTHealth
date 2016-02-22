//
//  RTGuessLikeViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/12.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTGuessLikeViewController.h"
#import "RTTrendsTableViewCell.h"

@interface RTGuessLikeViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView *guessLikeTableView;
}

@end

@implementation RTGuessLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"猜你喜欢";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    guessLikeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
    guessLikeTableView.delegate = self;
    guessLikeTableView.dataSource = self;
    guessLikeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    guessLikeTableView.sectionIndexColor = [UIColor clearColor];
    guessLikeTableView.backgroundView = nil;
    guessLikeTableView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    guessLikeTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:guessLikeTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellidentifier = @"Cell";
    
    RTTrendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidentifier];
    
    if (cell == nil) {
        cell = [[RTTrendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 348;
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
