//
//  RTRegisterViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/10/23.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTRegisterViewController.h"
#import "RTUtil.h"
#import "RTLoginRequest.h"
#import "RTIntroductionViewController.h"

@interface RTRegisterViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RTRegisterViewController

static int myTime;

UIAlertView *alertSuccess;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"注册";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    [self.submitButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getIdentityButtonAction:(id)sender {
    if (![RTUtil isValidateMobile:self.telephoneText.text]) {
        
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [errorAlert show];
    }
    else{
        if (![JDStatusBarNotification isVisible]) {
            [JDStatusBarNotification showWithStatus:@"稍候..."];
        }
        
        [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
        
        //计时器
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeButtonTitle) userInfo:nil repeats:YES];
        self.getIdentifyButton.enabled = NO;
        self.getIdentifyLabel.text = @"30秒后重新获取";
        self.getIdentifyLabel.textColor = [UIColor grayColor];
        myTime = 30;
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:self.telephoneText.text,@"telnumber", nil];
        [RTLoginRequest getidentifyWith:dictionary success:^(NSDictionary *response) {
            if([[[response objectForKey:@"resp"] objectForKey:@"respCode"] isEqualToString:@"000000"]){
                NSLog(@"验证码已发送");
                [JDStatusBarNotification showWithStatus:@"验证码已发送√" dismissAfter:1.4];
            }
            else{
                NSLog(@"验证码发送失败");
                [JDStatusBarNotification showWithStatus:@"验证码发送失败" dismissAfter:1.4];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"验证码发送失败");
            [JDStatusBarNotification showWithStatus:@"发送失败" dismissAfter:1.4];
        }];
    }
    
}

- (void)changeButtonTitle
{
    if (myTime > 0) {
        self.getIdentifyButton.enabled = NO;
        myTime --;
        NSString *string = [NSString stringWithFormat:@"%d秒后重新获取", myTime];
        self.getIdentifyLabel.text = string;
        self.getIdentifyLabel.textColor = [UIColor grayColor];
    }
    else{
        [self.timer invalidate];
        self.getIdentifyButton.enabled = YES;
        self.getIdentifyLabel.text = @"重新获取";
        self.getIdentifyLabel.textColor = [UIColor colorWithRed:80/255.0 green:145/255.0 blue:241/255.0 alpha:1.0];
        
    }
}


- (IBAction)registerClick:(id)sender {
    
    if (![RTUtil isValidateMobile:self.telephoneText.text]) {
        
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [errorAlert show];
    }
    else{
        if(![RTUtil matchpassword:self.passwordText.text]){
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"密码格式错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
        else{
            if (![self.passwordText.text isEqualToString:self.confirmPasswordText.text]) {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"两次密码不一致" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [errorAlert show];
            }
            else{
                if (self.telephoneIdentifyText.text == nil || self.telephoneIdentifyText.text == NULL) {
                    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入收到的验证码" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                    [errorAlert show];
                }
                else{
                    if (![JDStatusBarNotification isVisible]) {
                        [JDStatusBarNotification showWithStatus:@"稍候..."];
                    }
                    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
                    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:self.telephoneText.text, @"telnumber", self.telephoneIdentifyText.text, @"identity", nil];
                    [RTLoginRequest verifyWith:dictionary success:^(id response) {
                        if ([[response objectForKey:@"state"] isEqualToNumber:[NSNumber numberWithInt:URL_NORMAL]]) {
                            NSLog(@"手机验证成功");
                            NSDictionary *regDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:self.telephoneText.text, @"username", self.passwordText.text, @"userpassword", nil];
                            [RTLoginRequest registerWith:regDictionary success:^(id response) {
                                if([[response objectForKey:@"state"] integerValue] == 1000){
                                    
                                    NSLog(@"注册成功");
                                    [JDStatusBarNotification showWithStatus:@"注册成功√" dismissAfter:1.4];
                                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userid"];
                                    [RTLoginRequest loginWith:regDictionary success:^(id response) {
                                        if ([[response objectForKey:@"state"]integerValue] == 1000) {
                                            [[NSNotificationCenter defaultCenter]postNotificationName:LOGINSTATECHANGE object:@YES];
                                            //存储数据
                                            
                                        }else{
                                            //错误信息
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录" message:@"账号或密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                            [alert show];
                                            self.passwordText.text = nil;
                                        }
                                    } failure:^(NSError *error) {
                                        NSLog(@"登录失败");
                                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录" message:@"网络连接错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                        [alert show];
                                        self.passwordText.text = nil;
                                    }];
                                }
                                else if([[response objectForKey:@"state"] integerValue] == 1007){
                                    NSLog(@"已被注册");
                                    [JDStatusBarNotification showWithStatus:@"该手机号已被注册" dismissAfter:1.4];
                                }
                                else
                                {
                                    NSLog(@"注册失败");
                                    [JDStatusBarNotification showWithStatus:@"注册失败" dismissAfter:1.4];
                                }
                            } failure:^(NSError *error) {
                                NSLog(@"注册失败");
                                [JDStatusBarNotification showWithStatus:@"失败" dismissAfter:1.4];
                            }];
                        }
                        else{
                            NSLog(@"手机验证失败");
                            [JDStatusBarNotification showWithStatus:@"手机验证失败" dismissAfter:1.4];
                        }
                        
                    } failure:^(NSError *error) {
                        NSLog(@"验证失败");
                        [JDStatusBarNotification showWithStatus:@"失败" dismissAfter:1.4];
                    }];
                }
            }
        }
    }
}

//- (void)dismissAlert
//{
//    [alertSuccess dismissWithClickedButtonIndex:0 animated:NO];
//}

@end
