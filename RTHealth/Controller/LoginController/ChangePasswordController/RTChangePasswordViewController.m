//
//  RTChangePasswordViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/12/31.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTChangePasswordViewController.h"
#import "RTLoginRequest.h"

@interface RTChangePasswordViewController ()
{
    UserInfo *userinfo;
}

@end

@implementation RTChangePasswordViewController

@synthesize oldPasswordTextField,nPasswordTextField,ntPasswordTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"修改密码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    //提交按钮
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(SCREEN_WIDTH - 40, 22, 40, 40);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT + 10, SCREEN_WIDTH, 120)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    //旧密码
    oldPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 5,SCREEN_WIDTH - 24, 35)];
    //oldPasswordTextField.borderStyle = UITextBorderStyleLine;
    oldPasswordTextField.secureTextEntry = YES;
    oldPasswordTextField.font = SMALLFONT_14;
    oldPasswordTextField.placeholder = @"输入旧密码";
    [contentView addSubview:oldPasswordTextField];
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 39.5, SCREEN_WIDTH - 24, 0.5)];
    line1.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    [contentView addSubview:line1];
    
    //新密码
    nPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, SCREEN_WIDTH - 24, 35)];
    //nPasswordTextField.borderStyle = UITextBorderStyleLine;
    nPasswordTextField.secureTextEntry = YES;
    nPasswordTextField.font = SMALLFONT_14;
    nPasswordTextField.placeholder = @"输入新密码(6-16位)";
    [contentView addSubview:nPasswordTextField];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(12, 79.5, SCREEN_WIDTH - 24, 0.5)];
    line2.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    [contentView addSubview:line2];
    
    //确认新密码
    ntPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 85, SCREEN_WIDTH - 24, 35)];
    //ntPasswordTextField.borderStyle = UITextBorderStyleLine;
    ntPasswordTextField.secureTextEntry = YES;
    ntPasswordTextField.font = SMALLFONT_14;
    ntPasswordTextField.placeholder = @"确认新密码";
    [contentView addSubview:ntPasswordTextField];
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)submitButtonClick
{
    if (![RTUtil matchpassword:oldPasswordTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码格式不正确哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        if (![RTUtil matchpassword:nPasswordTextField.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码格式不正确哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            if (![nPasswordTextField.text isEqualToString:ntPasswordTextField.text]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码不一致哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            else{
                if (![JDStatusBarNotification isVisible]) {
                    [JDStatusBarNotification showWithStatus:@"稍候..."];
                }
                [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:userinfo.userid forKey:@"userid"];
                [dic setObject:userinfo.usertoken forKey:@"usertoken"];
                [dic setObject:oldPasswordTextField.text forKey:@"oldpassword"];
                [dic setObject:nPasswordTextField.text forKey:@"newpassword"];
                [RTLoginRequest changePasswordWith:dic success:^(id response) {
                    if ([[response objectForKey:@"state"] integerValue] == 1000) {
                        NSLog(@"修改密码成功");
                        [self.navigationController popViewControllerAnimated:YES];
                        [JDStatusBarNotification showWithStatus:@"修改密码成功√" dismissAfter:1.4];
                    }
                    else if([[response objectForKey:@"state"] integerValue] == 1007){
                        NSLog(@"旧密码不正确");
                        [JDStatusBarNotification showWithStatus:@"旧密码错误" dismissAfter:1.4];
                    }
                    else{
                        NSLog(@"修改密码失败");
                        [JDStatusBarNotification showWithStatus:[response objectForKey:@"message"] dismissAfter:1.4];
                    }
                } failure:^(NSError *error) {
                    NSLog(@"网络问题");
                    [JDStatusBarNotification showWithStatus:@"网络问题" dismissAfter:1.4];
                }];
            }
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
