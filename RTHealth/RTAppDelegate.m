//
//  RTAppDelegate.m
//  RTHealth
//
//  Created by cheng on 14-10-15.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTAppDelegate.h"
#import "RTTabbarViewController.h"
#import "RTLoginViewController.h"
#import "RTPlanRequest.h"
#import "RTMessageRequest.h"
#import "RTLoginRequest.h"
#import "AsyncImageDownloader.h"
#import "RTPersonalRequest.h"
#import "RTFirstLaunchedViewController.h"
#import "RTIntroductionViewController.h"
#import "RTPersonalLetterViewController.h"

@implementation RTAppDelegate
@synthesize rootNavigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    locationManager = [[CLLocationManager alloc] init];
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f){
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        [locationManager requestAlwaysAuthorization];
        //[locationManager requestWhenInUseAuthorization];
    }else{
        [[UIApplication sharedApplication]registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
    [locationManager startUpdatingLocation];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Model.sqlite"];
    [WXApi registerApp:wxAppKey];
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:qqAppid
                                            andDelegate:self];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginWithWeiChat) name:LOGINWITHWEICHAT object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginWithWeibo) name:LOGINWITHWEIBO object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginWithqq) name:LOGINWITHQQ object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginStateChange:) name:LOGINSTATECHANGE object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerNotification) name:REGISTERNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkUpdate) name:NOTIFICATION_UPDATE object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceStateChange:) name:NOTIFICATION_DEVICETOKEN object:nil];
    [self checkUpdate];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self loginStateChange:nil];
    
    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"wxd930ea5d5a258f4f://"]]];
    
    NSDictionary *launchInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if(launchInfo)
    {
        [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:launchInfo];
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerSchedule) userInfo:nil repeats:YES];
    return YES;
}

//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    return UIInterfaceOrientationMaskPortrait;
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecord cleanUp];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    [TencentOAuth HandleOpenURL:url];
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [TencentOAuth HandleOpenURL:url];
    [WeiboSDK handleOpenURL:url delegate:self];
    [WXApi handleOpenURL:url delegate:self];
    return  YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
        //判断应用程序当前的运行状态，如果是激活状态，则进行提醒，否则不提醒
//        if (application.applicationState == UIApplicationStateActive) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:notification.alertBody delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:notification.alertAction,nil];
//            [alert show];
//        }
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString* dt = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    RTUserInfo *userData = [RTUserInfo getInstance];
    userData.deviceToken = dt;
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_DEVICETOKEN object:nil];
    NSLog(@"device token %@ %@",deviceToken,dt);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"push register error :%@",error.description);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    
    NSLog(@"received badge number ---%@ ----",[[userInfo objectForKey:@"aps"] objectForKey:@"badge"]);
//
//    for (id key in userInfo) {
//        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
//    }
//    
//    NSLog(@"the badge number is  %ld",  (long)[[UIApplication sharedApplication] applicationIconBadgeNumber]);
//    NSLog(@"the application  badge number is  %ld",  (long)application.applicationIconBadgeNumber);
    application.applicationIconBadgeNumber = 0;
//
//     We can determine whether an application is launched as a result of the user tapping the action
//     button or whether the notification was delivered to the already-running application by examining
//     the application state.
    
    //当用户打开程序时候收到远程通知后执行
    if (application.applicationState == UIApplicationStateActive) {
        // 转换成一个本地通知，显示到通知栏，你也可以直接显示出一个alertView，只是那样稍显aggressive：）
//        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//        localNotification.userInfo = userInfo;
//        localNotification.soundName = UILocalNotificationDefaultSoundName;
//        localNotification.alertBody = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
//        localNotification.fireDate = [NSDate date];
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }else{
        if ([[userInfo objectForKey:@"message"] intValue]==1) {
            if ([self.rootNavigationController.visibleViewController.title isEqual:@"消息"]) {
                return;
            }
            [self.rootNavigationController pushViewController:[[RTPersonalLetterViewController alloc]init] animated:YES];
        }
    }
}

#pragma mark Local Notification
- (void)registerNotification{
    [RTUtil notificationRegister];
}

#pragma login 

- (void)loginStateChange:(NSNotification *)notification
{
    rootNavigationController = [[UINavigationController alloc]init];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunched"]){
        NSLog(@"第一次运行");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunched"];
         RTFirstLaunchedViewController *firstLaunchedViewController = [[RTFirstLaunchedViewController alloc] init];
         rootNavigationController = [[UINavigationController alloc] initWithRootViewController:firstLaunchedViewController];
    }
    else{
        BOOL isAutoLogin = [RTUtil isLogin];
        BOOL loginSuccess = [notification.object boolValue];
        
        NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        if ([RTUtil isEmpty:userid]) {
            
                [timer invalidate];
                RTLoginViewController *login = [[RTLoginViewController alloc]init];
                rootNavigationController = [[UINavigationController alloc] initWithRootViewController:login];

        }else{
        NSPredicate *preTemplate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"userid=='%@'",userid]];
        RTUserInfo *userInfo = [RTUserInfo getInstance];
        userInfo.userData = [UserInfo MR_findFirstWithPredicate:preTemplate];
        UserInfo *info = userInfo.userData;
        
        if ([info.isnewuser isEqualToString:@"1"]) {
            info.isnewuser = @"0";
            RTIntroductionViewController *introViewController = [[RTIntroductionViewController alloc] init];
            rootNavigationController = [[UINavigationController alloc] initWithRootViewController:introViewController];
        }
        else{
        
            if ((isAutoLogin || loginSuccess)&&![RTUtil isEmpty:userInfo.userData]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_DEVICETOKEN object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:REGISTERNOTIFICATION object:nil];
                [timer fire];
                [self getMyPlan];
                RTTabbarViewController *tabbarController = [[RTTabbarViewController alloc]init];
                rootNavigationController = [[UINavigationController alloc]initWithRootViewController:tabbarController];
            }
            else{
                [timer invalidate];
                RTLoginViewController *login = [[RTLoginViewController alloc]init];
                rootNavigationController = [[UINavigationController alloc] initWithRootViewController:login];
            }
        }
        }
    }
    
    rootNavigationController.navigationBarHidden = YES;
    self.window.rootViewController = rootNavigationController;
}

- (void)timerSchedule{
    NSLog(@"timer");
    [RTMessageRequest getAllMessageListSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [[NSNotificationCenter defaultCenter]postNotificationName:GETALLMESSAGE object:nil];
        }
    } failure:^(NSError *error){
    }];
    
}
- (void)getMyPlan{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    
    [RTPlanRequest getMyPlan:parameter success:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [[NSNotificationCenter defaultCenter] postNotificationName:GETMYPLAN object:nil];
            [self resignFirstResponder];
        }
    }failure:^(NSError *error){
    }];
}

- (void)loginWithWeiChat
{
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}


#pragma mark weichat delegate

-(void) onReq:(BaseReq*)req
{

}

-(void) onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *respr = (SendAuthResp*)resp;
        if (respr.code == nil) {
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
        }else{
            NSDictionary *tempDic = [[NSDictionary alloc]initWithObjectsAndKeys:wxAppKey,@"appid",wxAppSecretkey,@"secret",respr.code,@"code",@"authorization_code",@"grant_type", nil];
            //pragma mark 获取openid
            [RTNetWork get:wxUserInfoAccess params:tempDic success:^(NSDictionary *response){
                if (![RTUtil isEmpty:[response objectForKey:@"openid"]]) {
                    NSDictionary *userParams = [[NSDictionary alloc]initWithObjectsAndKeys:[response objectForKey:@"access_token"],@"access_token",[response objectForKey:@"openid"],@"openid", nil];
                    //pragma mark 获取用户信息
                    [RTNetWork get:wxUserInfo params:userParams success:^(id responsedic){
                        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
                        if (![RTUtil isEmpty:[responsedic objectForKey:@"nickname"]]) {
                            [dictionary setObject:[responsedic objectForKey:@"nickname"] forKey:@"nickname"];
                        }
                        [dictionary setObject:[responsedic objectForKey:@"openid"] forKey:@"openid"];
                        //pragma mark 和服务器交互
                        [RTLoginRequest registerThirdWith:dictionary success:^(id responseLogin){
                            if ([[responseLogin objectForKey:@"state"] intValue] == URL_NORMAL) {
                                [[NSNotificationCenter defaultCenter]postNotificationName:LOGINSTATECHANGE object:@YES];
                                
                                if (![RTUtil isEmpty:[responsedic objectForKey:@"headimgurl"]]){
                                    [self saveheadImage:[responsedic objectForKey:@"headimgurl"]];
                                }
                            }
                        }failure:^(NSError *error){
                            [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
                        }];
                    } failure:^(NSError *error){
                        [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
                    }];
                }
                
            } failure:^(NSError *error)
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
             }];
        }
    }
}

//分享给朋友
- (void) sendLinkContent:(NSString*)title Description:(NSString*)description Url:(NSString *)urlString Photo:(NSString *)photoUrl
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl]]]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];

}
//分享到朋友圈
- (void) sendLinkContentTimeLine:(NSString*)title Description:(NSString*)description Url:(NSString *)urlString Photo:(NSString *)photoUrl
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl]]]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

#pragma mark weibo delegate

- (void)sharedWeiboTimeLine:(NSString*)content Photo:(UIImage*)photo{
    WBMessageObject *object = [[WBMessageObject alloc]init];
    object.text = content;
    WBImageObject *imageObject = [[WBImageObject alloc]init];
    imageObject.imageData = UIImageJPEGRepresentation(photo, 1.0);
    object.imageObject = imageObject;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:object];
    [WeiboSDK sendRequest:request];
}
- (void)sharedWeiboTimeLine:(NSString*)content Description:(NSString*)description objectID:(NSString*)objectid url:(NSString*)utlString photo:(NSData*)data{
    WBMessageObject *object = [[WBMessageObject alloc]init];
    object.text = content;
    WBWebpageObject *webObject = [[WBWebpageObject alloc]init];
    webObject.webpageUrl = utlString;
    webObject.description = description;
    webObject.title = content;
    webObject.objectID = objectid;
    webObject.thumbnailData = data;
    object.mediaObject = webObject;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:object];
    [WeiboSDK sendRequest:request];
}
- (void)sharedWeiboTimeLine:(NSString*)content Description:(NSString*)description objectID:(NSString*)objectid url:(NSString*)utlString{
    WBMessageObject *object = [[WBMessageObject alloc]init];
    object.text = content;
    WBWebpageObject *webObject = [[WBWebpageObject alloc]init];
    webObject.webpageUrl = utlString;
    webObject.description = description;
    webObject.title = content;
    webObject.objectID = objectid;
    object.mediaObject = webObject;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:object];
    [WeiboSDK sendRequest:request];
}

- (void)loginWithWeibo
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        if ([RTUtil isEmpty:[(WBAuthorizeResponse *)response userID]]||[RTUtil isEmpty:[(WBAuthorizeResponse *)response accessToken]]){
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
            return;
        }
        NSMutableDictionary *dictionary = [[NSMutableDictionary  alloc]init];
        [dictionary setObject:[(WBAuthorizeResponse *)response userID] forKey:@"uid"];
        [dictionary setObject:[(WBAuthorizeResponse *)response accessToken] forKey:@"access_token"];
        //获取用户信息
        [RTNetWork get:kAppUserInfo params:dictionary success:^(id responseDic){
            
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
            
            if (![RTUtil isEmpty:[responseDic objectForKey:@"screen_name"]]) {
                [dictionary setObject:[responseDic objectForKey:@"screen_name"] forKey:@"nickname"];
            }
            [dictionary setObject:[(WBAuthorizeResponse *)response userID] forKey:@"openid"];
            //pragma mark 和服务器交互
            [RTLoginRequest registerThirdWith:dictionary success:^(id responseLogin){
                if ([[responseLogin objectForKey:@"state"] intValue] == URL_NORMAL) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:LOGINSTATECHANGE object:@YES];
                    if (![RTUtil isEmpty:[responseDic objectForKey:@"profile_image_url"]]){
                        [self saveheadImage:[responseDic objectForKey:@"profile_image_url"]];
                    }
                }
            }failure:^(NSError *error){
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登录" message:@"登录失败,请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }];
        }failure:^(NSError *error){
            
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
        }];
    }
}


#pragma qq delegate


- (void)loginWithqq
{
    
    _permissions = [NSMutableArray arrayWithObjects:
                    kOPEN_PERMISSION_GET_USER_INFO,
                    kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                    kOPEN_PERMISSION_ADD_ALBUM,
                    kOPEN_PERMISSION_ADD_IDOL,
                    kOPEN_PERMISSION_ADD_ONE_BLOG,
                    kOPEN_PERMISSION_ADD_PIC_T,
                    kOPEN_PERMISSION_ADD_SHARE,
                    kOPEN_PERMISSION_ADD_TOPIC,
                    kOPEN_PERMISSION_CHECK_PAGE_FANS,
                    kOPEN_PERMISSION_DEL_IDOL,
                    kOPEN_PERMISSION_DEL_T,
                    kOPEN_PERMISSION_GET_FANSLIST,
                    kOPEN_PERMISSION_GET_IDOLLIST,
                    kOPEN_PERMISSION_GET_INFO,
                    kOPEN_PERMISSION_GET_OTHER_INFO,
                    kOPEN_PERMISSION_GET_REPOST_LIST,
                    kOPEN_PERMISSION_LIST_ALBUM,
                    kOPEN_PERMISSION_UPLOAD_PIC,
                    kOPEN_PERMISSION_GET_VIP_INFO,
                    kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                    kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                    kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                    nil];
    
    [_tencentOAuth authorize:_permissions inSafari:NO];
}

- (void)tencentDidLogin
{
    // 登录成功
    
    if (_tencentOAuth.accessToken
        && 0 != [_tencentOAuth.accessToken length])
    {
        
        NSLog( @"accessToken %@ \n opendid %@",_tencentOAuth.accessToken ,_tencentOAuth.openId) ;
        [_tencentOAuth getUserInfo];
    }
    else
    {
        NSLog( @"登录不成功 没有获取accesstoken");
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
    }
    
}
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
}
-(void)tencentDidNotNetWork
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
}
-(void)tencentDidLogout
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATECHANGE object:@NO];
}
- (void)getUserInfoResponse:(APIResponse*) response
{
    
    if (response.retCode == URLREQUEST_SUCCEED)
    {
        NSMutableString *str=[NSMutableString stringWithFormat:@""];//上传服务器
        for (id key in response.jsonResponse) {
            [str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
        }
        NSLog(@"response %@",response.jsonResponse);
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        if (![RTUtil isEmpty:[response.jsonResponse objectForKey:@"nickname"]]) {
            [dictionary setObject:[response.jsonResponse objectForKey:@"nickname"] forKey:@"nickname"];
        }
        [dictionary setObject:_tencentOAuth.openId forKey:@"openid"];
        //pragma mark 和服务器交互
        [RTLoginRequest registerThirdWith:dictionary success:^(id responseLogin){
            if ([[responseLogin objectForKey:@"state"] intValue] == URL_NORMAL) {
                [[NSNotificationCenter defaultCenter]postNotificationName:LOGINSTATECHANGE object:@YES];
                if (![RTUtil isEmpty:[response.jsonResponse objectForKey:@"figureurl_qq_2"]]){
                    [self saveheadImage:[response.jsonResponse objectForKey:@"figureurl_qq_2"]];
                }
            }
        }failure:^(NSError *error){
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登录" message:@"登录失败,请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }];

    }
    else//失败
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
        [alert show];
    }
    
}

- (void)shared{
    //分享文本消息
    QQApiTextObject *textsend = [QQApiTextObject objectWithText:@"123"];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:textsend];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    if (sent == EQQAPIQZONENOTSUPPORTTEXT){
        
    }
}
- (void)sharedQQFriendTitle:(NSString*)title description:(NSString*)description url:(NSString*)urlString Photo:(NSString*)photoUrl{
    NSString *url = urlString;
    //分享图预览图URL地址
    NSString *previewImageUrl = photoUrl;
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:url]
                                title: title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    if (sent == EQQAPIQZONENOTSUPPORTTEXT){
        
    }

}
- (void)sharedQZoneTitle:(NSString*)title description:(NSString*)description url:(NSString*)urlString Photo:(NSString*)photoUrl{
    
    NSString *url = urlString;
    //分享图预览图URL地址
    NSString *previewImageUrl = photoUrl;
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:url]
                                title: title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    if (sent == EQQAPIQZONENOTSUPPORTTEXT){
        
    }
}

#pragma mark 第三方登陆用户头像保存

- (void)saveheadImage:(NSString*)headimgUrl{
    
    AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
    [downloader startWithUrl:headimgUrl delegate:self];
    

}
#pragma mark - AsyncImageDownloader Delegate

- (void)imageDownloader:(AsyncImageDownloader *)downloader didFinishWithImage:(UIImage *)image
{
    if (image == nil) {
        return;
    }
    RTUserInfo *userInfo = [RTUserInfo getInstance];
    if (userInfo.userData == nil) {
        NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        NSPredicate *preTemplate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"userid=='%@'",userid]];
        userInfo.userData = [UserInfo MR_findFirstWithPredicate:preTemplate];
    }
    UserInfo *info = userInfo.userData;
    
    [RTUploadImageNetWork postMulti:nil imageparams:image success:^(id response){
        if ([response objectForKey:@"key"]) {
            info.userphoto = [response objectForKey:@"key"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:info.userid forKey:@"userid"];
            [dic setObject:info.usertoken forKey:@"usertoken"];
            if ([RTUtil isEmpty:info.userphoto]) {
                [dic setObject:@"" forKey:@"userheadportrait"];
            }else{
                [dic setObject:info.userphoto forKey:@"userheadportrait"];
            }
            [RTPersonalRequest modifyHeadInfoWith:dic success:^(id response){
            } failure:^(NSError *error){}];
            
            [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
            [[NSNotificationCenter defaultCenter]postNotificationName:MODIFYPHOTO object:nil];
        }
    } failure:^(NSError *error){
    } Progress:^(NSString *key,float percent){
    } Cancel:^BOOL () {
        return NO;
    }];
}

#pragma mark -Update

- (void)checkUpdate{
    [RTPersonalRequest checkUpdateSuccess:^(id response){
        if ([[response objectForKey:@"version"] intValue] == 1) {
        }else if ([[response objectForKey:@"version"] intValue] == 2){
            self.updateUrl = [response objectForKey:@"updateurl"];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"有新版本更新" message:[response objectForKey:@"data"] delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"马上更新", nil];
            alertView.tag = 100;
            [alertView show];
        }
    }failure:^(NSError *error){
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if(buttonIndex == 1){
            NSURL *url = [NSURL URLWithString:self.updateUrl];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark - device token

- (void)deviceStateChange:(NSNotification *)notification{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    if (userinfo == nil) {
        return;
    }else if ([RTUtil isEmpty:userData.deviceToken]){
        return;
    }else{
        [RTPersonalRequest setDeviceTokenSuccess:^(id response){} failure:^(NSError *error){}];
    }
}

@end
