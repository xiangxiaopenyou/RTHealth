//
//  RTSelectClassifyViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/12/26.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTSelectClassifyViewController.h"
#import "RTTrendsRequest.h"

@interface RTSelectClassifyViewController ()
{
    UserInfo *userinfo;
    NSMutableArray *valueArray;
    NSMutableArray *classifyArray;
    
    UIScrollView *mScrollView;
}

@end

@implementation RTSelectClassifyViewController

@synthesize selectedString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithRed:236/255.0 green:242/255.0 blue:246/255.0 alpha:1.0]];
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    [self getTrendsClassify];
    
    UIButton *cancelButton =[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 22, 40, 40);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
                             
}

- (void)getTrendsClassify
{
    valueArray = [[NSMutableArray alloc] init];
    classifyArray = [[NSMutableArray alloc] init];
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
            
            for(int i = 0; i <= classifyArray.count; i++){
                UIView *classifyView = [[UIView alloc] initWithFrame:CGRectMake(i%2*SCREEN_WIDTH/2+ 5 * ((i+1)%2 + 1), 20 + i/2*40, 145, 30)];
                classifyView.layer.masksToBounds = YES;
                classifyView.layer.cornerRadius = 15;
                UILabel *classifyLabel = [[UILabel alloc] initWithFrame:classifyView.frame];
                classifyLabel.textColor = [UIColor whiteColor];
                classifyLabel.font = [UIFont systemFontOfSize:15];
                classifyView.tag = i;
                if (classifyView.tag == 0) {
                    classifyLabel.text = @"所有话题";
                }
                else{
                    classifyLabel.text = [classifyArray objectAtIndex:i - 1];
                }
                if ([selectedString isEqualToString:classifyLabel.text]) {
                    classifyView.backgroundColor = [UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0];
                }
                else{
                    classifyView.backgroundColor = [UIColor colorWithRed:58/255.0 green:147/255.0 blue:209/255.0 alpha:1.0];
                }
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
    if (view.tag == 0) {
        [self.delegate clickClassify:@"所有话题"];
    }
    else{
        [self.delegate clickClassify:[classifyArray objectAtIndex:view.tag - 1]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)cancelButtonClick{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
