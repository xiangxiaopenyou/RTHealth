//
//  RTWeightRecordViewController.m
//  RTHealth
//
//  Created by cheng on 14/12/30.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTWeightRecordViewController.h"
#import "RTWeightLineWebViewController.h"
#import "RTMoreRequest.h"
#import "RTFoodWebViewController.h"

@interface RTWeightRecordViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    UIPickerView *intpicker;
    UIPickerView *floatpicker;
    NSMutableArray *intArray;
    NSMutableArray *floatArray;
    NSString *weightfloatString;
    NSString *weightintString;
    UserInfo *userinfo;
    float weight_float;
    float height_float;
}

@end

@implementation RTWeightRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"记录体重";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    
    UIButton *btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMessage.frame = CGRectMake(SCREEN_WIDTH - 37, (NAVIGATIONBAR_HEIGHT - 44) +10 , 27, 24);
    [btnMessage addTarget:self action:@selector(weightLine) forControlEvents:UIControlEventTouchUpInside];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"weightline.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnMessage];
    
    intArray = [[NSMutableArray alloc]init];
    for (int i = 30; i < 150 ;i++){
        [intArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    floatArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<10; i ++) {
        [floatArray addObject:[NSString stringWithFormat:@".%d",i]];
    }
    if ([RTUtil isEmpty:userinfo.userweight] || [userinfo.userweight intValue]==0) {
        weightfloatString = @".0";
        weightintString = @"30";
    }else{
        float f = [userinfo.userweight floatValue];
        weightintString = [NSString stringWithFormat:@"%d",(int)f];
        weightfloatString = [NSString stringWithFormat:@".%d",(int)((f - (int)f)*10)];
    }
    [self.intPick selectRow: [intArray indexOfObject:weightintString] inComponent:0 animated:NO];
    [self.floatPick selectRow: [floatArray indexOfObject:weightfloatString] inComponent:0 animated:NO];
    self.weightLabel.text = [NSString stringWithFormat:@"%@%@",weightintString,weightfloatString];
    
    weight_float = [[NSString stringWithFormat:@"%@%@",weightintString,weightfloatString] floatValue];
    height_float = [userinfo.userheight floatValue];
    if (height_float > 0 && weight_float >0) {
        
        self.bmiLabel.text = [NSString stringWithFormat:@"%.1f",weight_float*10000/(height_float*height_float)];
    }
    
}

- (void)weightLine{
    RTWeightLineWebViewController *weghtLine = [[RTWeightLineWebViewController alloc]init];
    [self.navigationController pushViewController:weghtLine animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickBMI:(id)sender{
    RTFoodWebViewController *foodViewController = [[RTFoodWebViewController alloc]init];
    foodViewController.url = [NSString stringWithFormat:@"%@%@?userid=%@",URL_BASE,URL_HEALTH_BMI,userinfo.userid];
    foodViewController.title = @"BMI";
    [self.navigationController pushViewController:foodViewController animated:YES];
}
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickSure:(id)sender{
    if ([RTUtil isEmpty:[NSString stringWithFormat:@"%@%@",weightintString,weightfloatString]]) {
        return;
    }
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:userinfo.userid forKey:@"userid"];
    [dictionary setObject:userinfo.usertoken forKey:@"usertoken"];
    [dictionary setObject:[NSString stringWithFormat:@"%@%@",weightintString,weightfloatString] forKey:@"weight"];
    [RTMoreRequest upWeightWith:dictionary success:^(id response){
        
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            userinfo.userweight = [NSString stringWithFormat:@"%@%@",weightintString,weightfloatString];
            [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        }
    } failure:^(NSError *error){
        
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:WEIGHT_RECORD_TIME];
    [[NSNotificationCenter defaultCenter] postNotificationName:WEIGHT_RECORD_TIME object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickCancel:(id)sender{
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 11) {
        return [intArray count];
    }else{
        return [floatArray count];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if (pickerView.tag == 11) {
        return [intArray objectAtIndex:row];
    }else{
        return [floatArray objectAtIndex:row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 11) {
        weightintString = [NSString stringWithFormat:@"%@",[intArray objectAtIndex:row]];
        
    }else{
        weightfloatString = [NSString stringWithFormat:@"%@",[floatArray objectAtIndex:row]];
    }
    self.weightLabel.text = [NSString stringWithFormat:@"%@%@",weightintString,weightfloatString];
    
    weight_float = [[NSString stringWithFormat:@"%@%@",weightintString,weightfloatString] floatValue];
    height_float = [userinfo.userheight floatValue];
    if (height_float > 0 && weight_float >0) {
        self.bmiLabel.text = [NSString stringWithFormat:@"%.1f",weight_float*10000/(height_float*height_float)];
    }
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//    return 60;
//}
//
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//    return 50;
//}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
//    label.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:10/255.0 alpha:1.0];
//    [view1 addSubview:label];
//    return view1;
//}

@end
