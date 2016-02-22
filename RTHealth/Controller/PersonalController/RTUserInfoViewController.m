//
//  RTUserInfoViewController.m
//  RTHealth
//
//  Created by cheng on 14/10/23.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTUserInfoViewController.h"
#import "RMDateSelectionViewController.h"
#import "RTWirteIntrduceViewController.h"
#import "RTPersonalRequest.h"
#import "RTProjectSelectViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "RTWeightRecordViewController.h"


@interface RTUserInfoViewController ()<RMDateSelectionViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSArray *titleData;
    UIImageView *imageView;
    UIImagePickerController *imagePicker;
}

@end

@implementation RTUserInfoViewController

@synthesize userinfo = _userinfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    _userinfo = userData.userData;
    
    titleData = [NSArray arrayWithObjects:@"头像",@"昵称",@"性别",@"生日",@"身高(cm)",@"体重(kg)",@"喜欢的运动",@"个性签名", nil];
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"个人";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setFrame:CGRectMake(SCREEN_WIDTH-62, 24, 52, 32)];
    [saveBtn setImage:[UIImage imageNamed:@"savebtn.png"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, NAVIGATIONBAR_HEIGHT+10, SCREEN_WIDTH-20, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-20)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.layer.borderWidth=1.0;
    tableview.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    tableview.layer.cornerRadius = 5;
    tableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableview];
    
    
    self.activity = [[UIActivityIndicatorView alloc]init];
    self.activity.backgroundColor = [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:0.5];
    self.activity.hidesWhenStopped = YES;
    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
}

- (void)viewDidAppear:(BOOL)animated{
    [tableview reloadData];
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveClick
{
    NSLog(@"save");
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:_userinfo.userid forKey:@"userid"];
    [dic setObject:_userinfo.usertoken forKey:@"usertoken"];
    if ([RTUtil isEmpty:_userinfo.usernickname]) {
        [dic setObject:@"" forKey:@"usernickname"];
    }else{
        [dic setObject:_userinfo.usernickname forKey:@"usernickname"];
    }
    if ([RTUtil isEmpty:_userinfo.userintroduce]) {
        [dic setObject:@"" forKey:@"userintroduce"];
    }else{
        [dic setObject:_userinfo.userintroduce forKey:@"userintroduce"];
    }
    
    if ([RTUtil isEmpty:_userinfo.userweightpublic]) {
        [dic setObject:@"1" forKey:@"userweightpublic"];
    }else{
        [dic setObject:_userinfo.userweightpublic forKey:@"userweightpublic"];
    }
    if ([RTUtil isEmpty:_userinfo.userweight]) {
        [dic setObject:@"0" forKey:@"userweight"];
    }else{
        [dic setObject:_userinfo.userweight forKey:@"userweight"];
    }
    if ([RTUtil isEmpty:_userinfo.userheightpublic]) {
        [dic setObject:@"1" forKey:@"userheightpublic"];
    }else{
        [dic setObject:_userinfo.userheightpublic forKey:@"userheightpublic"];
    }
    if ([RTUtil isEmpty:_userinfo.userheight]) {
        [dic setObject:@"0" forKey:@"userheight"];
    }else{
        [dic setObject:_userinfo.userheight forKey:@"userheight"];
    }
    if ([RTUtil isEmpty:_userinfo.userbirthday]) {
        [dic setObject:[CustomDate getBirthDayString:[NSDate date]] forKey:@"userbirthday"];
    }else{
        [dic setObject:_userinfo.userbirthday forKey:@"userbirthday"];
    }
    if ([RTUtil isEmpty:_userinfo.usersex]) {
        [dic setObject:@"1" forKey:@"userheadportrait"];
    }else{
        [dic setObject:_userinfo.usersex forKey:@"usersex"];
    }
    if ([RTUtil isEmpty:_userinfo.userphoto]) {
        [dic setObject:@"" forKey:@"userheadportrait"];
    }else{
        [dic setObject:_userinfo.userphoto forKey:@"userheadportrait"];
    }
    if ([RTUtil isEmpty:_userinfo.userfavoritesports]) {
        [dic setObject:@"" forKey:@"userfavoritesports"];
    }else{
        [dic setObject:_userinfo.userfavoritesports forKey:@"userfavoritesports"];
    }

    [RTPersonalRequest modifyUserInfoWith:dic success:^(id response){
    
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error){}];
}
- (void)datePicker
{
    [RMDateSelectionViewController setLocalizedTitleForCancelButton:@"取消"];
    [RMDateSelectionViewController setLocalizedTitleForSelectButton:@"确定"];
    [RMDateSelectionViewController setLocalizedTitleForNowButton:@"现在"];
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    dateSelectionVC.titleLabel.text = @"";
    dateSelectionVC.hideNowButton = YES;

    //You can enable or disable blur, bouncing and motion effects
    dateSelectionVC.disableBouncingWhenShowing = NO;
    dateSelectionVC.disableMotionEffects = NO;
    dateSelectionVC.disableBlurEffects = YES;
    
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.minuteInterval = 5;
    dateSelectionVC.datePicker.date = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    
   
    //The example project is universal. So we first need to check whether we run on an iPhone or an iPad.
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [dateSelectionVC show];
    } else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [dateSelectionVC showFromRect:self.view.frame inView:self.view];
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark RMDateSelection delegate
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    NSLog(@"Successfully selected date: %@", aDate);
    _userinfo.userbirthday = [CustomDate getBirthDayString:aDate];
    [tableview reloadData];
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"Date selection was canceled");
}

#pragma  mark uitableview delegate


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    NSInteger j = indexPath.row;
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    cell.textLabel.text = [titleData objectAtIndex:j];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = VERDANA_FONT_14;
    switch (j) {
        case 0:{
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width - 70 , 4, 40, 40)];
            [imageView setOnlineImage:[RTUtil urlZoomPhoto:self.userinfo.userphoto]];
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 40/2;
            imageView.layer.borderWidth = 1;
            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            [cell.contentView addSubview:imageView];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(cell.frame.size.width - 70 , 4, 40, 40);
            [cell.contentView addSubview:btn];
            
            self.activity.frame = CGRectMake(cell.frame.size.width - 70 , 8, 40, 40);
            self.activity.center = CGPointMake(cell.frame.size.width-100, 49/2);
            self.activity.backgroundColor = [UIColor clearColor];
            if ([self.activity isAnimating]) {
                [self.activity startAnimating];
            }
            [cell.contentView addSubview:self.activity];
            
            }break;
        case 1:{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 170, 4, 140, 40)];
            label.text = _userinfo.usernickname;
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:label];
        }break;
        case 2:{
            UIImageView *seximageview = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width - 60, 13, 19, 23)];
            if ([self.userinfo.usersex integerValue]==1) {
                seximageview.image = [UIImage imageNamed:@"sex_boy_image.png"];
            }else{
                seximageview.image = [UIImage imageNamed:@"sex_girl_image.png"];
            }
            [cell.contentView addSubview:seximageview];
        }break;
        case 3:{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 170, 4, 140, 40)];
            label.text = _userinfo.userbirthday;
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:label];
        }break;
        case 4:{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 170, 4, 140, 40)];
            label.text = _userinfo.userheight;
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:label];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(80, 11, 22, 22);
            [button addTarget:self action:@selector(clickHeightPublic:) forControlEvents:UIControlEventTouchUpInside];
            if (_userinfo.userheightpublic.intValue== 1) {
                [button setBackgroundImage:[UIImage imageNamed:@"ispublic.png"] forState:UIControlStateNormal];
            }else{
                [button setBackgroundImage:[UIImage imageNamed:@"notpublic.png"] forState:UIControlStateNormal];
            }
            [cell.contentView addSubview:button];
        }break;
        case 5:{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 170, 4, 140, 40)];
            label.text = _userinfo.userweight;
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:label];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(80, 11, 22, 22);
            [button addTarget:self action:@selector(clickweightPublic:) forControlEvents:UIControlEventTouchUpInside];
            if (_userinfo.userweightpublic.intValue== 1) {
                [button setBackgroundImage:[UIImage imageNamed:@"ispublic.png"] forState:UIControlStateNormal];
            }else{
                [button setBackgroundImage:[UIImage imageNamed:@"notpublic.png"] forState:UIControlStateNormal];
            }
            [cell.contentView addSubview:button];
        }break;
        case 6:{
            if (![RTUtil isEmpty:_userinfo.userfavoritesports]) {
               
                NSArray *favorite = [_userinfo.userfavoritesports componentsSeparatedByString:@":"];
                float x = cell.frame.size.width - 60,y = 10;
                int i = 0;
                if (favorite.count>4) {
                    
                    float x1 = x-(i%5)*35;
                    float y1 = y+ (i/5)*40;
                    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(x1, y1+6, 30, 18)];
                    imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"moresports.png"]];
                    [cell.contentView addSubview:imageview];
                    i++;
                }
                for (; i < favorite.count && i< 5; i ++ ) {
                    NSString *sport = [favorite objectAtIndex:i];
                    float x1 = x-(i%5)*35;
                    float y1 = y+ (i/5)*40;
                    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(x1, y1, 30, 30)];
                    imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"sports%02d.png",[sport intValue]]];
                    [cell.contentView addSubview:imageview];
                }
            }
        }break;
        case 7:{
            CGSize framesize = [_userinfo.userintroduce sizeWithFont:VERDANA_FONT_14
                                                   constrainedToSize:CGSizeMake(210.0, MAXFLOAT)
                                                       lineBreakMode:NSLineBreakByCharWrapping];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 240, 16, 210, framesize.height)];
            label.text = _userinfo.userintroduce;
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor darkGrayColor];
            label.font = VERDANA_FONT_14;
            label.numberOfLines = 0;
            [cell.contentView addSubview:label];
        }break;
        default:
        break;
    }
    return cell;
}

- (void)clickHeightPublic:(UIButton*)btn{
    if ([_userinfo.userheightpublic intValue]==1 ) {
        _userinfo.userheightpublic = [NSNumber numberWithInt:0];
        [btn setBackgroundImage:[UIImage imageNamed:@"notpublic.png"] forState:UIControlStateNormal];
    }else{
        _userinfo.userheightpublic = [NSNumber numberWithInt:1];
        [btn setBackgroundImage:[UIImage imageNamed:@"ispublic.png"] forState:UIControlStateNormal];
    }
}
- (void)clickweightPublic:(UIButton*)btn{
    if ([_userinfo.userweightpublic intValue]==1 ) {
        _userinfo.userweightpublic = [NSNumber numberWithInt:0];
        [btn setBackgroundImage:[UIImage imageNamed:@"notpublic.png"] forState:UIControlStateNormal];
    }else{
        _userinfo.userweightpublic = [NSNumber numberWithInt:1];
        [btn setBackgroundImage:[UIImage imageNamed:@"ispublic.png"] forState:UIControlStateNormal];
    }
}
- (void)clickbtn:(UIButton*)btn
{
//    [self amplificationWithImage:imageView];
    MJPhoto *photo = [[MJPhoto alloc]init];
    [photo setUrl:[NSURL URLWithString:[RTUtil urlPhoto:self.userinfo.userphoto]]];
    photo.srcImageView = imageView;
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    browser.photos = [[NSMutableArray alloc]initWithObjects:photo, nil];
    browser.currentPhotoIndex = 0;
    [browser show];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        [self datePicker];
    }else if(indexPath.row ==1){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = indexPath.row;
        UITextField *textfield = [alert textFieldAtIndex:0];
        textfield.placeholder = @"请输入";
        [alert show];
    }
    else if(indexPath.row == 4){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = indexPath.row;
        UITextField *textfield = [alert textFieldAtIndex:0];
        textfield.placeholder = @"请输入";
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        [alert show];
    }else if (indexPath.row == 5){
        RTWeightRecordViewController *weightController = [[RTWeightRecordViewController alloc]init];
        [self.navigationController pushViewController:weightController animated:YES];
    }
    else if(indexPath.row == 2){
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        actionSheet.tag = 11;
        [actionSheet showInView:self.view];
    }else if (indexPath.row == 0){
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"更改图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"从相册选择", nil];
        actionSheet.tag = 10;
        [actionSheet showInView:self.view];
    }else if (indexPath.row == 6){
        NSMutableArray *favorite = [[NSMutableArray alloc]initWithArray:[_userinfo.userfavoritesports componentsSeparatedByString:@":"]];
        
        RTProjectSelectViewController *selectController = [[RTProjectSelectViewController alloc]init];
        selectController.selectarray = favorite;
        [selectController returnArray:^(NSMutableArray *array) {
            NSString *string = [[NSString alloc]init];
            for (int i = 0; i < array.count ; i ++ ) {
                NSNumber *number = [array objectAtIndex:i];
                if (i == 0) {
                    string = [NSString stringWithFormat:@"%02d",[number intValue]];
                }else{
                    string = [NSString stringWithFormat:@"%@:%02d",string,[number intValue]];
                }
            }if (array.count == 0) {
                _userinfo.userfavoritesports = nil;
            }else{
            _userinfo.userfavoritesports = string;
            }
            [tableView reloadData];
        }];
        
        [self.navigationController pushViewController:selectController animated:YES];
    }else if (indexPath.row == 7){
        RTWirteIntrduceViewController *writeIntrduceController = [[RTWirteIntrduceViewController alloc]init];
        writeIntrduceController.content = _userinfo.userintroduce;
        [writeIntrduceController returnText:^(NSString *showText) {
            _userinfo.userintroduce = showText;
            [tableView reloadData];
        }];
        [self.navigationController pushViewController:writeIntrduceController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        return 49;
    }else if (indexPath.row == 7){
        CGSize framesize = [_userinfo.userintroduce sizeWithFont:VERDANA_FONT_14
                           constrainedToSize:CGSizeMake(210.0, MAXFLOAT)
                               lineBreakMode:NSLineBreakByCharWrapping];
        if (framesize.height <18){
            return 49;
        }
        return 32+framesize.height;
        
    }
    return 49;
}

#pragma  mark UIAlertView Delegate


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        
        switch (alertView.tag) {
            case 1:{
                _userinfo.usernickname = textfield.text;
            }break;
            case 4:{
                _userinfo.userheight = textfield.text;
            }break;
            case 5:{
                _userinfo.userweight = textfield.text;
            }break;
                
            default:
                break;
        }
    }
    [tableview reloadData];
}

#pragma mark UIActionSheet Delegate


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 10:{
            if (buttonIndex == 0) {//拍照上传
                imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                imagePicker.allowsEditing = YES;
                [self presentModalViewController:imagePicker animated:YES];
            }else if(buttonIndex == 1) {//从相册选择
                imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                imagePicker.allowsEditing = YES;
                [self presentModalViewController:imagePicker animated:YES];
            }
        }break;
        case 11:{
            if (buttonIndex == 0) {
                _userinfo.usersex = @"1";
            }else if(buttonIndex == 1) {
                _userinfo.usersex = @"2";
            }
            [tableview reloadData];
        }break;
        default:
            break;
    }
}

#pragma  mark  UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    imageView.image = image;
    NSLog(@"image picker");
    [picker dismissModalViewControllerAnimated:YES];
    [self.activity startAnimating];
//    [RTPersonalRequest uploadImage:image success:^(id response){
//        [self.activity stopAnimating];}failure:^(NSError *error){
//            [self.activity stopAnimating];}];
    [RTUploadImageNetWork postMulti:nil imageparams:image success:^(id response){
        NSLog(@"response %@",response);
        if ([response objectForKey:@"key"]) {
            _userinfo.userphoto = [response objectForKey:@"key"];
            [tableview reloadData];
        }
        [self.activity stopAnimating];
    } failure:^(NSError *error){
        
        [self.activity stopAnimating];
    } Progress:^(NSString *key,float percent){
        NSLog(@"percent %f",percent);
    } Cancel:^BOOL () {
        return NO;
    }];
    
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _userinfo.userintroduce = textView.text;
}

@end
