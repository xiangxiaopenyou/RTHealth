//
//  RTFindPasswordViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/21.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFindPasswordViewController.h"
#import "RTFindPasswordStepTwoViewController.h"
#import "RTLoginRequest.h"

@interface RTFindPasswordViewController ()

@property (nonatomic, strong)NSTimer *timer;

@end

@implementation RTFindPasswordViewController
static int myTime;

UIButton *nextStepButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    titleLabel.text = @"找回密码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextStepButton.frame = CGRectMake(SCREEN_WIDTH - 50, 22, 50, 40);
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    nextStepButton.titleLabel.font = SMALLFONT_14;
    [nextStepButton addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStepButton];
    nextStepButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextStepClick
{
    NSLog(@"xiang");
    if([self isBlankString:self.identifyTextField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请先输入收到的验证码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:self.telephoneTextField.text, @"telnumber", self.identifyTextField.text, @"identity", nil];
        [RTLoginRequest verifyWith:dictionary success:^(id response) {
            if ([[response objectForKey:@"state"]  isEqualToNumber:[NSNumber numberWithInt:URL_NORMAL]]) {
                NSLog(@"验证成功");
                RTFindPasswordStepTwoViewController *stepTwoView = [[RTFindPasswordStepTwoViewController alloc] init];
                stepTwoView.telephoneNum = self.telephoneTextField.text;
                [self.navigationController pushViewController:stepTwoView animated:YES];
            }
            else{
                NSString *message = [response objectForKey:@"message"];
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [failAlert show];
                NSLog(@"验证失败");
            }
        } failure:^(NSError *error) {
            NSLog(@"验证失败");
        }];
    }
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


- (IBAction)getIdentifyButtonClick:(id)sender {
    
    if (![RTUtil isValidateMobile:self.telephoneTextField.text]) {
        
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [errorAlert show];
    }
    else{
        if (![JDStatusBarNotification isVisible]) {
            [JDStatusBarNotification showWithStatus:@"正在发送验证码..."];
        }
        [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
        //计时器
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeButtonTitle) userInfo:nil repeats:YES];
        self.getIdentifyButton.enabled = NO;
        self.getIdentifyLabel.text = @"30秒后重新获取";
        self.getIdentifyLabel.textColor = [UIColor grayColor];
        myTime = 30;
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:self.telephoneTextField.text,@"telnumber", nil];
        [RTLoginRequest getidentifyWith:dictionary success:^(NSDictionary *response) {
            if([[[response objectForKey:@"resp"] objectForKey:@"respCode"] isEqualToString:@"000000"]){
                NSLog(@"验证码已发送");
                [JDStatusBarNotification showWithStatus:@"发送成功√" dismissAfter:1.4];
                nextStepButton.enabled = YES;
                [nextStepButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
            }
            else{
                [JDStatusBarNotification showWithStatus:@"发送失败" dismissAfter:1.4];
                NSLog(@"验证码发送失败");
            }
            
        } failure:^(NSError *error) {
            [JDStatusBarNotification showWithStatus:@"检查网络" dismissAfter:1.4];
            NSLog(@"验证码发送失败");
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
@end
