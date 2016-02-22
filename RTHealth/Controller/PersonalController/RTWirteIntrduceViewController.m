//
//  RTWirteIntrduceViewController.m
//  RTHealth
//
//  Created by cheng on 14/10/30.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTWirteIntrduceViewController.h"

@interface RTWirteIntrduceViewController ()<UITextViewDelegate>{
    UITextView *texview;
    UILabel *textnumber;
}

@end

@implementation RTWirteIntrduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"介绍";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setFrame:CGRectMake(SCREEN_WIDTH-75, (44-26)/2+20, 65, 26)];
    [saveBtn setImage:[UIImage imageNamed:@"sure_right.png"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    texview = [[UITextView alloc]initWithFrame:CGRectMake(10, NAVIGATIONBAR_HEIGHT+10, SCREEN_WIDTH - 20, SCREEN_HEIGHT- NAVIGATIONBAR_HEIGHT - 20)];
    texview.text = self.content;
    texview.font = VERDANA_FONT_14;
    texview.delegate = self;
    [self.view addSubview:texview];
    
    textnumber = [[UILabel alloc]initWithFrame:CGRectMake(270, 64, 45, 20)];
    textnumber.text = [NSString stringWithFormat:@"%lu/250",(unsigned long)[self.content length]];
    textnumber.textColor = [UIColor blackColor];
    textnumber.textAlignment = NSTextAlignmentCenter;
    textnumber.font = VERDANA_FONT_10;
    [self.view addSubview:textnumber];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [texview becomeFirstResponder];
}
- (void)keyboardShow:(NSNotification *)notif {
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.origin.y;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    texview.frame = CGRectMake(10, NAVIGATIONBAR_HEIGHT+10, SCREEN_WIDTH - 20, SCREEN_HEIGHT- NAVIGATIONBAR_HEIGHT - 20-y);
    [UIView commitAnimations];
}

- (void)keyboardHide:(NSNotification *)notif{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    texview.frame = CGRectMake(10, NAVIGATIONBAR_HEIGHT+10, SCREEN_WIDTH - 20, SCREEN_HEIGHT- NAVIGATIONBAR_HEIGHT - 20);
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveClick
{
    NSLog(@"save");
    [texview resignFirstResponder];
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(texview.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)returnText:(ReturnTextBlock)block {
    self.returnTextBlock = block;
}
-(void)viewWillDisappear:(BOOL)animated {
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textView:(UITextView *)atextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *new = [texview.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res = 250-[new length];
    textnumber.text = [NSString stringWithFormat:@"%lu/250",(unsigned long)[new length]];
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[text length]+res};
        if (rg.length>0) {
            NSString *s = [text substringWithRange:rg];
            [texview setText:[texview.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
}

@end
