//
//  RTFindPasswordStepTwoViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/21.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFindPasswordStepTwoViewController.h"
#import "RTUtil.h"
#import "RTLoginRequest.h"

@interface RTFindPasswordStepTwoViewController ()

@property (nonatomic, assign) UIActivityIndicatorViewStyle indicatorViewStyle;

@end

@implementation RTFindPasswordStepTwoViewController

@synthesize telephoneNum;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"找回密码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    [self.submitButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
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

- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonClick:(id)sender {
    
    if(![RTUtil matchpassword:self.passwordTextField.text]){
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"密码格式错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [errorAlert show];
    }
    else{
        if (![JDStatusBarNotification isVisible]) {
            self.indicatorViewStyle = UIActivityIndicatorViewStyleGray;
            [JDStatusBarNotification showWithStatus:@"稍候..."];
        }
        [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:self.indicatorViewStyle];
        if (![self.passwordTextField.text isEqualToString:self.passwordEnsureTextField.text]) {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"两次密码不一致" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
        else{
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:telephoneNum, @"username", self.passwordTextField.text, @"userpassword", nil];
            [RTLoginRequest upPasswordWith:dictionary success:^(id response) {
                if ([[response objectForKey:@"state"] integerValue] == 1000) {
                    NSLog(@"找回密码成功");
                    [JDStatusBarNotification showWithStatus:@"找回密码成功√" dismissAfter:2];
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
                }
                else if ([[response objectForKey:@"state"]  integerValue] == 1003){
                    [JDStatusBarNotification showWithStatus:@"你的手机还没注册哦~" dismissAfter:2];
                }
                else{
                    NSLog(@"找回密码失败");
                    [JDStatusBarNotification showWithStatus:@"找回密码失败" dismissAfter:2];
                }
            } failure:^(NSError *error) {
                NSLog(@"找回失败");
                [JDStatusBarNotification showWithStatus:@"请检查网络" dismissAfter:2];
            }];
        }

    }
}
@end
