//
//  RTChoosePositionViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/12/16.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTChoosePositionViewController.h"

@interface RTChoosePositionViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    UILabel *addressLabel;
}

@end

@implementation RTChoosePositionViewController
@synthesize addressTableView, addressTextField, submitButton, deleteAddressButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"我在这里";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, NAVIGATIONBAR_HEIGHT + 5, SCREEN_WIDTH - 70, 30)];
    addressTextField.placeholder = @"我的位置";
    addressTextField.borderStyle = UITextBorderStyleRoundedRect;
    addressTextField.delegate = self;
    addressTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:addressTextField];
    [addressTextField becomeFirstResponder];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(SCREEN_WIDTH - 50, NAVIGATIONBAR_HEIGHT + 5, 40, 30);
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor colorWithRed:35/255.0 green:160/255.0 blue:57/255.0 alpha:1.0] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    deleteAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteAddressButton.frame = CGRectMake(SCREEN_WIDTH - 80, 22, 80, 40);
    [deleteAddressButton setTitle:@"删除位置" forState:UIControlStateNormal];
    [deleteAddressButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    deleteAddressButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [deleteAddressButton addTarget:self action:@selector(deleteAddressClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteAddressButton];
    
    addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT + 35, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - 35) style:UITableViewStylePlain];
    addressTableView.delegate = self;
    addressTableView.dataSource = self;
    
    [self.view addSubview:addressTableView];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [addressTextField resignFirstResponder];
    return NO;
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitClick
{
    if ([RTUtil isBlankString:addressTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先输入自己的位置哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else{
        self.addressString = addressTextField.text;
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate clickSubmit];
    }
}

- (void)deleteAddressClick
{
    self.addressString = nil;
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate clickDeleteAddress];
}

#pragma mark - UITableView Delegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH - 24, 40)];
    addressLabel.font = SMALLFONT_12;
    addressLabel.text = self.addressString;
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.lineBreakMode = NSLineBreakByCharWrapping;
    addressLabel.numberOfLines = 2;
    [cell.contentView addSubview:addressLabel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.addressString = addressLabel.text;
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate clickTableViewCell];
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
