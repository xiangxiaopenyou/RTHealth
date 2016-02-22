//
//  RTTrendsClassifyViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/11/25.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTTrendsClassifyViewController.h"
#import "RTTrendsRequest.h"
@interface RTTrendsClassifyViewController (){
    UIScrollView *mScrollView;
}

@end

@implementation RTTrendsClassifyViewController
{
    UserInfo *userinfo;
    NSMutableArray *classifyArray;
    NSMutableArray *valueArray;
    
}

@synthesize classifyMutableArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0]];
    
    self.trendsTextfield.delegate = self;
    
    self.trendsTextfield.layer.masksToBounds = YES;
    self.trendsTextfield.layer.cornerRadius = 4;
    self.trendsTextfield.layer.borderWidth = 0.5;
    self.trendsTextfield.layer.borderColor = [UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0].CGColor;
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    [self getTrendsClassify];
}
- (void)getTrendsClassify
{
    classifyArray = [[NSMutableArray alloc] init];
    valueArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userinfo.userid forKey:@"userid"];
    [dic setObject:userinfo.usertoken forKey:@"usertoken"];
    [RTTrendsRequest getTrendsClassifyWith:dic success:^(id response) {
        if ([[response objectForKey:@"state"] integerValue] == 1000) {
            NSLog(@"获取话题分类成功");
            valueArray = [response objectForKey:@"data"];
            
            if (![RTUtil isEmpty:valueArray]) {
                
                for(int i = 0; i < valueArray.count; i++){
                    NSDictionary *dictionary = [valueArray objectAtIndex:i];
                    [classifyArray addObject:[dictionary objectForKey:@"value"]];
                }
            }
            else{
                classifyArray = nil;
            }
            
            mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
            mScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, (classifyArray.count/2 + 1)*40 + 20);
            mScrollView.showsVerticalScrollIndicator = NO;
            mScrollView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:mScrollView];
            
            for(int i = 0; i < classifyArray.count; i++){
                 UIView *classifyView = [[UIView alloc] initWithFrame:CGRectMake(i%2*SCREEN_WIDTH/2+ 5 * ((i+1)%2 + 1), 20 + i/2*40, 145, 30)];
                BOOL is = NO;
                for(int j = 0; j < classifyMutableArray.count; j++){
                    if ([classifyMutableArray[j] isEqualToString:classifyArray[i]]) {
                        is = YES;
                    }
                }
                if (is) {
                    classifyView.backgroundColor = [UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0];
                }
                else{
                    classifyView.backgroundColor = [UIColor colorWithRed:58/255.0 green:147/255.0 blue:209/255.0 alpha:1.0];
                }
                classifyView.layer.masksToBounds = YES;
                classifyView.layer.cornerRadius = 15;
                UILabel *classifyLabel = [[UILabel alloc] initWithFrame:classifyView.frame];
                classifyLabel.textColor = [UIColor whiteColor];
                classifyLabel.font = [UIFont systemFontOfSize:15];
                classifyView.tag = i;
                classifyLabel.text = [classifyArray objectAtIndex:i];
                classifyLabel.textAlignment = NSTextAlignmentCenter;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClassify:)];
                [classifyView addGestureRecognizer:tap];
                [mScrollView addSubview:classifyView];
                [mScrollView addSubview:classifyLabel];
                
            }
        }
        else{
            NSLog(@"获取话题分类失败");
        }
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
}

- (void)clickClassify:(UITapGestureRecognizer*)tap
{
    UIView *view = (UIView*)tap.view;
    [self.delegate clickClassify:[classifyArray objectAtIndex:view.tag]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textfield Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self.CancelOrSubmitButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.CancelOrSubmitButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    return YES;
}

- (IBAction)CancelOrSubmitButtonClick:(id)sender {
    
    if ([self isBlankString:self.trendsTextfield.text]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSString *classifyString = [self.trendsTextfield.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate clickCancelOrSubmitButton:classifyString];
    }
    
}


//判断字符串是否为空
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

@end
