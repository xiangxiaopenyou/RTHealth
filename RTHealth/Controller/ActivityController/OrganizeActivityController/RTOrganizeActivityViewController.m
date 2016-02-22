//
//  RTOrganizeActivityViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/6.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTOrganizeActivityViewController.h"
#import "RMDateSelectionViewController.h"
#import "RTWriteActivityIntroViewController.h"
#import "RTActivtyRequest.h"
#import "RTActivityPositionViewController.h"

@interface RTOrganizeActivityViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, RMDateSelectionViewControllerDelegate, RTWriteActivityIntroViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate, RTActivityPositionDelegate>
{
    CLLocationManager *locationManager;
    MKMapView *_mapView;
    UITableView *tableView;
    NSArray *titleContentArray;
    NSArray *titleInfoArray;
    NSMutableArray *contentArray1;
    NSMutableArray *contentArray2;
    UIButton *submitButton;
    float latitude;
    float longitude;
    NSString *address;
    CLLocation *location;
    
    RTWriteActivityIntroViewController *writeIntroView;
    RTActivityPositionViewController *positionView;
    
    RMDateSelectionViewController *dateSelectionVC;
    RMDateSelectionViewController *dateSelectionVC1;
    RMDateSelectionViewController *dateSelectionVC2;
    
    UserInfo *userinfo;
}

@end

@implementation RTOrganizeActivityViewController
@synthesize activityTitleLabel, introLabel, startTimeLabel, endTimeLabel, placeLabel, limitedMemberLabel, phoneNumberLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
    
    titleContentArray = [NSArray arrayWithObjects:@"活动名称", @"活动简介", nil];
    titleInfoArray = [NSArray arrayWithObjects:@"开始时间", @"结束时间", @"活动地点", @"报名人数限制(可选)", @"联系电话", nil];
    contentArray1 = [NSMutableArray arrayWithObjects:@"", @"", nil];
    contentArray2 = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"",  @"", nil];
    
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
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    //tableview
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.sectionIndexColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    
    //发起活动提交按钮
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(SCREEN_WIDTH - 40, 22, 40, 40);
    [submitButton setTitle:@"发起" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitClick
{
    NSLog(@"点击了立即发起按钮");
    if ([RTUtil isEmpty:activityTitleLabel.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先输入活动名称哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        if ([RTUtil isEmpty:introLabel.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先写点活动简介哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            if ([RTUtil isEmpty:startTimeLabel.text]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先确定活动开始时间哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            else{
                NSDate *now = [NSDate date];
                NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
                [dateF setDateFormat:@"yyyy-MM-dd HH:mm"];
                NSString *nowString = [dateF stringFromDate:now];
                if ([[CustomDate compare:startTimeLabel.text otherString:nowString] isEqualToString:@"earlier"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"开始时间已经过了吧~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else{
                    if([RTUtil isEmpty:endTimeLabel.text]){
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先确定活动结束时间哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    else{
                        if (![[CustomDate compare:endTimeLabel.text otherString:startTimeLabel.text] isEqualToString:@"later"]) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"结束有点早吧~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                        
                        
                        else{
                            if ([RTUtil isEmpty:placeLabel.text]) {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先选择活动地点哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [alert show];
                            }
                            else{
                                
                                if ([RTUtil isValidateMobile:phoneNumberLabel.text]) {
                                    if (![JDStatusBarNotification isVisible]) {
                                        [JDStatusBarNotification showWithStatus:@"正在创建活动..."];
                                    }
                                    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
                                    
                                    RTUserInfo *userData = [RTUserInfo getInstance];
                                    userinfo = userData.userData;
                                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                                    [dic setObject:userinfo.userid forKey:@"userid"];
                                    [dic setObject:userinfo.usertoken forKey:@"usertoken"];
                                    [dic setObject:activityTitleLabel.text forKey:@"activitycontent"];
                                    [dic setObject:introLabel.text forKey:@"activityintrduce"];
                                    [dic setObject:startTimeLabel.text forKey:@"activitystarttime"];
                                    [dic setObject:endTimeLabel.text forKey:@"activityendtime"];
//                                    if (![RTUtil isEmpty:deadlineLabel.text]) {
//                                        [dic setObject:deadlineLabel.text forKey:@"activitystoptaketime"];
//                                    }
                                    [dic setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"positionX"];
                                    [dic setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"positionY"];
                                    [dic setObject:placeLabel.text forKey:@"activityplace"];
                                    if (![RTUtil isEmpty:limitedMemberLabel.text]) {
                                        [dic setObject:limitedMemberLabel.text forKey:@"activitytakenumberlim"];
                                    }
                                    [dic setObject:phoneNumberLabel.text forKey:@"activitytelephone"];
                                    [RTActivtyRequest createActivityWith:dic success:^(id response) {
                                        if ([[response objectForKey:@"state"] integerValue] == 1000) {
                                            NSLog(@"创建成功");
                                            [JDStatusBarNotification showWithStatus:@"创建成功√" dismissAfter:1.4];
                                            //[self viewDidLoad];
                                            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                                            [[NSNotificationCenter defaultCenter] postNotificationName:CREATEACTIVITYSUCCESS object:@YES];
                                        }
                                        else{
                                            NSLog(@"创建失败");
                                            [JDStatusBarNotification showWithStatus:@"创建失败" dismissAfter:1.4];
                                        }
                                    } failure:^(NSError *error) {
                                        NSLog(@"失败信息");
                                        [JDStatusBarNotification showWithStatus:@"创建失败" dismissAfter:1.4];
                                    }];
                                    
                                }
                                else{
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                            }
                        }
                    }
                    
                }
            }
            
        }
    }
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
        return 5;
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
                    activityTitleLabel.text = [contentArray1 objectAtIndex:indexPath.row];
                    [cell.contentView addSubview:activityTitleLabel];
                }
                    break;
                    
                case 1:{
                    introLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 180, cell.frame.size.height- 5)];
                    introLabel.font = VERDANA_FONT_12;
                    introLabel.textAlignment = NSTextAlignmentLeft;
                    introLabel.text = [contentArray1 objectAtIndex:indexPath.row];
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
                    startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, 130, cell.frame.size.height - 5)];
                    startTimeLabel.font = VERDANA_FONT_12;
                    startTimeLabel.text = [contentArray2 objectAtIndex:indexPath.row];
                    startTimeLabel.textAlignment = NSTextAlignmentLeft;
                    [cell.contentView addSubview:startTimeLabel];
                }
                    
                    break;
                    
                case 1:{
                    endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, 130, cell.frame.size.height - 5)];
                    endTimeLabel.font = VERDANA_FONT_12;
                    endTimeLabel.text = [contentArray2 objectAtIndex:indexPath.row];
                    endTimeLabel.textAlignment = NSTextAlignmentLeft;
                    [cell.contentView addSubview:endTimeLabel];
                }
                    break;
                    
                case 2:{
                    placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 130, cell.frame.size.height)];
                    placeLabel.font = VERDANA_FONT_12;
                    placeLabel.text = [contentArray2 objectAtIndex:indexPath.row];
                    //placeLabel.text = @"浙江工商";
                    placeLabel.textAlignment = NSTextAlignmentLeft;
                    placeLabel.lineBreakMode = NSLineBreakByCharWrapping;
                    placeLabel.numberOfLines= 2;
                    [cell.contentView addSubview:placeLabel];
                }
                    break;
                    
                case 3:{
                    limitedMemberLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, 130, cell.frame.size.height - 5)];
                    limitedMemberLabel.font = VERDANA_FONT_12;
                    limitedMemberLabel.text = [contentArray2 objectAtIndex:indexPath.row];
                    limitedMemberLabel.textAlignment = NSTextAlignmentLeft;
                    [cell.contentView addSubview:limitedMemberLabel];
                }
                    break;
                    
                case 4:{
                    phoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, 130, cell.frame.size.height - 5)];
                    phoneNumberLabel.font = VERDANA_FONT_12;
                    phoneNumberLabel.text = [contentArray2 objectAtIndex:indexPath.row];
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
    //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    sectionLabel.font = VERDANA_FONT_14;
    sectionLabel.textColor = [UIColor colorWithRed:86/255.0 green:195/255.0 blue:226/255.0 alpha:1.0];
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

- (void)tableView:(UITableView *)TableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [TableView deselectRowAtIndexPath:indexPath animated:NO];
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
            writeIntroView = [[RTWriteActivityIntroViewController alloc] init];
            writeIntroView.delegate = self;
            if (![RTUtil isEmpty:introLabel.text]) {
                writeIntroView.introString = introLabel.text;
            }
            [self.navigationController pushViewController:writeIntroView animated:YES];
        }
    }
    else{
        if (indexPath.row == 0) {
            [self startDatePicker];
        }
        else if (indexPath.row == 1){
            [self endDatePicker];
        }
        else if (indexPath.row == 2){
            RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
            positionView = [[RTActivityPositionViewController alloc] init];
            positionView.delegate = self;
            [appDelegate.rootNavigationController pushViewController:positionView animated:YES];
        }
        else if (indexPath.row == 3){
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

#pragma mark - RTActivityPositionDelegate
- (void) clickChooseButton
{
    address = positionView.addressString;
    latitude = positionView.positionX;
    longitude = positionView.positionY;
    self.placeLabel.text = address;
}

#pragma mark - RTWriteActivityIntroView Delegate
- (void)clickFinishButton
{
    contentArray1[1] = writeIntroView.introString;
    introLabel.text = writeIntroView.introString;
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        switch (alertView.tag) {
            case 00:{
                contentArray1[0] = textField.text;
                activityTitleLabel.text = textField.text;
            
            }
                break;
            case 13:{
                contentArray2[3] = textField.text;
                placeLabel.text = textField.text;
            }
                break;
            case 14:{
                contentArray2[4] = textField.text;
                limitedMemberLabel.text = textField.text;
            }
                break;
            case 15:{
                contentArray2[5] = textField.text;
                phoneNumberLabel.text = textField.text;
            }
                break;
            default:
                break;
        }
    }
}

//时间选择器
- (void)startDatePicker
{
    [RMDateSelectionViewController setLocalizedTitleForCancelButton:@"取消"];
    [RMDateSelectionViewController setLocalizedTitleForSelectButton:@"确定"];
    [RMDateSelectionViewController setLocalizedTitleForNowButton:@"现在"];
    dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    dateSelectionVC.titleLabel.text = @"";
    dateSelectionVC.hideNowButton = YES;
    
    
    //You can enable or disable blur, bouncing and motion effects
    dateSelectionVC.disableBouncingWhenShowing = NO;
    dateSelectionVC.disableMotionEffects = NO;
    dateSelectionVC.disableBlurEffects = YES;
    
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    dateSelectionVC.datePicker.minuteInterval = 5;
    dateSelectionVC.datePicker.date = [NSDate date];
    
    
    //The example project is universal. So we first need to check whether we run on an iPhone or an iPad.
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [dateSelectionVC show];
    } else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [dateSelectionVC showFromRect:self.view.frame inView:self.view];
    }
    
}
- (void)endDatePicker
{
    [RMDateSelectionViewController setLocalizedTitleForCancelButton:@"取消"];
    [RMDateSelectionViewController setLocalizedTitleForSelectButton:@"确定"];
    [RMDateSelectionViewController setLocalizedTitleForNowButton:@"现在"];
    dateSelectionVC1 = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC1.delegate = self;
    dateSelectionVC1.titleLabel.text = @"";
    dateSelectionVC1.hideNowButton = YES;
    
    
    //You can enable or disable blur, bouncing and motion effects
    dateSelectionVC1.disableBouncingWhenShowing = NO;
    dateSelectionVC1.disableMotionEffects = NO;
    dateSelectionVC1.disableBlurEffects = YES;
    
    dateSelectionVC1.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    dateSelectionVC1.datePicker.minuteInterval = 5;
    dateSelectionVC1.datePicker.date = [NSDate date];
    
    
    //The example project is universal. So we first need to check whether we run on an iPhone or an iPad.
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [dateSelectionVC1 show];
    } else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [dateSelectionVC1 showFromRect:self.view.frame inView:self.view];
    }
    
}

#pragma mark - RMDateSelection delegate
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:aDate];
    if (vc == dateSelectionVC) {
        contentArray2[0] = dateString;
        startTimeLabel.text = dateString;
    }
    else{
        contentArray2[1] = dateString;
        endTimeLabel.text = dateString;
    }
}
- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc
{
    
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
