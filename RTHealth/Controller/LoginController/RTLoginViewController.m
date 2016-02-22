//
//  RTLoginViewController.m
//  RTHealth
//
//  Created by cheng on 14-10-22.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTLoginViewController.h"
#import "RTLoginRequest.h"
#import "RTRegisterViewController.h"
#import "RTFindPasswordViewController.h"

@interface RTLoginViewController ()<WXApiDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UIActivityIndicatorView *activity;

@end

@implementation RTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"登录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
//    if (isFirstLaunched) {
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        backButton.frame = CGRectMake(0, 20, 40, 40);
//        [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
//        [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:backButton];
//    }
    
    self.activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.activity.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.activity.backgroundColor = [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:0.5];
    self.activity.hidesWhenStopped = YES;
    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.activity];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginStateChange:) name:LOGINSTATECHANGE object:nil];
    
}


- (void)loginStateChange:(NSNotification *)notification{
    
    [self.activity stopAnimating];
    BOOL loginSuccess = [notification.object boolValue];
    if (loginSuccess) {
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登录" message:@"登录失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginClick:(id)sender
{
    [self.activity startAnimating];
    if ([self authText]) {
        NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:self.usernameField.text,@"username",self.passwordField.text,@"userpassword", nil];
        
        [RTLoginRequest loginWith:dictionary success:^(NSDictionary *response){
            
            if ([[response objectForKey:@"state" ] integerValue] == 1000) {
                //存储数据
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@YES];
            }else{
                //错误信息
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录" message:@"账号或密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                self.passwordField.text = nil;
            }
            [self.activity stopAnimating];
            
        }failure:^(NSError *error){
            NSLog(@"登陆失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录" message:@"网络连接错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            self.passwordField.text = nil;
            [self.activity stopAnimating];
        }];

    }else{
        
        [self.activity stopAnimating];
    }
}

- (BOOL)authText{
    
    if ([RTUtil isValidateMobile:self.usernameField.text]) {
        NSLog(@"用户名正则匹配正确");
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录" message:@"用户名不是手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if ([RTUtil matchpassword:self.passwordField.text]) {
        NSLog(@"密码正则匹配正确");
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录" message:@"密码只能有数字和字母，长度6-16" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}
- (void)loginWithqq:(id)sender
{
    
    [self.activity startAnimating];
    [[NSNotificationCenter defaultCenter]postNotificationName:LOGINWITHQQ object:nil];
}

- (IBAction)TurnToRegister:(id)sender {
    RTRegisterViewController *regsiterView = [[RTRegisterViewController alloc] init];
    [self.navigationController pushViewController:regsiterView animated:YES];
    
}

- (IBAction)turnToFindPassword:(id)sender {
    
    RTFindPasswordViewController *findPasswordView = [[RTFindPasswordViewController alloc] init];
    [self.navigationController pushViewController:findPasswordView animated:YES];
}

- (void)loginWithWeibo:(id)sender
{
    [self.activity startAnimating];
    [[NSNotificationCenter defaultCenter]postNotificationName:LOGINWITHWEIBO object:nil];
}

- (void)loginWithWeiChat:(id)sender
{
    [self.activity startAnimating];
    [[NSNotificationCenter defaultCenter]postNotificationName:LOGINWITHWEICHAT object:nil];
}
-(void)sendAuthRequest
{
    //构造SendAuthReq结构
}

#pragma mark textfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    }else{
        [self.usernameField resignFirstResponder];
        [self.passwordField resignFirstResponder];
    }
    return YES;
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
