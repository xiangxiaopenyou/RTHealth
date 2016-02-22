//
//  RTTrendReplyViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/12/9.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTTrendReplyViewController.h"
#import "RTTrendsRequest.h"

@interface RTTrendReplyViewController ()<UITextViewDelegate>{
    UIButton *submitButton;
    UITextView *replyTextView;
    UILabel *tipLabel;
    
    UserInfo *userinfo;
}

@end

@implementation RTTrendReplyViewController

@synthesize ownerString, replyString, commentUserID, commentID, trendID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    NSString *titleString;
    titleString = [replyString stringByAppendingString:ownerString];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, TITLE_LABEL_Y, SCREEN_WIDTH - 120   , TITLE_LABEL_HEIGHT)];
    titleLabel.text = titleString;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    //发送按钮
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(SCREEN_WIDTH - 40, 22, 40, 40);
    [submitButton setTitle:@"发送" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    submitButton.enabled = NO;
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    //评论输入框
    replyTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 100)];
    replyTextView.alwaysBounceVertical = YES;
    replyTextView.font = SMALLFONT_14;
    replyTextView.showsVerticalScrollIndicator = NO;
    replyTextView.returnKeyType = UIReturnKeyDone;
    replyTextView.delegate = self;
    [self.view addSubview:replyTextView];
    
    [replyTextView becomeFirstResponder];
    
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NAVIGATIONBAR_HEIGHT + 6, 180, 20)];
    tipLabel.text = @"回复点什么吧...(200字以内)";
    tipLabel.font = SMALLFONT_14;
    tipLabel.textColor = [UIColor grayColor];
    [self.view addSubview:tipLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)submitButtonClick
{
    if ([RTUtil isBlankString:replyTextView.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先写点什么吧~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        if ([replyTextView.text length] > 200) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字数不要超过200个哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
            RTUserInfo *userData = [RTUserInfo getInstance];
            userinfo = userData.userData;
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:userinfo.userid forKey:@"userid"];
            [dic setObject:userinfo.usertoken forKey:@"usertoken"];
            [dic setObject:trendID forKey:@"trendid"];
            [dic setObject:replyTextView.text forKey:@"cpartakcontent"];
            [dic setObject:commentID forKey:@"commentid"];
            [dic setObject:commentUserID forKey:@"commentuserid"];
            //[dic setObject:replyUserNickname forKey:@"cpartakenickname"];
            NSLog(@"dic %@", dic);
            [RTTrendsRequest replyWith:dic success:^(id response) {
                if ([[response objectForKey:@"state"] integerValue] == 1000) {
                    NSLog(@"回复成功");
                    [[NSNotificationCenter defaultCenter] postNotificationName:REPLYTRENDSUCCESS object:@YES];
                }
                else{
                    NSLog(@"回复失败");
                }
            } failure:^(NSError *error) {
                
                NSLog(@"失败");
            }];

        }
        
    }
}
#pragma mark - textview Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    [tipLabel removeFromSuperview];
    [submitButton setEnabled:YES];
    [submitButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    float textViewHeight = 100;
    CGSize textSize = [replyTextView.text sizeWithFont:SMALLFONT_14 constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    if (textSize.height > SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) {
        textViewHeight = textSize.height + 5;
        replyTextView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, textViewHeight);
        replyTextView.contentInset = UIEdgeInsetsMake(0, 0, textViewHeight - SCREEN_HEIGHT + NAVIGATIONBAR_HEIGHT, 0);
    }
    else{
        replyTextView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES) {
        [textView resignFirstResponder];
        return  NO;
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
