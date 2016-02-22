//
//  RTOrganizeActivityViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/6.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTOrganizeActivityViewController.h"

@interface RTOrganizeActivityViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UITableView *tableView;
    NSArray *titleContentArray;
    NSArray *titleInfoArray;
    UIButton *submitButton;
    
    
}

@end

@implementation RTOrganizeActivityViewController
@synthesize activityTitleLabel, introLabel, startTimeLabel, endTimeLabel, deadlineLabel, placeLabel, limitedMemberLabel, phoneNumberLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
    titleContentArray = [NSArray arrayWithObjects:@"活动名称", @"活动简介", nil];
    titleInfoArray = [NSArray arrayWithObjects:@"开始时间", @"结束时间", @"报名截止时间(可选)", @"活动地点", @"报名人数限制(可选)", @"联系电话", nil];
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"发起活动";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    //tableview
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - 50) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.sectionIndexColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    
    //发起活动提交按钮
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake((SCREEN_WIDTH - 100)/2, SCREEN_HEIGHT - 40, 100, 30);
    submitButton.backgroundColor = [UIColor greenColor];
    [submitButton setTitle:@"立即发起" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    submitButton.layer.masksToBounds = YES;
    submitButton.layer.cornerRadius = 3;
    [self.view addSubview:submitButton];
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitClick
{
    NSLog(@"点击了立即发起按钮");
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else{
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = VERDANA_FONT_14;
    if (indexPath.section == 0) {
        cell.textLabel.text = [titleContentArray objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = [titleInfoArray objectAtIndex:indexPath.row];
    }
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    activityTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 180, cell.frame.size.height - 5)];
                    activityTitleLabel.font = VERDANA_FONT_12;
                    activityTitleLabel.textAlignment = NSTextAlignmentLeft;
                    activityTitleLabel.text = @"相邻苹果i水电费";
                    [cell.contentView addSubview:activityTitleLabel];
                }
                    break;
                    
                case 1:{
                    introLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 180, cell.frame.size.height- 5)];
                    introLabel.font = VERDANA_FONT_12;
                    introLabel.textAlignment = NSTextAlignmentLeft;
                    introLabel.text = @"运动啊啦SD卡附近的撒阿萨德路附近阿斯达克路附近的顺口溜";
                    [cell.contentView addSubview:introLabel];
                }
                    break;
                    
                default:
                    break;
            }
            break;
        }
            
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 5, 110, cell.frame.size.height - 5)];
                    startTimeLabel.font = VERDANA_FONT_12;
                    startTimeLabel.textAlignment = NSTextAlignmentLeft;
                    [cell.contentView addSubview:startTimeLabel];
                }
                    
                    break;
                    
                case 1:{
                    endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 5, 110, cell.frame.size.height - 5)];
                    endTimeLabel.font = VERDANA_FONT_12;
                    endTimeLabel.textAlignment = NSTextAlignmentLeft;
                    [cell.contentView addSubview:endTimeLabel];
                }
                    break;
                    
                case 2:{
                    deadlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 5, 110, cell.frame.size.height-5)];
                    deadlineLabel.font = VERDANA_FONT_12;
                    deadlineLabel.textAlignment = NSTextAlignmentLeft;
                    [cell.contentView addSubview:deadlineLabel];
                }
                    break;
                    
                case 3:{
                    placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 5, 110, cell.frame.size.height - 5)];
                    placeLabel.font = VERDANA_FONT_12;
                    placeLabel.textAlignment = NSTextAlignmentLeft;
                    [cell.contentView addSubview:placeLabel];
                }
                    break;
                    
                case 4:{
                    limitedMemberLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 5, 110, cell.frame.size.height - 5)];
                    limitedMemberLabel.font = VERDANA_FONT_12;
                    limitedMemberLabel.textAlignment = NSTextAlignmentLeft;
                    [cell.contentView addSubview:limitedMemberLabel];
                }
                    break;
                    
                case 5:{
                    phoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 5, 110, cell.frame.size.height - 5)];
                    phoneNumberLabel.font = VERDANA_FONT_12;
                    phoneNumberLabel.textAlignment = NSTextAlignmentLeft;
                    [cell.contentView addSubview:phoneNumberLabel];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            
        default:
            break;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    sectionLabel.font = VERDANA_FONT_14;
    sectionLabel.textColor = [UIColor greenColor];
    if (section == 0) {
        sectionLabel.text = @"1.活动内容";
        [header addSubview:sectionLabel];
    }
    else{
        sectionLabel.text = @"2.活动信息";
        [header addSubview:sectionLabel];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            UIAlertView *titleAlert = [[UIAlertView alloc] initWithTitle:@"输入活动名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            titleAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            titleAlert.tag = 00;
            UITextField *titleTextField = [titleAlert textFieldAtIndex:0];
            titleTextField.text = activityTitleLabel.text;
            [titleAlert show];
        }
        else{
            
        }
    }
    else{
        if (indexPath.row == 0) {
            
        }
        else if (indexPath.row == 1){
        }
        else if (indexPath.row == 2){
        }
        else if (indexPath.row == 3){
            UIAlertView *placeAlert = [[UIAlertView alloc] initWithTitle:@"输入活动地点" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            placeAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            placeAlert.tag = 13;
            UITextField *textField = [placeAlert textFieldAtIndex:0];
            textField.text = placeLabel.text;
            [placeAlert show];
        }
        else if (indexPath.row == 4){
            UIAlertView *limitedMemberAlert = [[UIAlertView alloc] initWithTitle:@"输入报名限制人数" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            limitedMemberAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            limitedMemberAlert.tag = 14;
            UITextField *textField = [limitedMemberAlert textFieldAtIndex:0];
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.text = limitedMemberLabel.text;
            [limitedMemberAlert show];
        }
        else{
            UIAlertView *phoneNumberAlert = [[UIAlertView alloc] initWithTitle:@"输入手机号码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            phoneNumberAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            phoneNumberAlert.tag = 15;
            UITextField *textField = [phoneNumberAlert textFieldAtIndex:0];
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.text = phoneNumberLabel.text;
            [phoneNumberAlert show];
        }
    }
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        switch (alertView.tag) {
            case 00:{
                activityTitleLabel.text = textField.text;
            }
                break;
            case 13:{
                placeLabel.text = textField.text;
            }
                break;
            case 14:{
                limitedMemberLabel.text = textField.text;
            }
                break;
            case 15:{
                phoneNumberLabel.text = textField.text;
            }
                break;
            default:
                break;
        }
    }
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
