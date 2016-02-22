//
//  RTPlanKindViewController.m
//  RTHealth
//
//  Created by cheng on 14/12/8.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPlanKindViewController.h"
#import "RTPlanKindTableViewCell.h"

@interface RTPlanKindViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *arrayTitle;
}

@end

@implementation RTPlanKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    titleLabel.text = @"计划类别";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];

    
    arrayTitle = [[NSArray alloc]initWithObjects:@"美腿瘦身",@"肌肉训练",@"柔韧训练",@"瑜伽",@"耐力训练",@"爆发力",@"其它", nil];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, 320, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"Cell";
    RTPlanKindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil ) {
        cell = [[RTPlanKindTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.kindImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"exercise%02ld.png",(long)indexPath.row]];
    cell.nameLabel.text = [arrayTitle objectAtIndex:indexPath.row];
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayTitle.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click %@",indexPath);
    NSString *string = [NSString stringWithFormat:@"%02ld",(long)indexPath.row];
    
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(string);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)returnArray:(ReturnArrayBlock)block {
    self.returnTextBlock = block;
}

@end
