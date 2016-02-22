//
//  RTRecommendedPlanViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 15/1/7.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import "RTRecommendedPlanViewController.h"
#import "RTRecommendedPlanTableViewCell.h"
#import "RTPersonalRequest.h"

@interface RTRecommendedPlanViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate>{
    UIImageView *imageView;
    UITableView *planTableView;
    UITextView *myTextView;
    UITextField *nicknameTextField;
    UILabel *textViewLabel;
    UserInfo *_userinfo;
    
    NSMutableArray *planArray;
}

@end

@implementation RTRecommendedPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    _userinfo = userData.userData;
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    //后退按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(12, 40, 60, 60);
    [backButton setImage:[UIImage imageNamed:@"last.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //前进按钮
    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(SCREEN_WIDTH - 72, 40, 60, 60);
    [forwardButton setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(forwardButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forwardButton];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 110, 288, 355)];
    imageView.image = [UIImage imageNamed:@"recommended_plan.png"];
    [self.view addSubview:imageView];
    
    //推荐计划
    planTableView = [[UITableView alloc] initWithFrame:CGRectMake(25, 154, 268, 145)];
    planTableView.delegate = self;
    planTableView.dataSource = self;
    planTableView.backgroundColor = [UIColor clearColor];
    planTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:planTableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, planTableView.frame.size.width, 25)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(0, 2.5, 48, 20)];
    type.text = @"类型";
    type.font = SMALLFONT_10;
    type.textColor = [UIColor colorWithRed:233/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
    type.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:type];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(48, 0, 0.5, 25)];
    line1.backgroundColor = LINE_COLOR;
    [headerView addSubview:line1];
    
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 2.5, 100, 20)];
    introLabel.text = @"简介";
    introLabel.textColor = [UIColor colorWithRed:233/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
    introLabel.textAlignment = NSTextAlignmentLeft;
    introLabel.font = SMALLFONT_10;
    [headerView addSubview:introLabel];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 24.5, planTableView.frame.size.width, 0.5)];
    line2.backgroundColor = LINE_COLOR;
    [headerView addSubview:line2];
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, planTableView.frame.size.width, 0.5)];
    line3.backgroundColor = LINE_COLOR;
    [headerView addSubview:line3];
    planTableView.tableHeaderView = headerView;
    
    [self getRecommendedPlan];
    
    //昵称
    nicknameTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, 315, 248, 30)];
    nicknameTextField.placeholder = _userinfo.usernickname;
    nicknameTextField.backgroundColor = [UIColor whiteColor];
    nicknameTextField.textAlignment = NSTextAlignmentCenter;
    nicknameTextField.font = SMALLFONT_12;
    nicknameTextField.delegate = self;
    nicknameTextField.returnKeyType= UIReturnKeyDone;
    nicknameTextField.layer.borderWidth = 2;
    nicknameTextField.layer.borderColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0].CGColor;
    nicknameTextField.layer.masksToBounds = YES;
    nicknameTextField.layer.cornerRadius = 2;
    [self.view addSubview:nicknameTextField];
    
    //健身宣言
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(35, 380, 248, 60)];
    myTextView.backgroundColor = [UIColor whiteColor];
    myTextView.textColor = [UIColor colorWithRed:233/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
    myTextView.showsVerticalScrollIndicator = NO;
    myTextView.delegate = self;
    myTextView.returnKeyType = UIReturnKeyDone;
    myTextView.layer.borderWidth = 2;
    myTextView.layer.borderColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0].CGColor;
    myTextView.layer.masksToBounds = YES;
    myTextView.layer.cornerRadius = 2;
    [self.view addSubview:myTextView];
    
    textViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 381, 200, 25)];
    textViewLabel.text = @"写下你的健身宣言(100字以内)";
    textViewLabel.font = SMALLFONT_12;
    textViewLabel.textColor = [UIColor grayColor];
    [self.view addSubview:textViewLabel];
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [myTextView resignFirstResponder];
    [nicknameTextField resignFirstResponder];
    [UIView beginAnimations:@"HideKeyboard" context:nil];
    [UIView setAnimationDuration:0.50f];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forwardButtonClick{
    if (![RTUtil isBlankString:nicknameTextField.text]) {
        _userinfo.usernickname = nicknameTextField.text;
    }
    if ([myTextView.text length] > 100) {
        _userinfo.userintroduce = [myTextView.text substringWithRange:NSMakeRange(0, 100)];
    }
    else{
        _userinfo.userintroduce = myTextView.text;
    }
    [self saveInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@YES];
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}
- (void)saveInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:_userinfo.userid forKey:@"userid"];
    [dic setObject:_userinfo.usertoken forKey:@"usertoken"];
    if ([RTUtil isEmpty:_userinfo.usernickname]) {
        [dic setObject:@"" forKey:@"usernickname"];
    }else{
        [dic setObject:_userinfo.usernickname forKey:@"usernickname"];
    }
    if ([RTUtil isEmpty:_userinfo.userintroduce]) {
        [dic setObject:@"" forKey:@"userintroduce"];
    }else{
        [dic setObject:_userinfo.userintroduce forKey:@"userintroduce"];
    }
    
    if ([RTUtil isEmpty:_userinfo.userweightpublic]) {
        [dic setObject:@"1" forKey:@"userweightpublic"];
    }else{
        [dic setObject:_userinfo.userweightpublic forKey:@"userweightpublic"];
    }
    if ([RTUtil isEmpty:_userinfo.userweight]) {
        [dic setObject:@"0" forKey:@"userweight"];
    }else{
        [dic setObject:_userinfo.userweight forKey:@"userweight"];
    }
    if ([RTUtil isEmpty:_userinfo.userheightpublic]) {
        [dic setObject:@"1" forKey:@"userheightpublic"];
    }else{
        [dic setObject:_userinfo.userheightpublic forKey:@"userheightpublic"];
    }
    if ([RTUtil isEmpty:_userinfo.userheight]) {
        [dic setObject:@"0" forKey:@"userheight"];
    }else{
        [dic setObject:_userinfo.userheight forKey:@"userheight"];
    }
    if ([RTUtil isEmpty:_userinfo.userbirthday]) {
        [dic setObject:[CustomDate getBirthDayString:[NSDate date]] forKey:@"userbirthday"];
    }else{
        [dic setObject:_userinfo.userbirthday forKey:@"userbirthday"];
    }
    if ([RTUtil isEmpty:_userinfo.usersex]) {
        [dic setObject:@"1" forKey:@"userheadportrait"];
    }else{
        [dic setObject:_userinfo.usersex forKey:@"usersex"];
    }
    if ([RTUtil isEmpty:_userinfo.userphoto]) {
        [dic setObject:@"" forKey:@"userheadportrait"];
    }else{
        [dic setObject:_userinfo.userphoto forKey:@"userheadportrait"];
    }
    if ([RTUtil isEmpty:_userinfo.userfavoritesports]) {
        [dic setObject:@"" forKey:@"userfavoritesports"];
    }else{
        [dic setObject:_userinfo.userfavoritesports forKey:@"userfavoritesports"];
    }
    
    [RTPersonalRequest modifyUserInfoWith:dic success:^(id response){
        NSLog(@"保存信息成功");
    } failure:^(NSError *error){}];
    
}

#pragma mark - UITextFeild Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([@"\n" isEqualToString:string]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.50f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, self.view.frame.size.height - 600, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:@"HideKeyboard" context:nil];
    [UIView setAnimationDuration:0.50f];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //int offset = frame.origin.y + 100 - (self.view.frame.size.height - 216);
    textViewLabel.hidden = YES;
    NSTimeInterval animationDuration = 0.50f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, self.view.frame.size.height - 700, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView beginAnimations:@"HideKeyboard" context:nil];
    [UIView setAnimationDuration:0.50f];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}


#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return planArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    NSDictionary *dict = [planArray objectAtIndex:indexPath.row];
    RTRecommendedPlanTableViewCell *cell = [[RTRecommendedPlanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withDic:dict];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


- (void)getRecommendedPlan{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_userinfo.userid forKey:@"userid"];
    [dic setObject:_userinfo.usertoken forKey:@"usertoken"];
    [dic setObject:_userinfo.userweight forKey:@"weight"];
    [dic setObject:_userinfo.userheight forKey:@"height"];
    [self getRecommentdedPlanWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"成功");
            planArray = [[NSMutableArray alloc] init];
            planArray = [response objectForKey:@"data"];
            [planTableView reloadData];
        }
        else{
        }
    } failure:^(NSError *error) {
        NSLog(@"网络问题");
    }];
}

- (void)getRecommentdedPlanWith:(NSDictionary*)paramter success:(void(^)(id response))success failure:(void(^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_BASE, URL_GETRECOMMENDEDPLAN];
    [RTNetWork post:url params:paramter success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
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
