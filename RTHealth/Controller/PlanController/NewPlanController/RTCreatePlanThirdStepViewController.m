//
//  RTCreatePlanThirdStepViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/5.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTCreatePlanThirdStepViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "RMDateSelectionViewController.h"
#import "RTPlanRequest.h"
#import "RTSmallPlanKindViewController.h"
#import "RTWirteIntrduceViewController.h"

#define  CELL_HEIGHT 39
#define ADDLABEL_TEXTCOLOR [UIColor grayColor]
#define ADDLABEL_HEIGHT 20
#define CELL_BACKGROUNDCOLOR [UIColor colorWithRed:152.0f/255.0 green:152.0f/255.0 blue:152.0f/255.0 alpha:1]

@interface RTCreatePlanThirdStepViewController ()<UITableViewDataSource,UITableViewDelegate,RMDateSelectionViewControllerDelegate>{
    HealthPlan *healthPlan;
    UITableView *thirdTableView;
    NSInteger currentDay;
    NSMutableArray *oneDayArray;
    NSMutableArray *twoDayArray;
    NSMutableArray *threeDayArray;
    NSMutableArray *fourDayArray;
    NSMutableArray *fiveDayArray;
    NSMutableArray *sixDayArray;
    NSMutableArray *sevenDayArray;
    NSIndexPath *timeIndexPath;
}

@end

@implementation RTCreatePlanThirdStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RTUserInfo *userData = [RTUserInfo getInstance];
    healthPlan = userData.newplan;
    currentDay = 1;
    NSString *string = @"add";
    oneDayArray = [[NSMutableArray alloc]initWithObjects:string, nil];
    twoDayArray = [[NSMutableArray alloc]initWithObjects:string, nil];
    threeDayArray = [[NSMutableArray alloc]initWithObjects:string, nil];
    fourDayArray = [[NSMutableArray alloc]initWithObjects:string, nil];
    fiveDayArray = [[NSMutableArray alloc]initWithObjects:string, nil];
    sixDayArray = [[NSMutableArray alloc]initWithObjects:string, nil];
    sevenDayArray = [[NSMutableArray alloc]initWithObjects:string, nil];
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
    [btn addTarget:self action:@selector(finishStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView *stepimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 44)];
    stepimageview.image = [UIImage imageNamed:@"third.png"];
    [self.view addSubview:stepimageview];
    
    UILabel *stepLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44+NAVIGATIONBAR_HEIGHT, 300, 36)];
    stepLabel.text = @"3.每日任务定制";
    stepLabel.font = VERDANA_FONT_16;
    stepLabel.textColor = [UIColor colorWithRed:8/255.0 green:204/255.0 blue:221/255.0 alpha:1.0];
    [self.view addSubview:stepLabel];

    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<[healthPlan.plancycleday integerValue]; i++) {
        [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d天",i+1],@"text",nil]];
        
    }
    
    
    PPiFlatSegmentedControl *segmented2=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-40*[healthPlan.plancycleday integerValue])/2, NAVIGATIONBAR_HEIGHT+90, 40*[healthPlan.plancycleday integerValue], 30)
                                                                                 items:array
                                                                          iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                              currentDay = segmentIndex+1;
                                                                              [thirdTableView reloadData];
                                                                              
                                                                          }];
    segmented2.color = [UIColor colorWithRed:152.0f/255.0 green:152.0f/255.0 blue:152.0f/255.0 alpha:1];
    segmented2.borderWidth = 5;
    segmented2.borderColor = [UIColor colorWithRed:152.0f/255.0 green:152.0f/255.0 blue:152.0f/255.0 alpha:1];
    segmented2.selectedColor = [UIColor colorWithRed:255.0f/255.0 green:255.0f/255.0 blue:255.0f/255.0 alpha:1];
    segmented2.textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1.0],NSForegroundColorAttributeName, nil];
    segmented2.selectedTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor colorWithRed:95/255.0 green:95/255.0 blue:95/255.0 alpha:1.0], NSForegroundColorAttributeName,nil];
    [self.view addSubview:segmented2];
    
    
    thirdTableView = [[UITableView alloc]initWithFrame:CGRectMake(10,  NAVIGATIONBAR_HEIGHT+130, 300, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT-130) style:UITableViewStyleGrouped];
    thirdTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    thirdTableView.delegate = self;
    thirdTableView.dataSource = self;
    [self.view addSubview:thirdTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    if ([healthPlan.plancycleday integerValue]== 0) {
        thirdTableView.hidden = YES;
    }else{
        thirdTableView.hidden = NO;
    }
    
    [self initData];
    [self reloadTableViewData];
}

- (void)finishStep:(UIButton*)btn{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self saveData];
    [self uploadServer];
}
- (void)backClick
{
    [self saveData];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initData
{
    if ([healthPlan.plancycleday integerValue]<7) {
        [sevenDayArray removeAllObjects];
        [sevenDayArray addObject:@"add"];
    }if ([healthPlan.plancycleday integerValue]<6) {
        [sixDayArray removeAllObjects];
        [sixDayArray addObject:@"add"];
    }if ([healthPlan.plancycleday integerValue]<5) {
        [fiveDayArray removeAllObjects];
        [fiveDayArray addObject:@"add"];
    }if ([healthPlan.plancycleday integerValue]<4) {
        [fourDayArray removeAllObjects];
        [fourDayArray addObject:@"add"];
    }if ([healthPlan.plancycleday integerValue]<3) {
        [threeDayArray removeAllObjects];
        [threeDayArray addObject:@"add"];
    }if ([healthPlan.plancycleday integerValue]<2) {
        [twoDayArray removeAllObjects];
        [twoDayArray addObject:@"add"];
    }if ([healthPlan.plancycleday integerValue]<1) {
        [oneDayArray removeAllObjects];
        [oneDayArray addObject:@"add"];
    }
    
    for (SmallHealthPlan *smallPlan in healthPlan.smallhealthplan) {
        switch ([smallPlan.smallplansequence integerValue]) {
            case 1:{
                [oneDayArray addObject:smallPlan];
            }break;
            case 2:{
                [twoDayArray addObject:smallPlan];
            }break;
            case 3:{
                [threeDayArray addObject:smallPlan];
            }break;
            case 4:{
                [fourDayArray addObject:smallPlan];
            }break;
            case 5:{
                [fiveDayArray addObject:smallPlan];
            }break;
            case 6:{
                [sixDayArray addObject:smallPlan];
            }break;
            case 7:{
                [sevenDayArray addObject:smallPlan];
            }break;
            default:
                break;

        }
    }
}

- (void)uploadServer{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    if ([RTUtil isEmpty:userinfo.userid] || [RTUtil isEmpty:userinfo.usertoken]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加计划" message:@"登陆失效" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([RTUtil isEmpty:healthPlan.plantype]||[RTUtil isEmpty:healthPlan.plantitle] || [RTUtil isEmpty:healthPlan.plancycleday]|| [RTUtil isEmpty:healthPlan.plancyclenumber]||[RTUtil isEmpty:healthPlan.plancontent]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加计划" message:@"计划内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([RTUtil isEmpty:healthPlan.smallhealthplan]||healthPlan.smallhealthplanSet.count == 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加计划" message:@"没有子计划" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    for (SmallHealthPlan *smallPlan in healthPlan.smallhealthplan) {
        if ([RTUtil isEmpty:smallPlan.smallplanbegintime]||[RTUtil isEmpty:smallPlan.smallplancontent] || [RTUtil isEmpty:smallPlan.smallplanendtime]||[RTUtil isEmpty:smallPlan.smallplantype]||[RTUtil isEmpty:smallPlan.smallplansequence]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加计划" message:@"子计划内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }
    }
    
    if (![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:@"正在发送..."];
    }
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
    [RTPlanRequest addPlanWith:nil Plan:healthPlan success:^(id response){
    
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [JDStatusBarNotification showWithStatus:@"开始计划成功"];
//            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }else{
            [JDStatusBarNotification showWithStatus:@"开始计划失败"];
        }
        
        [JDStatusBarNotification dismiss];
    } failure:^(NSError *error){
        [JDStatusBarNotification showWithStatus:@"开始计划失败"];
        [JDStatusBarNotification dismiss];
    }];
}


- (void)saveData
{
    NSMutableSet *setArray = [[NSMutableSet alloc]init];
    for(int i = 1 ;i < oneDayArray.count ; i++){
        [setArray addObject:[oneDayArray objectAtIndex:i]];
    }
    for(int i = 1 ;i < twoDayArray.count ; i++){
        [setArray addObject:[twoDayArray objectAtIndex:i]];
    }
    for(int i = 1 ;i < fourDayArray.count ; i++){
        [setArray addObject:[fourDayArray objectAtIndex:i]];
    }
    for(int i = 1 ;i < fiveDayArray.count ; i++){
        [setArray addObject:[fiveDayArray objectAtIndex:i]];
    }
    for(int i = 1 ;i < sixDayArray.count ; i++){
        [setArray addObject:[sixDayArray objectAtIndex:i]];
    }
    for(int i = 1 ;i < threeDayArray.count ; i++){
        [setArray addObject:[threeDayArray objectAtIndex:i]];
    }
    for(int i = 1 ;i < sevenDayArray.count ; i++){
        [setArray addObject:[sevenDayArray objectAtIndex:i]];
    }
    healthPlan.smallhealthplan = setArray;
}
- (void)datePicker:(NSInteger)index
{
    [RMDateSelectionViewController setLocalizedTitleForCancelButton:@"取消"];
    [RMDateSelectionViewController setLocalizedTitleForSelectButton:@"确定"];
    [RMDateSelectionViewController setLocalizedTitleForNowButton:@"现在"];
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    dateSelectionVC.titleLabel.text = @"";
    dateSelectionVC.hideNowButton = YES;
    
    //You can enable or disable blur, bouncing and motion effects
    dateSelectionVC.disableBouncingWhenShowing = NO;
    dateSelectionVC.disableMotionEffects = NO;
    dateSelectionVC.disableBlurEffects = YES;
    
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    dateSelectionVC.datePicker.minuteInterval = 1;
    
    
    //The example project is universal. So we first need to check whether we run on an iPhone or an iPad.
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [dateSelectionVC show];
    } else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [dateSelectionVC showFromRect:self.view.frame inView:self.view];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView Dlegate DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor clearColor];
        cell.layer.borderWidth = 0.5;
        cell.layer.borderColor = ADDLABEL_TEXTCOLOR.CGColor;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, ADDLABEL_HEIGHT)];
        label.text = @"添加新项目";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = VERDANA_FONT_12;
        label.textColor = ADDLABEL_TEXTCOLOR;
        [cell.contentView addSubview:label];
        
    }else{
        SmallHealthPlan *smallPlan;
        switch (currentDay) {
            case 1:
                smallPlan = [oneDayArray objectAtIndex:indexPath.section];
                break;
                
            case 2:
                smallPlan = [twoDayArray objectAtIndex:indexPath.section];
                break;
                
            case 3:
                smallPlan = [threeDayArray objectAtIndex:indexPath.section];
                break;
                
            case 4:
                smallPlan = [fourDayArray objectAtIndex:indexPath.section];
                break;
                
            case 5:
                smallPlan = [fiveDayArray objectAtIndex:indexPath.section];
                break;
                
            case 6:
                smallPlan = [sixDayArray objectAtIndex:indexPath.section];
                break;
                
            case 7:
                smallPlan = [sevenDayArray objectAtIndex:indexPath.section];
                break;
                
            default:
                break;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CELL_HEIGHT)];
        label.font = VERDANA_FONT_12;
        label.textColor = CELL_BACKGROUNDCOLOR;
        [cell.contentView addSubview:label];
        
        UILabel *labelContent = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 200, CELL_HEIGHT)];
        labelContent.textAlignment = NSTextAlignmentRight;
        labelContent.font = VERDANA_FONT_12;
        labelContent.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelContent];
        
        switch (indexPath.row) {
            case 0:{
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = CELL_BACKGROUNDCOLOR;
                label.text = @"项目一";
                label.textColor = [UIColor whiteColor];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBackgroundImage:[UIImage imageNamed:@"subsmallplan.png"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(260, 4, 30, 30);
                btn.tag = indexPath.section;
                [btn addTarget:self action:@selector(subSmallPlan:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn];
            }break;
            case 1:{
                label.text = @"运动项目";
                if (![RTUtil isEmpty:smallPlan.smallplantype]) {
                    labelContent.text = [sports objectAtIndex:[smallPlan.smallplantype intValue]];
                }
            }break;
            case 2:{
                label.text = @"开始时间";
                labelContent.text = smallPlan.smallplanbegintime;
            }break;
            case 3:{
                label.text = @"预计结束";
                labelContent.text = smallPlan.smallplanendtime;
            }break;
            case 4:{
                label.text = @"预计耗能";
                labelContent.text = smallPlan.smallplanmark;
            }break;
            case 5:{
                label.text = @"备注";
                labelContent.text = smallPlan.smallplancontent;
            }break;
                
            default:
                break;
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (currentDay) {
        case 1:
            return oneDayArray.count;
            break;
            
        case 2:
            return twoDayArray.count;
            break;
            
        case 3:
            return threeDayArray.count;
            break;
            
        case 4:
            return fourDayArray.count;
            break;
            
        case 5:
            return fiveDayArray.count;
            break;
            
        case 6:
            return sixDayArray.count;
            break;
            
        case 7:
            return sevenDayArray.count;
            break;
            
        default:
            break;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    timeIndexPath = indexPath;
    if(indexPath.section == 0){
        [self addSmallPlan];
        [tableView reloadData];
    }else{
        SmallHealthPlan *smallPlan;
        switch (currentDay) {
            case 1:{
                smallPlan = [oneDayArray objectAtIndex:timeIndexPath.section];
            }break;
                
            case 2:{
                smallPlan = [twoDayArray objectAtIndex:timeIndexPath.section];
            }break;
                
            case 3:{
                smallPlan = [threeDayArray objectAtIndex:timeIndexPath.section];
            }
                break;
                
            case 4:{
                smallPlan = [fourDayArray objectAtIndex:timeIndexPath.section];
            }
                break;
                
            case 5:{
                smallPlan = [fiveDayArray objectAtIndex:timeIndexPath.section];
            }
                break;
                
            case 6:{
                smallPlan = [sixDayArray objectAtIndex:timeIndexPath.section];
            }
                break;
                
            case 7:{
                smallPlan = [sevenDayArray objectAtIndex:timeIndexPath.section];
            }
                break;
                
            default:
                break;
        }

        switch (indexPath.row) {
            case 1:{
                RTSmallPlanKindViewController *smallPlanKindPicker = [[RTSmallPlanKindViewController alloc]init];
                [smallPlanKindPicker returnString:^(NSString *kindString){
                smallPlan.smallplantype = kindString;
                    [tableView reloadData];
                }];
                [self.navigationController pushViewController:smallPlanKindPicker animated:YES];
            }break;
            case 2:{
                [self datePicker:indexPath.section];
            }break;
            case 3:{
                [self datePicker:indexPath.section];
            }break;
            case 4:{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                alert.tag = indexPath.row;
                UITextField *textfield = [alert textFieldAtIndex:0];
                textfield.placeholder = @"请输入";
                textfield.keyboardType = UIKeyboardTypePhonePad;
                [alert show];
            }break;
            case 5:{
                RTWirteIntrduceViewController *writeIntrduceController = [[RTWirteIntrduceViewController alloc]init];
                writeIntrduceController.content = smallPlan.smallplancontent;
                [writeIntrduceController returnText:^(NSString *showText) {
                    smallPlan.smallplancontent = showText;
                    [tableView reloadData];
                }];
                [self.navigationController pushViewController:writeIntrduceController animated:YES];
            }
                break;
            default:
                break;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ADDLABEL_HEIGHT;
    }
    return CELL_HEIGHT;
}

#pragma  mark DataOperation

- (void)addSmallPlan
{
    switch (currentDay) {
        case 1:{
            SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
            smallPlan.smallplansequence = @"1";
            [oneDayArray insertObject:smallPlan atIndex:1];
        }break;
            
        case 2:{
            SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
            smallPlan.smallplansequence = @"2";
            [twoDayArray insertObject:smallPlan atIndex:1];
        }break;
            
        case 3:{
            SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
            smallPlan.smallplansequence = @"3";
            [threeDayArray insertObject:smallPlan atIndex:1];
        }
            break;
            
        case 4:{
            SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
            smallPlan.smallplansequence = @"4";
            [fourDayArray insertObject:smallPlan atIndex:1];
        }
            break;
            
        case 5:{
            SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
            smallPlan.smallplansequence = @"5";
            [fiveDayArray insertObject:smallPlan atIndex:1];
        }
            break;
            
        case 6:{
            SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
            smallPlan.smallplansequence = @"6";
            [sixDayArray insertObject:smallPlan atIndex:1];
        }
            break;
            
        case 7:{
            SmallHealthPlan *smallPlan = [SmallHealthPlan MR_createEntity];
            smallPlan.smallplansequence = @"7";
            [sevenDayArray insertObject:smallPlan atIndex:1];
        }
            break;
            
        default:
            break;
    }

}

- (void)subSmallPlan:(UIButton*)btn
{
    NSInteger index = btn.tag;
    switch (currentDay) {
        case 1:{
            SmallHealthPlan *smallPlan = [oneDayArray objectAtIndex:index];
            [oneDayArray removeObject:smallPlan];
        }break;
            
        case 2:{
            SmallHealthPlan *smallPlan = [twoDayArray objectAtIndex:index];
            [twoDayArray removeObject:smallPlan];
        }break;
            
        case 3:{
            SmallHealthPlan *smallPlan = [threeDayArray objectAtIndex:index];
            [threeDayArray removeObject:smallPlan];
        }
            break;
            
        case 4:{
            SmallHealthPlan *smallPlan = [fourDayArray objectAtIndex:index];
            [fourDayArray removeObject:smallPlan];
        }
            break;
            
        case 5:{
            SmallHealthPlan *smallPlan = [fiveDayArray objectAtIndex:index];
            [fiveDayArray removeObject:smallPlan];
        }
            break;
            
        case 6:{
            SmallHealthPlan *smallPlan = [sixDayArray objectAtIndex:index];
            [sixDayArray removeObject:smallPlan];
        }
            break;
            
        case 7:{
            SmallHealthPlan *smallPlan = [sevenDayArray objectAtIndex:index];
            [sevenDayArray removeObject:smallPlan];
        }
            break;
            
        default:
            break;
    }
    [thirdTableView deleteSections:[[NSIndexSet alloc]initWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
    [self performSelector:@selector(reloadTableViewData) withObject:nil afterDelay:0.5f];
}
- (void)reloadTableViewData{
    
    [thirdTableView reloadData];
}

#pragma mark RMDateSelection delegate

- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    NSLog(@"Successfully selected date: %@", aDate);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *theDate = [dateFormat stringFromDate:aDate];
    
    SmallHealthPlan *smallPlan;
    switch (currentDay) {
        case 1:{
            smallPlan = [oneDayArray objectAtIndex:timeIndexPath.section];
        }break;
            
        case 2:{
            smallPlan = [twoDayArray objectAtIndex:timeIndexPath.section];
        }break;
            
        case 3:{
            smallPlan = [threeDayArray objectAtIndex:timeIndexPath.section];
        }
            break;
            
        case 4:{
            smallPlan = [fourDayArray objectAtIndex:timeIndexPath.section];
        }
            break;
            
        case 5:{
            smallPlan = [fiveDayArray objectAtIndex:timeIndexPath.section];
        }
            break;
            
        case 6:{
            smallPlan = [sixDayArray objectAtIndex:timeIndexPath.section];
        }
            break;
            
        case 7:{
            smallPlan = [sevenDayArray objectAtIndex:timeIndexPath.section];
        }
            break;
            
        default:
            break;
    }
    if (timeIndexPath.row == 2) {
        if (![RTUtil isEmpty:smallPlan.smallplanendtime]) {
            if ([theDate compare:smallPlan.smallplanendtime] == NSOrderedDescending) {
                UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"选择时间" message:@"开始时间必须大于结束时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
                [self reloadTableViewData];
                return;
            }
        }
        smallPlan.smallplanbegintime = theDate;
    }else if(timeIndexPath.row == 3){
        
        if (![RTUtil isEmpty:smallPlan.smallplanbegintime]) {
            if ([theDate compare:smallPlan.smallplanbegintime] == NSOrderedAscending) {
                UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"选择时间" message:@"开始时间必须大于结束时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
                [self reloadTableViewData];
                return;
            }
        }
        
        smallPlan.smallplanendtime = theDate;
    }
    [self reloadTableViewData];
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"Date selection was canceled");
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        SmallHealthPlan *smallPlan;
        switch (currentDay) {
            case 1:{
                smallPlan = [oneDayArray objectAtIndex:timeIndexPath.section];
            }break;
                
            case 2:{
                smallPlan = [twoDayArray objectAtIndex:timeIndexPath.section];
            }break;
                
            case 3:{
                smallPlan = [threeDayArray objectAtIndex:timeIndexPath.section];
            }
                break;
                
            case 4:{
                smallPlan = [fourDayArray objectAtIndex:timeIndexPath.section];
            }
                break;
                
            case 5:{
                smallPlan = [fiveDayArray objectAtIndex:timeIndexPath.section];
            }
                break;
                
            case 6:{
                smallPlan = [sixDayArray objectAtIndex:timeIndexPath.section];
            }
                break;
                
            case 7:{
                smallPlan = [sevenDayArray objectAtIndex:timeIndexPath.section];
            }
                break;
                
            default:
                break;
        }
        if (alertView.tag == 4) {
            smallPlan.smallplanmark = [NSString stringWithFormat:@"%@卡路里",textfield.text];
        }else if (alertView.tag == 5){
            smallPlan.smallplancontent = [NSString stringWithFormat:@"%@",textfield.text];
        }
        [self reloadTableViewData];
    }
}

@end
