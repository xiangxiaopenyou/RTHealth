//
//  URLConstant.h
//  RTHealth
//
//  Created by cheng on 14-10-17.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#ifndef RTHealth_URLConstant_h
#define RTHealth_URLConstant_h

//#define URL_BASE @"http://192.168.1.109:9090/exercise"//陈世江本地
#define URL_BASE @"http://115.29.228.32/exercise"//测试服务器
//#define URL_BASE @"http://jianshen.so/exercise" //正式服务器

#define URL_FOCUSMAP @"http://felix-chenc.qiniudn.com/"//测试库图片地址
//#define URL_FOCUSMAP @"http://7u2h8u.com1.z0.glb.clouddn.com/" //正式库图片地址

#define URL_GETRECOMMENDEDPLAN @"/own/recommendedPlan"

#define URL_LOGIN @"/login"
#define URL_REGISTER @"/register"
#define URL_GETIDENTIFY @"/getidentify"
#define URL_VERIFY @"/verify"
#define URL_FINDPASSWORD @"/password/upPassword"
#define URL_CHANGEPASSWORD @"/password/changePassword"
//第三方登陆记录消息
#define URL_THIRDLOGIN @"/register/thirdRegister"
#define URL_PERSOANL_HEADPHOTO @"/register/headportrait"

#pragma mark  - 首页
//个人信息
#define URL_PERSONAL_INFO @"/own/info"
//修改信息
#define URL_PERSONAL_MODIFY @"/own/modifyinfo"
#define URL_PERSONAL_FANSNUMBER @"/own/getfannumber"
#define URL_PERSONAL_PLAN @"/own/plan"
#define URL_PERSONAL_MYPLAN @"/own/myplan"
#define URL_PERSONAL_SYSTEMPLAN @"/own/systemplan"
#define URL_PERSONAL_FINISHEDSMALLPLAN @"/plan/finished"
//记录体重
#define URL_PERSONAL_UPWEIGHT @"/register/weight"
#define URL_WEIGHT_LINE @"/Front/Weight/checkWeight"
//体重BMI
#define URL_HEALTH_BMI @"/index/Front/BMI/bMI"
//首页每日推荐
#define URL_HOME_NOMINATE @"/home/nominate"

#pragma mark  - plan
//新建计划
#define URL_PLAN_ADD @"/Admin/plan/make"
//获取可导入的计划
#define URL_PLAN_GETIMPORT @"/plan/getplan"
//计划详情
#define URL_PLAN_DETAIL @"/plan/detailsPlan"
//导入计划
#define URL_PLAN_IMPORT @"/plan/importplan" 
//删除计划
#define URL_PLAN_DELETE @"/plan/deleteplan"
//停止计划
#define URL_PLAN_STOP @"/plan/stop"
//开始计划
#define URL_PLAN_START @"/plan/start"
//search
#define URL_SEARCH @"/search"
//计划详情
#define URL_PLAN_WEBDETAIL @"/index/Front/Plan/plan"
#define URL_PLAN_WEBSUBPLANDETAIL @"/index/Front/Plan/details"
//计划分享
#define URL_SMALLPLAN_SHARE @"/index/Front/Share/share"

#pragma mark - mine

#define URL_FRIENDS_FANS @"/mine/fans"
#define URL_FRIENDS_ATTENTION @"/mine/attention"
#define URL_FRIENDS_FANSCREATE @"/mine/fansCreate"
#define URL_FRIENDS_FANSDELETE @"/mine/delefans"
#define URL_FRIENDS_POPULAR @"/friend/popular"
#define URL_FRIENDS_TEACHER @"/friend/teacher"
#define URL_FRIENDS_NEARBY @"/friend/near"

#pragma mark - friend

#define URL_FRIEND_INFO @"/friend/info"
#define URL_FRIEND_PLAN @"/friend/plan"
#define URL_FRIEND_FANS @"/friend/fans"
#define URL_FRIEND_ACTIVITY @"/friend/activity"
#define URL_FRIEND_ATTENTION @"/friend/attention"

#define URL_UPLOADIMAGE @"http://up.qiniu.com/"
#define URL_GETTOKEN @"/QiNiuToken/setToken"
//#define URL_GETTOKEN @"/QiNiuToken/setToken"
#pragma mark - Message

#define URL_MESSAGE_ALL @"/message/allmessage"
#define URL_MESSAGE_REPLYLIST @"/message/replyList"
#define URL_MESSAGE_FAVORITELIST @"/message/favoriteList"
#define URL_MESSAGE_CHATLIST @"/message/chatlist"
#define URL_MESSAGE_SENDCHAT @"/message/sendchat"
#define URL_MESSAGE_CHATREAD @"/message/chatread"
//活动通知
#define URL_MESSAGE_REMIND @"/message/remind"
//系统通知
#define URL_MESSAGE_SYSTEM @"/message/system"

/*
 动态
 */
#pragma mark - trend

#define URL_WRITETRENDS @"/trend/dynamicCreate"
#define URL_GETTRENDSLIST @"/trend/topicList"
#define URL_GETSPORTSTRENDS @"/friend/friendSports"
#define URL_GETMYTRENDSLIST @"/trend/myTrendList"
#define URL_DELETEMYTREND @"/trend/dynamicDelete"
#define URL_GETFRIENDSTRENDSLIST @"/trend/friendTrendList"
#define URL_LIKE @"/trend/favorite"
#define URL_DISLIKE @"/trend/delefavorite"
#define URL_COMMENT @"/trend/comment"
#define URL_DELETECOMMENT @"/trend/commentDelete"
#define URL_REPLY @"/trend/cpartakCreate"
#define URL_GETCOMMENTLIST @"/trend/commentsList"
#define URL_GETLIKELIST @"/trend/favoriteList"
#define URL_GETTRENDCLASSIFY @"/config/topicList"

#pragma mark - activity

#define URL_CREATEACTIVITY @"/activity/activityCreate"
#define URL_GETMYACTIVITY @"/activity/activityList"
#define URL_ACTIVITYDETAIL @"/activity/myActivity"
#define URL_GETSYSYTEMACTIVITY @"/activity/systemActivityList"
#define URL_GETJOINACTIVITYMEMBER @"/activity/takeList"
#define URL_JOINACTIVITY @"/activity/take"
#define URL_EXITACTIVITY @"/activity/takeDelete"
#define URL_CANCELACTIVITY @"/activity/activityDelete"
#define URL_INVITEJOINACTIVITY @"/activity/inviteFriend"

//检查更新
#define URL_CHECK_UPDATE @"/config/version"
//推送devicetoken
#define URL_PUSH_TOKEN @"/register/setdDeviceToken"

//小贴士
#define URL_DISCOVER_HELP @"/index/Front/HealthReport/healthReport"
#define URL_DISCOVER_FOOD @"/index/Front/FoodCalory/foodCalory"
#define URL_DISCOVER_SPORT @"/index/Front/SportCalory/sportCalory"


#define URL_TREND_SHARED @"/index/Front/Praise/praise"
#define URL_ACTIVITY_SHARE @"/index/Front/Invitation/invitate"

#endif
