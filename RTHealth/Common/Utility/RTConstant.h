//
//  RTConstant.h
//  RTHealth
//
//  Created by cheng on 14/10/22.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#ifndef RTHealth_RTConstant_h
#define RTHealth_RTConstant_h

//总计划的几个状态 1 开始 2 未开始 3 已完成 4 未导入 state
//子计划的几个状态 1 完成 2 未完成 3 正在进行4 未进行 flag
//朋友的标记 1表示单方关注 2表示双方关注
//计划公开 1 公开  else 不公开
//体重公开 1 公开  else 不公开
//性别    1 男    else 女  默认0 女
//子计划分享 1是炫一炫 2是求原谅 3是找伙伴 4是求监督
#define FRIENDS_SIGNAL 1
#define FRIENDS_EACHOTHER 2
#define FRIENDS_IATTENTION 3
#define FRIENDS_HEATTENTION 4

//1表示评论 2表示回复

//微博
#define kAppKey         @"3858892611"
#define kAppSecret      @"0caca9888a2725f1157cbed51dc98568"
#define kRedirectURI    @"https://api.weibo.com/oauth2/default.html"
#define kAppUserInfo    @"https://api.weibo.com/2/users/show.json"

//微信
#define wxAppKey        @"wxf2e603a835fbb324"
#define wxAppSecretkey  @"ef3e5025c2a0a2e4b21c63f20ba6a54c"
#define wxDescribe      @"health"
#define wxUserInfoAccess  @"https://api.weixin.qq.com/sns/oauth2/access_token"
#define wxUserInfo      @"https://api.weixin.qq.com/sns/userinfo"
//QQ
#define qqAppid         @"1104061498"
#define qqSecret        @"jpF5A4CAtgGhG26v"

#define VIEWSHOULDLOAD @"VIEWSHOULDLOAD"
#define REGISTERNOTIFICATION @"registernotification"
#define LOGINSTATECHANGE @"loginstatechange"
#define LOGINWITHWEICHAT @"loginwithweichat"
#define LOGINWITHWEIBO @"loginwithweibo"
#define LOGINWITHQQ @"loginwithqq"
#define GETMYPLAN @"gotmyplan"
#define GETALLMESSAGE @"getallmessage"
#define SENDSUCCESS @"sendsuccess"
#define CREATEACTIVITYSUCCESS @"createactivitysuccess"
#define COMMENTTRENDSUCCESS @"commenttrendsuccess"
#define REPLYTRENDSUCCESS @"replytrendsuccess"
#define MODIFYPHOTO @"photochange"
#define ATTENTIONACTION @"attentionaction"
#define NOTIFICATION_UPDATE @"checkupdate"
//体重记录时间的key
#define WEIGHT_RECORD_TIME @"weightRecord"
//devicetoken
#define NOTIFICATION_DEVICETOKEN @"devicetoken"
//点击推送消息进入app
#define NOTIFICATION_OPENAPP @"Notification"

#define SMALLFONT_10 [UIFont systemFontOfSize:10.0]
#define SMALLFONT_12 [UIFont systemFontOfSize:12.0]
#define SMALLFONT_13 [UIFont systemFontOfSize:13.0]
#define SMALLFONT_14 [UIFont systemFontOfSize:14.0]


#define BOLDFONT_17 [UIFont boldSystemFontOfSize:17.0]

#define VERDANA_FONT_16 [UIFont fontWithName:@"Verdana" size:16.0]
#define VERDANA_FONT_14 [UIFont fontWithName:@"Verdana" size:14.0]
#define VERDANA_FONT_12 [UIFont fontWithName:@"Verdana" size:12.0]
#define VERDANA_FONT_11 [UIFont fontWithName:@"Verdana" size:11.0]
#define VERDANA_FONT_10 [UIFont fontWithName:@"Verdana" size:10.0]

#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define sports [[NSArray alloc] initWithObjects:@"心情", @"综合", @"食物", @"跑步", @"慢走", @"力量训练", @"瑜伽", @"骑行", @"篮球", @"足球", @"乒乓球", @"羽毛球",@"网球",@"游泳",@"舞蹈", @"滑轮", @"有氧操", @"排球", @"桌球", nil]
#define AppShared @"健身坊分享"

#endif
