//
//  RTCreatePlanSecondStrpViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/5.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTCreatePlanSecondStrpViewController.h"
#import "RTCreatePlanThirdStepViewController.h"

@interface RTCreatePlanSecondStrpViewController ()<UITableViewDataSource,UITableViewDelegate>{
    HealthPlan *healthPlan;
    UITableView *secondtableview;
}

@end

@implementation RTCreatePlanSecondStrpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RTUserInfo *userData = [RTUserInfo getInstance];
    healthPlan = userData.newplan;
    
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
    stepimageview.image = [UIImage imageNamed:@"second.png"];
    [self.view addSubview:stepimageview];
    
    UILabel *stepLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44+NAVIGATIONBAR_HEIGHT, 300, 36)];
    stepLabel.text = @"2.周期和循环";
    stepLabel.font = VERDANA_FONT_16;
    stepLabel.textColor = [UIColor colorWithRed:8/255.0 green:204/255.0 blue:221/255.0 alpha:1.0];
    [self.view addSubview:stepLabel];
    
    secondtableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 80+NAVIGATIONBAR_HEIGHT, 300, 44*2)];
    secondtableview.delegate = self;
    secondtableview.dataSource = self;
    secondtableview.layer.cornerRadius = 5;
    secondtableview.layer.borderColor = LINE_COLOR.CGColor;
    secondtableview.layer.borderWidth = 1;
    secondtableview.layer.masksToBounds = YES;
    secondtableview.bounces = NO;
    [self.view addSubview:secondtableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextStep:(UIButton*)btn{
    
    if ([RTUtil isEmpty:healthPlan.plancycleday]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加计划" message:@"任务周期不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([RTUtil isEmpty:healthPlan.plancyclenumber]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加计划" message:@"循环轮数不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (healthPlan.plancycleday == nil||healthPlan.plancycleday.intValue>7 || healthPlan.plancycleday.intValue <=0){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"任务周期必须小于七天且大于等于一天" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (healthPlan.plancycleday == nil ||healthPlan.plancyclenumber.intValue <=0||healthPlan.plancyclenumber.intValue >=31){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"循环次数必须大于等于一次且小于31次" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    RTCreatePlanThirdStepViewController *third = [[RTCreatePlanThirdStepViewController alloc]init];
    [self.navigationController pushViewController:third animated:YES];
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
#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.font = VERDANA_FONT_12;
    if (indexPath.row == 0){
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"任务周期";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 170, 44)];
        label.font = VERDANA_FONT_11;
        label.textColor = [UIColor grayColor];
        label.text = @"(不超过7天)";
        [cell.contentView addSubview:label];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(250, 0, 60, 44)];
        label1.font = VERDANA_FONT_11;
        label1.textColor = [UIColor grayColor];
        label1.text = [NSString stringWithFormat:@"%@",healthPlan.plancycleday];
        [cell.contentView addSubview:label1];
    }
    else if (indexPath.row == 1){
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"循环次数";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(250, 0, 60, 44)];
        label.font = VERDANA_FONT_11;
        label.textColor = [UIColor grayColor];
        label.text = [NSString stringWithFormat:@"%@",healthPlan.plancyclenumber];
        [cell.contentView addSubview:label];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = indexPath.row;
        UITextField *textfield = [alert textFieldAtIndex:0];
        textfield.placeholder = @"请输入";
        textfield.keyboardType = UIKeyboardTypePhonePad;
        [alert show];
    }
    else if (indexPath.row == 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = indexPath.row;
        UITextField *textfield = [alert textFieldAtIndex:0];
        textfield.keyboardType = UIKeyboardTypePhonePad;
        textfield.placeholder = @"请输入";
        [alert show];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlerView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        switch (alertView.tag) {
            case 0:{
                UITextField *textfield = [alertView textFieldAtIndex:0];
                if ([textfield.text integerValue]>7||[textfield.text integerValue]<=0) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"任务周期必须小于七天且大于等于一天" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                    return;
                }
                healthPlan.plancycleday = [NSNumber numberWithInteger:[textfield.text integerValue]];
                [secondtableview reloadData];
            }break;
            case 1:{
                UITextField *textfield = [alertView textFieldAtIndex:0];
                if ([textfield.text integerValue]<=0 ||healthPlan.plancyclenumber.intValue >=31) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"循环次数必须大于等于一次" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                    return;
                }
                healthPlan.plancyclenumber = [NSNumber numberWithInteger:[textfield.text integerValue]];
                [secondtableview reloadData];
            }break;
            default:
                break;
        }
    }else{
        
    }
}
@end
