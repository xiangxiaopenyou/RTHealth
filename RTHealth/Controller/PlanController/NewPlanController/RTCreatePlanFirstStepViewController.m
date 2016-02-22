//
//  RTCreatePlanFirstStepViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/5.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTCreatePlanFirstStepViewController.h"
#import "RTCreatePlanSecondStrpViewController.h"
#import "RTWirteIntrduceViewController.h"
#import "RTPlanKindViewController.h"

@interface RTCreatePlanFirstStepViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *imageview;
    HealthPlan *healthPlan;
    NSArray *arrayTitle;
}

@end

@implementation RTCreatePlanFirstStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    RTUserInfo *userData = [RTUserInfo getInstance];
    userData.newplan = [HealthPlan MR_createEntity];
    healthPlan = userData.newplan;
    healthPlan.planpublic = @"1";
    healthPlan.plantype = @"00";
    
    arrayTitle = [[NSArray alloc]initWithObjects:@"美腿瘦身",@"肌肉训练",@"柔韧训练",@"瑜伽",@"耐力训练",@"爆发力",@"其它", nil];
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"制定计划";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(260, 26, 50, 32);
    btn.titleLabel.font = VERDANA_FONT_14;
    [btn setBackgroundImage:[UIImage imageNamed:@"nextstep.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView *stepimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 44)];
    stepimageview.image = [UIImage imageNamed:@"first.png"];
    [self.view addSubview:stepimageview];
    
    UILabel *stepLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44+NAVIGATIONBAR_HEIGHT, 300, 36)];
    stepLabel.text = @"1.基本信息";
    stepLabel.font = VERDANA_FONT_16;
    stepLabel.textColor = [UIColor colorWithRed:8/255.0 green:204/255.0 blue:221/255.0 alpha:1.0];
    [self.view addSubview:stepLabel];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 80+NAVIGATIONBAR_HEIGHT, 300, 44*4)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.layer.cornerRadius = 5;
    tableview.layer.borderColor = LINE_COLOR.CGColor;
    tableview.layer.borderWidth = 1;
    tableview.layer.masksToBounds = YES;
    tableview.bounces = NO;
    [self.view addSubview:tableview];
    
    imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"planpublic.png"];
}

- (void)nextStep:(UIButton*)btn{
    
    if ([RTUtil isEmpty:healthPlan.plantype]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加计划" message:@"计划类型不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }if ([RTUtil isEmpty:healthPlan.plantitle]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加计划" message:@"计划名称不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }if ([RTUtil isEmpty:healthPlan.plancontent]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加计划" message:@"计划介绍不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    RTCreatePlanSecondStrpViewController *second = [[RTCreatePlanSecondStrpViewController alloc]init];
    [self.navigationController pushViewController:second animated:YES];
}
- (void)backClick
{
    [healthPlan MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.font = VERDANA_FONT_12;
    if (indexPath.row == 3) {
        cell.textLabel.text = @"是否公开";
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 200, 44)];
        label.font = VERDANA_FONT_11;
        label.textColor = [UIColor grayColor];
        label.text = @"公开后计划能被别人检索到";
        [cell.contentView addSubview:label];
        
        imageview.frame = CGRectMake(260, 7, 30, 30);
        if ([healthPlan.planpublic integerValue]==1) {
            imageview.image = [UIImage imageNamed:@"planpublic.png"];
        }else{
            imageview.image = [UIImage imageNamed:@"plannotpublic.png"];
        }
        [cell.contentView addSubview:imageview];
        
    }else if (indexPath.row == 1){
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"计划名称";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 200, 44)];
        label.font = VERDANA_FONT_11;
        label.textColor = [UIColor grayColor];
        label.text = healthPlan.plantitle;
        [cell.contentView addSubview:label];
    }
    else if (indexPath.row == 0){
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"计划分类";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 200, 44)];
        label.font = VERDANA_FONT_11;
        label.textColor = [UIColor grayColor];
        label.text = [arrayTitle objectAtIndex:[healthPlan.plantype intValue]];
        [cell.contentView addSubview:label];
    }else if (indexPath.row == 2){
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"计划介绍";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 200, 44)];
        label.font = VERDANA_FONT_11;
        label.textColor = [UIColor grayColor];
        label.text = healthPlan.plancontent;
        [cell.contentView addSubview:label];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 3) {
        if ([healthPlan.planpublic integerValue]==1) {
            healthPlan.planpublic = @"0";
        }else{
            healthPlan.planpublic = @"1";
        }
        [tableview reloadData];
    }else if (indexPath.row == 1){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = indexPath.row;
        UITextField *textfield = [alert textFieldAtIndex:0];
        textfield.placeholder = @"请输入";
        [alert show];
    }
    else if (indexPath.row == 0){
        RTPlanKindViewController *kindPicker = [[RTPlanKindViewController alloc]init];
        [kindPicker returnArray:^(NSString *string){
            if (![RTUtil isEmpty:string]) {
                healthPlan.plantype = string;
            }
            [tableView reloadData];
        }];
        [self.navigationController pushViewController:kindPicker animated:YES];
    }
    else if (indexPath.row == 2){
        RTWirteIntrduceViewController *writeIntrduceController = [[RTWirteIntrduceViewController alloc]init];
        writeIntrduceController.content = healthPlan.plancontent;
        [writeIntrduceController returnText:^(NSString *showText) {
            healthPlan.plancontent = showText;
            [tableview reloadData];
        }];
        [self.navigationController pushViewController:writeIntrduceController animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlerView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        healthPlan.plantitle = textfield.text;
        [tableview reloadData];
    }else{
        
    }
}
@end
