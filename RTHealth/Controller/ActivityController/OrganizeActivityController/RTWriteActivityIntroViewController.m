//
//  RTWriteActivityIntroViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/12/5.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTWriteActivityIntroViewController.h"

@interface RTWriteActivityIntroViewController ()<UITextViewDelegate>

@end

@implementation RTWriteActivityIntroViewController

@synthesize introTextView;
@synthesize tipLabel;
@synthesize introString;

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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"活动简介";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    //完成按钮
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(SCREEN_WIDTH - 45, 35, 40, 25);
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    finishButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [finishButton addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
    introTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, NAVIGATIONBAR_HEIGHT + 5, SCREEN_WIDTH - 10, SCREEN_HEIGHT)];
    introTextView.delegate = self;
    introTextView.returnKeyType = UIReturnKeyDone;
    introTextView.font = SMALLFONT_14;
    if (![RTUtil isEmpty:introString]) {
        introTextView.text = introString;
    }
    introTextView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:introTextView];
    [introTextView becomeFirstResponder];
    
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, NAVIGATIONBAR_HEIGHT + 11, 200, 20)];
    tipLabel.text = @"写点活动简介哦~(200字以内)";
    tipLabel.font = SMALLFONT_14;
    tipLabel.textColor = [UIColor colorWithWhite:0.7 alpha:0.9];
    [self.view addSubview:tipLabel];
    if (![RTUtil isEmpty:introString]) {
        tipLabel.hidden = YES;
    }
}

#pragma mark - UITextView Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    tipLabel.hidden = YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES) {
        [textView resignFirstResponder];
        return  NO;
    }
    return YES;
}


- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)finishClick
{
    if ([RTUtil isEmpty:introTextView.text]) {
        NSLog(@"没有编辑");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"先写点简介再提交哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        if (introTextView.text.length > 200) {
            introString = [introTextView.text substringWithRange:NSMakeRange(0, 200)];
        }
        else{
            introString = introTextView.text;
        }
        [self.delegate clickFinishButton];
        [self.navigationController popViewControllerAnimated:YES];
        
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
