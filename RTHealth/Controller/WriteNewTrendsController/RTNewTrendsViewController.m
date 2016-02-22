//
//  RTNewTrendsViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/10/28.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTNewTrendsViewController.h"
#import "RTSelectProjectViewController.h"
#import "ShowBigViewController.h"
#import "MessagePhotoMenuItem.h"
#import "RTUploadImageNetWork.h"
#import "RTTrendsClassifyViewController.h"
#import "RTTrendsRequest.h"
#import "JDStatusBarNotification.h"
#import "RTChoosePositionViewController.h"


@interface RTNewTrendsViewController ()<UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZYQAssetPickerControllerDelegate, MessagePhotoItemDelegate, CLLocationManagerDelegate, MKMapViewDelegate, RTTrendsClassifyViewControllerDelegate, RTSelectProjectViewControllerDelegate, RTChoosePositionDelegate>
{
    RTTrendsClassifyViewController *trendsClassifyView;
    RTSelectProjectViewController *selectprojectView;
    RTChoosePositionViewController *choosePositionView;
    UIView *clearView;
    UIButton *clearTrendClassifyButton;
    UILabel *tip;
//    BOOL isSynWeibo;
//    BOOL isSynQQZone;
//    BOOL isSynWeixin;
    BOOL isPublic;
    BOOL isTakePhoto;
    
    UIImage *tookImage;
    
    UIButton *choosePicButton;
    UIButton *chooseIsPublicButton;
    UIButton *chooseProjectTypeButton;
    UIButton *chooseTrendsTypeButton;
    
    float latitude;
    float longitude;
    
    NSMutableArray *trendsClassifyArray;
    NSMutableArray *valueArray;
    NSString *trendsClassifyString;
    NSString *projectTypeString;
    NSString *isPublicString;
    NSString *positionString;
    NSString *address;
    //NSString *addressString;
    
    //图片二进制路径
    NSString *filePath;
}
@property (nonatomic, strong) UIScrollView *photoScrollView;
@property (nonatomic, assign) UIActivityIndicatorViewStyle indicatorStyle;

@end

@implementation RTNewTrendsViewController
@synthesize textView = _textView;
@synthesize trendClassifyLabel = _trendClassifyLabel;
@synthesize synView = _synView;
@synthesize weiboSynImage = _weiboSynImage, qqZoneSynImage = _qqZoneSynImage, weixinSynImage = _weixinSynImage;
@synthesize toolView = _toolView;
@synthesize topImageView;
@synthesize submitButton;

@synthesize photoMenuItems, itemArray;

@synthesize userinfo = _userinfo;
@synthesize locationManager;
@synthesize geocoder;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    _userinfo = userData.userData;
   // NSLog(@"%@", _userinfo.userid);
    isTakePhoto = NO;
    trendsClassifyArray = [[NSMutableArray alloc] init];
    trendsClassifyString = @"";
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"发动态";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    self.submitButton.enabled = NO;
    
    //输入框
    [self setupTextView];
    
    //图片区域
    [self setupPhotoView];
    
    //同步到微博、qq
    [self setupSynView];
    
    //工具
    [self setupToolView];
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f){
            [locationManager requestAlwaysAuthorization];
        }
        locationManager.distanceFilter = 1000.0f;
        [locationManager startUpdatingLocation];
        
    }
    else{
        NSLog(@"请开启定位功能");
    }
    //监听键盘
    //键盘的frame改变，就会发出UIKeyboardWilChangeFrameNotification通知
    //键盘弹出，就会发出UIKeyboardDidShownNotification通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    //键盘即将隐藏,就会发出UIKeyboardDidHidenNotification通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWasHiden:) name:UIKeyboardDidHideNotification object:nil];
   
}

-(void)setupTextView
{
    //话题类型Label
    _trendClassifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH - 50, 30)];
    _trendClassifyLabel.text = @"##";
    _trendClassifyLabel.font = SMALLFONT_12;
    _trendClassifyLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.view addSubview:_trendClassifyLabel];
    
    clearView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, NAVIGATIONBAR_HEIGHT, 50, 30)];
    clearView.backgroundColor = _trendClassifyLabel.backgroundColor;
    [self.view addSubview:clearView];
    
    //清除动态类型按钮
    clearTrendClassifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearTrendClassifyButton.frame = CGRectMake(25, 4, 22, 22);
    clearTrendClassifyButton.hidden = YES;
    clearTrendClassifyButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clear.png"]];
    [clearTrendClassifyButton addTarget:self action:@selector(clearTrendClassifyClick) forControlEvents:UIControlEventTouchUpInside];
    [clearView addSubview:clearTrendClassifyButton];
    
    //输入控件
    _textView = [[UITextView alloc] init];
    //设置垂直方向拥有弹簧效果
    _textView.alwaysBounceVertical = YES;
    _textView.delegate = self;
    _textView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT + 30, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - 100);
    _textView.scrollEnabled = YES;
    _textView.font = SMALLFONT_14;
    _textView.showsVerticalScrollIndicator = NO;
    _textView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_textView];
    [_textView becomeFirstResponder];
    
    //提示输入label
    tip = [[UILabel alloc] initWithFrame:CGRectMake(6, NAVIGATIONBAR_HEIGHT+36, 200, 20)];
    tip.text = @"说点什么吧...(200字以内)";
    tip.font = SMALLFONT_14;
    tip.textColor = [UIColor lightGrayColor];
    [self.view addSubview:tip];

  
    
}

- (void)setupPhotoView
{
    self.photoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT + 100, SCREEN_WIDTH - 70, 80)];
   // self.photoScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 80);
    photoMenuItems = [[NSMutableArray alloc] init];
    itemArray = [[NSMutableArray alloc] init];
    [self.view addSubview:self.photoScrollView];
    
    [self initlizerScrollView:photoMenuItems];
    
    //项目类型
    self.projectTypeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, NAVIGATIONBAR_HEIGHT + 107, 50, 50)];
    [self.view addSubview:self.projectTypeImageView];
    
    
}

- (void)reloadDataWithImage:(UIImage *)image
{
    [photoMenuItems addObject:image];
    
    [self initlizerScrollView:photoMenuItems];
}
- (void)initlizerScrollView:(NSArray *)imgList
{
    [self.photoScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.photoScrollView.contentSize = CGSizeMake(imgList.count *75 + 10, 80);
    for (int i = 0; i < imgList.count; i++) {
        ALAsset *asset = imgList[i];
        
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        MessagePhotoMenuItem *photoItem = [[MessagePhotoMenuItem alloc] initWithFrame:CGRectMake(5 + i * 75, 5, 70, 70)];
        photoItem.delegate = self;
        photoItem.index = i;
        photoItem.contentImage = tempImg;
        [self.photoScrollView addSubview:photoItem];
        [itemArray addObject:photoItem];
    }
}

- (void)setupSynView
{
//    _synView = [[UIView alloc] init];
//    _synView.frame = CGRectMake(10, SCREEN_HEIGHT - 80, 205, 32);
//    _synView.backgroundColor =[UIColor colorWithWhite:0.9 alpha:1];
//    _synView.layer.masksToBounds = YES;
//    _synView.layer.cornerRadius = 16;
//    [self.view addSubview:_synView];
//    
//    UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share.png"]];
//    im.frame = CGRectMake(10, 5, 22, 22);
//    [_synView addSubview:im];
//    
//    UILabel *synLabel = [[UILabel alloc ] initWithFrame:CGRectMake(35, 5, 50, 22)];
//    synLabel.text= @"同步至";
//    synLabel.font = SMALLFONT_14;
//    [_synView addSubview:synLabel];
//    
//    //三个同步imageview
//    _weiboSynImage = [[UIImageView alloc] initWithFrame:CGRectMake(95, 5, 22, 22)];
//    _weiboSynImage.image = [UIImage imageNamed:@"weibo.png"];
//    [_synView addSubview:_weiboSynImage];
//    
//    _qqZoneSynImage = [[UIImageView alloc] initWithFrame:CGRectMake(127, 5, 22, 22)];
//    _qqZoneSynImage.image = [UIImage imageNamed:@"qqzone.png"];
//    [_synView addSubview:_qqZoneSynImage];
//    
//    _weixinSynImage = [[UIImageView alloc] initWithFrame:CGRectMake(157, 5, 22, 22)];
//    _weixinSynImage.image = [UIImage imageNamed:@"weixin.png"];
//    [_synView addSubview:_weixinSynImage];
//    
//    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectSyn:)];
//    [_synView addGestureRecognizer:tap];
//    _synView.userInteractionEnabled = YES;
//    
//    isSynWeibo = NO;
//    isSynQQZone = NO;
//    isSynWeixin = NO;
    
    //位置信息
    self.positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, SCREEN_HEIGHT - 80, SCREEN_WIDTH - 40, 32)];
    self.positionLabel.font = SMALLFONT_12;
    self.positionLabel.text = @"";
    self.positionLabel.textAlignment = NSTextAlignmentLeft;
    self.positionImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 80, 32, 32)];
    self.positionImage.image = [UIImage imageNamed:@"position_add.png"];
    self.choosePositionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.choosePositionButton.frame = self.positionLabel.frame;
    [self.choosePositionButton addTarget:self action:@selector(choosePositionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.positionLabel];
    [self.view addSubview:self.positionImage];
    [self.view addSubview:self.choosePositionButton];
    //self.positionImage.hidden = YES;
    //self.choosePositionButton.hidden = YES;
}

//选择位置
- (void)choosePositionButtonClick
{
    NSLog(@"点击了位置");
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication] delegate];
    choosePositionView = [[RTChoosePositionViewController alloc]init];
    choosePositionView.delegate = self;
    choosePositionView.addressString = address;
    [appDelegate.rootNavigationController pushViewController:choosePositionView animated:YES];
    
}
#pragma mark - RTChoosePositionDelegate
- (void)clickSubmit
{
    self.positionLabel.text = choosePositionView.addressString;
}

- (void)clickDeleteAddress
{
    self.positionLabel.text = @"插入位置";
    
}
- (void)clickTableViewCell
{
    self.positionLabel.text = choosePositionView.addressString;
}

#pragma mark - locationManager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations objectAtIndex:0];
    
    latitude = location.coordinate.latitude;
    longitude = location.coordinate.longitude;
    
    //positionString = [NSString stringWithFormat:@"%.2f;%.2f",latitude,longitude];
    geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks objectAtIndex:0];
        
        address = [NSString stringWithFormat:@"%@", mark.name];
        if ([address isEqualToString:@"(null)"]) {
            address = @"";
        }
        self.positionLabel.text = address;
    }];
}

- (void)setupToolView
{
    _toolView = [[UIView alloc] init];
    _toolView.frame = CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45);
    [_toolView setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.view addSubview:_toolView];
    
    //四个工具按钮
    choosePicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    choosePicButton.frame = CGRectMake(SCREEN_WIDTH/8-15, 7, 30, 30);
    choosePicButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"photo.png"]];
    [choosePicButton addTarget:self action:@selector(choosePicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:choosePicButton];
    

    chooseTrendsTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseTrendsTypeButton.frame = CGRectMake(SCREEN_WIDTH/4 + (SCREEN_WIDTH/8 - 15), 7, 30, 30);
    chooseTrendsTypeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trends_classify.png"]];
    [chooseTrendsTypeButton addTarget:self action:@selector(chooseTrendsTypeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:chooseTrendsTypeButton];
    
    chooseProjectTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseProjectTypeButton.frame = CGRectMake(SCREEN_WIDTH/2 + (SCREEN_WIDTH/8 - 15), 7, 30, 30);
    chooseProjectTypeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"project_type.png"]];
    [chooseProjectTypeButton addTarget:self action:@selector(chooseProjectTypeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:chooseProjectTypeButton];
    
    chooseIsPublicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseIsPublicButton.frame = CGRectMake(3*SCREEN_WIDTH/4 + (SCREEN_WIDTH/8 - 15), 7, 30, 30);
    chooseIsPublicButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"is_public.png"]];
    [chooseIsPublicButton addTarget:self action:@selector(chooseIsPublicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:chooseIsPublicButton];
    isPublic = YES;
    
}

- (void)clearTrendClassifyClick
{
    _trendClassifyLabel.text = @"##";
    trendsClassifyString = @"";
    [trendsClassifyArray removeAllObjects];
}



#pragma mark - textView
-(void)textViewDidChange:(UITextView *)textView
{
    //提示label消失
    [tip removeFromSuperview];
    
    //发送按钮
    submitButton.enabled = YES;
    
    [submitButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    //输入框高度
    float textViewHeight = 100;
    //文字内容
    CGSize textSize = [_textView.text sizeWithFont:SMALLFONT_14 constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    if (textSize.height > SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - 100) {
        textViewHeight = textSize.height + 5;
        _textView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT + 30, SCREEN_WIDTH, textViewHeight);
        //_textView.contentSize = CGSizeMake(SCREEN_WIDTH, textViewHeight);
        _textView.contentInset = UIEdgeInsetsMake(0, 0, textViewHeight - SCREEN_HEIGHT + NAVIGATIONBAR_HEIGHT + 100, 0);
    }
    else{
        _textView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT + 30, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - 100);
    }
    
    if (textSize.height > 90) {
        self.photoScrollView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT + 30 +textViewHeight + 20, SCREEN_WIDTH - 70, 80);
        self.projectTypeImageView.frame = CGRectMake(SCREEN_WIDTH - 60, NAVIGATIONBAR_HEIGHT + 57 +textViewHeight, 50, 50);
    }
    else{
        self.photoScrollView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT + 100, SCREEN_WIDTH - 70, 80);
        self.projectTypeImageView.frame = CGRectMake(SCREEN_WIDTH - 60, NAVIGATIONBAR_HEIGHT + 107, 50, 50);
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES) {
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}


#pragma mark - 键盘处理
/**
 键盘弹出
 */
- (void)KeyboardWasShown:(NSNotification*)note
{
    //得到键盘高度
    NSDictionary *info = [note userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"%.f", keyboardSize.height);
    _synView.frame = CGRectMake(10, SCREEN_HEIGHT - keyboardSize.height - 80, 200, 30);
    _toolView.frame = CGRectMake(0, SCREEN_HEIGHT - keyboardSize.height - 45, SCREEN_WIDTH, 45);
    self.positionLabel.frame = CGRectMake(35, SCREEN_HEIGHT -  keyboardSize.height - 80, SCREEN_WIDTH - 40, 30);
    self.positionImage.frame = CGRectMake(0, SCREEN_HEIGHT - keyboardSize.height - 80, 32, 32);
    self.choosePositionButton.frame = self.positionLabel.frame;
    self.photoScrollView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT + 100, SCREEN_WIDTH - 70, 80);
    self.projectTypeImageView.frame =CGRectMake(SCREEN_WIDTH - 60, NAVIGATIONBAR_HEIGHT + 107, 50, 50);
}
/**
 键盘隐藏
 */
- (void)KeyboardWasHiden:(NSNotification *)note
{
    _synView.frame = CGRectMake(10, SCREEN_HEIGHT - 80, 200, 30);
    _toolView.frame = CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45);
    self.positionLabel.frame = CGRectMake(35, SCREEN_HEIGHT - 80, SCREEN_WIDTH - 40, 30);
    self.positionImage.frame = CGRectMake(0, SCREEN_HEIGHT - 80, 32, 32);
    self.choosePositionButton.frame = self.positionLabel.frame;
    self.photoScrollView.frame = CGRectMake(0, SCREEN_HEIGHT - 160, SCREEN_WIDTH - 70, 80);
    self.projectTypeImageView.frame =CGRectMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT - 153, 50, 50);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)selectSyn:(UITapGestureRecognizer*)gesture
//{
//    CGPoint point = [gesture locationInView:_synView];
//    if (CGRectContainsPoint(_weiboSynImage.frame, point)) {
//        NSLog(@"同步到微博");
//        if (!isSynWeibo) {
//            _weiboSynImage.image = [UIImage imageNamed:@"weibo_share.png"];
//            isSynWeibo = YES;
//        }
//        else{
//            _weiboSynImage.image = [UIImage imageNamed:@"weibo.png"];
//            isSynWeibo = NO;
//        }
//    }
//    else if (CGRectContainsPoint(_qqZoneSynImage.frame, point)){
//        NSLog(@"同步到qq空间");
//        if (!isSynQQZone) {
//            _qqZoneSynImage.image = [UIImage imageNamed:@"qqzone_share.png"];
//            isSynQQZone = YES;
//        }
//        else{
//            _qqZoneSynImage.image = [UIImage imageNamed:@"qqzone.png"];
//            isSynQQZone = NO;
//        }
//    }
//    else if (CGRectContainsPoint(_weixinSynImage.frame, point)){
//        NSLog(@"同步到微信");
//        if (!isSynWeixin) {
//            _weixinSynImage.image = [UIImage imageNamed:@"weixin_share.png"];
//            isSynWeixin = YES;
//        }
//        else{
//            _weixinSynImage.image = [UIImage imageNamed:@"weixin.png"];
//            isSynWeixin = NO;
//        }
//    }
//    else{
//        
//    }
//}

- (void)choosePicButtonClick
{
    photoActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"从相册选择", nil];
    [photoActionSheet showInView:self.view];
}

- (void)chooseTrendsTypeButtonClick
{
    
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    trendsClassifyView = [[RTTrendsClassifyViewController alloc] init];
    trendsClassifyView.classifyMutableArray = [[NSMutableArray alloc] init];
    trendsClassifyView.classifyMutableArray = trendsClassifyArray;
    trendsClassifyView.delegate = self;
    [appDelegate.rootNavigationController pushViewController:trendsClassifyView animated:YES];
}

#pragma mark - RTTrendsClssifyViewController Delegate
- (void)clickCancelOrSubmitButton:editString
{
    //if (![self isBlankString:trendsClassifyView.trendsTextfield.text] ) {
    BOOL is = NO;
    for(int i = 0; i < trendsClassifyArray.count; i++){
        if ([editString isEqualToString:[trendsClassifyArray objectAtIndex:i]]) {
            is = YES;
        }
    }
    if (!is) {
        [trendsClassifyArray addObject:editString];
        trendsClassifyString = @"";
        for (int i = 0; i < trendsClassifyArray.count; i++) {
            trendsClassifyString = [trendsClassifyString stringByAppendingString:@"#"];
            trendsClassifyString = [trendsClassifyString stringByAppendingString: [trendsClassifyArray objectAtIndex:i]];
            trendsClassifyString = [trendsClassifyString stringByAppendingString:@"#"];
        }
    }
    chooseTrendsTypeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trends_classify_add.png"]];
    _trendClassifyLabel.text = trendsClassifyString;
    clearTrendClassifyButton.hidden = NO;
  //  }
}

- (void)clickClassify:(NSString *)classify
{
    BOOL is = NO;
    for(int i = 0; i < trendsClassifyArray.count; i++){
        if ([classify isEqualToString:[trendsClassifyArray objectAtIndex:i]]) {
            is = YES;
        }
    }
    if (!is) {
        trendsClassifyString = @"";
        [trendsClassifyArray addObject:classify];
        for (int i = 0; i < trendsClassifyArray.count; i++) {
            trendsClassifyString = [trendsClassifyString stringByAppendingString:@"#"];
            trendsClassifyString = [trendsClassifyString stringByAppendingString: [trendsClassifyArray objectAtIndex:i]];
            trendsClassifyString = [trendsClassifyString stringByAppendingString:@"#"];
        }
    }
    chooseTrendsTypeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trends_classify_add.png"]];
    _trendClassifyLabel.text = trendsClassifyString;
    clearTrendClassifyButton.hidden = NO;

}

- (void)chooseProjectTypeButtonClick
{
    RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
    selectprojectView = [[RTSelectProjectViewController alloc] init];
    selectprojectView.delegate = self;
    [appDelegate.rootNavigationController pushViewController:selectprojectView animated:YES];
}

#pragma mark - RTSelectProjectViewController Delegate
- (void)clickProjectView
{
    projectTypeString = selectprojectView.projectSelectedString;
    NSLog(@"%@",projectTypeString);
    chooseProjectTypeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"project_type_add.png"]];
    [self.projectTypeImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sports%@", projectTypeString]]];
}

- (void)chooseIsPublicButtonClick
{
    if (isPublic){
        isPublicString = @"N";
        chooseIsPublicButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"not_public.png"]];
        isPublic = NO;
    }
    else{
        isPublicString = @"Y";
        chooseIsPublicButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"is_public.png"]];
        isPublic = YES;
    }
}

//下拉菜单点击响应事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
            
         case 1:
            [self localPhoto];
            
        default:
            break;
    }
}

//开始拍照
- (void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
        
        
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}
//从相册选择照片
- (void)localPhoto
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    
    picker.maximumNumberOfSelection = 9;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
            return duration>= 5;
        }
        else{
            return YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissModalViewControllerAnimated:YES];
    isTakePhoto = YES;
    tookImage = image;
    [photoMenuItems removeAllObjects];
    MessagePhotoMenuItem *photoItem = [[MessagePhotoMenuItem alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
    photoItem.delegate = self;
    photoItem.index = 0;
    photoItem.contentImage = image;
    [self.photoScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.photoScrollView addSubview:photoItem];
    [photoMenuItems addObject:photoItem];
    submitButton.enabled = YES;
    [submitButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    if (photoMenuItems.count != 0) {
        choosePicButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"photo_add.png"]];
    }
}

#pragma mark - ZYQAssetPickerController Delegate
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    isTakePhoto = NO;
    ShowBigViewController *bigImageView = [[ShowBigViewController alloc] init];
    bigImageView.arrayOK = [NSMutableArray arrayWithArray:assets];
    photoMenuItems = [NSMutableArray arrayWithArray:assets];
    [self initlizerScrollView:photoMenuItems];
    [picker pushViewController:bigImageView animated:YES];
    
    submitButton.enabled = YES;
    [submitButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    if (photoMenuItems.count != 0) {
        choosePicButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"photo_add.png"]];
    }
}

#pragma mark - MessagePhotoItemDelegate
- (void)messagePhotoItemView:(MessagePhotoMenuItem *)messagePhotoItemView didSelectDeleteButtonAtIndex:(NSInteger)index
{
    [photoMenuItems removeObjectAtIndex:index];
    [self initlizerScrollView:photoMenuItems];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)submitButtonClick:(id)sender {
    [_textView resignFirstResponder];
    
    if ([RTUtil isBlankString:_textView.text] && photoMenuItems.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"先说点什么哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        if ([_textView.text length] > 200) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字数别超过200个哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
            if (![JDStatusBarNotification isVisible]) {
                self.indicatorStyle = UIActivityIndicatorViewStyleGray;
                [JDStatusBarNotification showWithStatus:@"正在发送..."];
            }
            [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:self.indicatorStyle];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:_userinfo.userid forKey:@"userid"];
            [dic setObject:_userinfo.usertoken forKey:@"usertoken"];
            if(![self isBlankString:trendsClassifyString]){
                [dic setObject:trendsClassifyString forKey:@"trendclassify"];
            }
            if(![self isBlankString:_textView.text]){
                [dic setObject:_textView.text forKey:@"trendcontent"];
            }
            if (![self.positionLabel.text isEqualToString:@"插入位置"]) {
                if (![self isBlankString:self.positionLabel.text]) {
                    NSString *string = [NSString stringWithFormat:@"我在%@", self.positionLabel.text];
                    [dic setObject:string forKeyedSubscript:@"address"];
                }
            }
            if (![self isBlankString:projectTypeString]) {
                [dic setObject:projectTypeString forKey:@"trendtype"];
            }
            else{
                [dic setObject:@"01" forKey:@"trendtype"];
            }
            if (isPublic) {
                [dic setObject:@"N" forKey:@"ispublic"];
            }
            else{
                [dic setObject:@"Y" forKey:@"ispublic"];
            }
            NSLog(@"dic %@", dic);
            
            if(photoMenuItems.count != 0){
                __block int successNum = 0;
                __block NSString *photoString = @"";
                if (isTakePhoto) {
                    [RTUploadImageNetWork postMulti:nil imageparams:tookImage success:^(id response) {
                        NSLog(@"上传完成");
                        if(![RTUtil isEmpty:response]){
                            photoString = [photoString stringByAppendingString:[response objectForKey:@"key"]];
                            [dic setObject:photoString forKey:@"trendphoto"];
                        }
                        [RTTrendsRequest writeTrendsWith:dic success:^(id response) {
                            if ([[response objectForKey:@"state"] intValue] == 1000) {
                                [JDStatusBarNotification showWithStatus:@"发送成功√" dismissAfter:1.4];
                                [[NSNotificationCenter defaultCenter] postNotificationName:SENDSUCCESS object:@YES];
                            }
                            else{
                                [JDStatusBarNotification showWithStatus:@"发送失败" dismissAfter:1.4];
                                NSLog(@"发送失败");
                            }
                        } failure:^(NSError *error) {
                            NSLog(@"发送失败");
                        }];
                    } failure:^(NSError *error) {
                        NSLog(@"上传失败");
                    } Progress:^(NSString *key, float percent) {
                        NSLog(@"percent %f", percent);
                    } Cancel:^BOOL{
                        return NO;
                    }];
                }
                else{
                    for (int i = 0; i <photoMenuItems.count; i++) {
                        ALAsset *asset = photoMenuItems[i];
                        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                        [RTUploadImageNetWork postMulti:nil imageparams:image success:^(id response) {
                            successNum ++;
                            if (![RTUtil isEmpty:response]){
                                if (successNum == photoMenuItems.count) {
                                    NSLog(@"上传完成");
                                    photoString = [photoString stringByAppendingString:[response objectForKey:@"key"]];
                                    [dic setObject:photoString forKey:@"trendphoto"];
                                    [RTTrendsRequest writeTrendsWith:dic success:^(id response) {
                                        if ([[response objectForKey:@"state"] intValue] == 1000) {
                                            [JDStatusBarNotification showWithStatus:@"发送成功√" dismissAfter:1.4];
                                            [[NSNotificationCenter defaultCenter] postNotificationName:SENDSUCCESS object:@YES];
                                        }
                                        else{
                                            [JDStatusBarNotification showWithStatus:@"发送失败" dismissAfter:1.4];
                                            NSLog(@"发送失败");
                                        }
                                    } failure:^(NSError *error) {
                                        NSLog(@"发送失败");
                                    }];
                                }
                                else{
                                    //NSLog(@"%@", [response objectForKey:@"key"]);
                                    photoString = [photoString stringByAppendingString:[response objectForKey:@"key"]];
                                    photoString = [photoString stringByAppendingString:@";"];
                                }
                            }
                            else{
                                if (i == photoMenuItems.count - 1) {
                                    [RTTrendsRequest writeTrendsWith:dic success:^(id response) {
                                        if ([[response objectForKey:@"state"] intValue] == 1000) {
                                            [JDStatusBarNotification showWithStatus:@"发送成功√" dismissAfter:1.4];
                                            [[NSNotificationCenter defaultCenter] postNotificationName:SENDSUCCESS object:@YES];
                                        }
                                        else{
                                            [JDStatusBarNotification showWithStatus:@"发送失败" dismissAfter:1.4];
                                            NSLog(@"发送失败");
                                        }
                                    } failure:^(NSError *error) {
                                        NSLog(@"发送失败");
                                    }];
                                }
                            }
                            
                        } failure:^(NSError *error) {
                            NSLog(@"第%d张失败", i + 1);
                        } Progress:^(NSString *key, float percent) {
                            NSLog(@"percent %f", percent);
                            
                        } Cancel:^BOOL{
                            return NO;
                        }];
                    }
                }
            }
            else{
                
                [RTTrendsRequest writeTrendsWith:dic success:^(id response) {
                    if ([[response objectForKey:@"state"] intValue] == 1000) {
                        [JDStatusBarNotification showWithStatus:@"发送成功√" dismissAfter:1.4];
                        //[JDStatusBarNotification dismiss];
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:SENDSUCCESS object:@YES];
//                        RTAppDelegate *appDelegate = (RTAppDelegate*)[[UIApplication sharedApplication]delegate];
//                        if(isSynWeibo){
//                            [appDelegate sharedWeiboTimeLine:self.textView.text Photo:[UIImage imageNamed:@"placeimage.png"]];
//                        }
//                        if (isSynQQZone) {
//                            [appDelegate sharedQZoneTitle:nil description:self.textView.text url:@"www.baidu.com" Photo:nil];
//                        }
//                        if (isSynWeixin) {
//                            [appDelegate sendLinkContentTimeLine:self.textView.text Description:self.textView.text Url:@"www.baidu.com" Photo:nil];
//                        }
                    }
                    else{
                        [JDStatusBarNotification showWithStatus:@"发送失败" dismissAfter:1.4];
                        [JDStatusBarNotification dismiss];
                        NSLog(@"发送失败");
                    }
                } failure:^(NSError *error) {
                    [JDStatusBarNotification showWithStatus:@"发送失败" dismissAfter:1.4];
                    [JDStatusBarNotification dismiss];
                    NSLog(@"发送失败");
                }];
            }
            
        }
        
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
