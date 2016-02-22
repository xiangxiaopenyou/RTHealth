//
//  RTMessageRequest.m
//  RTHealth
//
//  Created by cheng on 14/12/10.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTMessageRequest.h"

@implementation RTMessageRequest


+ (void)getReplyListSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    
    if (userinfo.replySet.count == 0 || [RTUtil isEmpty:userinfo.reply]) {
        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[userinfo.replySet allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"replytime" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        Reply *reply = [array lastObject];
        [parameter setObject:reply.replytime forKey:@"time"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_MESSAGE_REPLYLIST];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                
                @try {
                    
                
                //存储数据
                if (![RTUtil isEmpty:[response objectForKey:@"reply"]]) {
                    NSDictionary *dataDictionary = [response objectForKey:@"reply"];
                    NSMutableArray *replyArray = [[NSMutableArray alloc]init];
                    NSArray *dataArray = [dataDictionary objectForKey:@"data"];
                    if (![RTUtil isEmpty:dataArray]){
                        for (NSDictionary *replyDictionary in dataArray) {
                            Reply *reply = [Reply MR_createEntity];
                            reply.trendid = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendid"]]?nil:[replyDictionary objectForKey:@"trendid"];
                            reply.trendcontent = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendcontent"]]?@"":[replyDictionary objectForKey:@"trendcontent"];
                            reply.trendphoto = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendphoto"]]?nil:[replyDictionary objectForKey:@"trendphoto"];
                            reply.replytype = [RTUtil isEmpty:[replyDictionary objectForKey:@"replytype"]]?@"1":[replyDictionary objectForKey:@"replytype"];
                            reply.replycontent = [RTUtil isEmpty:[replyDictionary objectForKey:@"replycontent"]]?@"":[replyDictionary objectForKey:@"replycontent"];
                            reply.replyid = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyid"]]?@"":[replyDictionary objectForKey:@"replyid"];
                            reply.replytime = [RTUtil isEmpty:[replyDictionary objectForKey:@"replytime"]]?@"":[replyDictionary objectForKey:@"replytime"];
                            reply.replyuserid = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyuserid"]]?@"":[replyDictionary objectForKey:@"replyuserid"];
                            reply.replyusernickname = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyusernickname"]]?@"":[replyDictionary objectForKey:@"replyusernickname"];
                            reply.replyuserphoto = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyuserphoto"]]?@"":[replyDictionary objectForKey:@"replyuserphoto"];
                            reply.replyforuserid = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyforuserid"]]?nil:[replyDictionary objectForKey:@"replyforuserid"];
                            reply.replyforusercontent = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyforusercontent"]]?@"":[replyDictionary objectForKey:@"replyforusercontent"];
                            reply.replyforusernickname = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyforusernickname"]]?@"":[replyDictionary objectForKey:@"replyforusernickname"];
                            reply.replyisread = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyisread"]]?@"1":[replyDictionary objectForKey:@"replyisread"];
                            reply.replyfriendid = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyfriendid"]]?@"":[replyDictionary objectForKey:@"replyfriendid"];
                            reply.replyfriendnickname = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyfriendnickname"]]?@"":[replyDictionary objectForKey:@"replyfriendnickname"];
                            reply.replyfriendtpye = [RTUtil isEmpty:[replyDictionary objectForKey:@"replyfriendtype"]]?@"1":[replyDictionary objectForKey:@"replyfriendtype"];
                            
                            reply.username = [RTUtil isEmpty:[replyDictionary objectForKey:@"username"]]?@"":[replyDictionary objectForKey:@"username"];
                            reply.trendaddress = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendaddress"]]?@"":[replyDictionary objectForKey:@"trendaddress"];
                            reply.trendcommentnumber = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendcomments"]]?@"0":[replyDictionary objectForKey:@"username"];
                            reply.trendcreatetime = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendcreated_time"]]?@"":[replyDictionary objectForKey:@"trendcreated_time"];
                            reply.trendlabel = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendlabel"]]?@"":[replyDictionary objectForKey:@"trendlabel"];
                            reply.trendlike = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendlike"]]?@"":[replyDictionary objectForKey:@"trendlike"];
                            reply.trendlocat = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendlocat"]]?@"":[replyDictionary objectForKey:@"trendlocat"];
                            reply.trendsex = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendsex"]]?@"":[replyDictionary objectForKey:@"trendsex"];
                            reply.trendtitle = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendtitle"]]?@"":[replyDictionary objectForKey:@"trendtitle"];
                            reply.trenduserid = [RTUtil isEmpty:[replyDictionary objectForKey:@"trenduserid"]]?@"":[replyDictionary objectForKey:@"trenduserid"];
                            reply.trendusertype = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendusertype"]]?@"":[replyDictionary objectForKey:@"trendusertype"];
                            reply.trenduserhead = [RTUtil isEmpty:[replyDictionary objectForKey:@"userheadportrait"]]?@"":[replyDictionary objectForKey:@"userheadportrait"];
                            
                            [replyArray addObject:reply];
                        }
                    }
                    [userinfo.replySet addObjectsFromArray:replyArray];
                    
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    
                    
                }
                }
                @catch (NSException *exception) {
                    
                }
            }else{
                //错误信息
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];

}


+ (void)getFavoriteListSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    
    
    if (userinfo.praiseSet.count == 0 || [RTUtil isEmpty:userinfo.praiseSet]) {
        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[userinfo.praiseSet allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"praisetime" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        Praise *praise = [array lastObject];
        [parameter setObject:praise.praisetime forKey:@"time"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_MESSAGE_FAVORITELIST];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                
                @try {
                //存储数据
                    if (![RTUtil isEmpty:[response objectForKey:@"data"]]) {
                    NSMutableArray *praiseArray = [[NSMutableArray alloc]init];
                    NSArray *dataArray = [response objectForKey:@"data"];
                    if (![RTUtil isEmpty:dataArray]){
                        for (NSDictionary *replyDictionary in dataArray) {
                            Praise *praise = [Praise MR_createEntity];
                            praise.trendid = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendid"]]?nil:[replyDictionary objectForKey:@"trendid"];
                            praise.trendcontent = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendcontent"]]?@"":[replyDictionary objectForKey:@"trendcontent"];
                            praise.userphoto = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendphoto"]]?nil:[replyDictionary objectForKey:@"trendphoto"];
                            praise.praiseuserid = [RTUtil isEmpty:[replyDictionary objectForKey:@"praiseuserid"]]?nil:[replyDictionary objectForKey:@"praiseuserid"];
                            praise.username = [RTUtil isEmpty:[replyDictionary objectForKey:@"username"]]?@"":[replyDictionary objectForKey:@"username"];
                            praise.praisetime = [RTUtil isEmpty:[replyDictionary objectForKey:@"praisetime"]]?nil:[replyDictionary objectForKey:@"praisetime"];
                            praise.praiseusernickname = [RTUtil isEmpty:[replyDictionary objectForKey:@"praiseusernickname"]]?@"":[replyDictionary objectForKey:@"praiseusernickname"];
                            praise.praiseuserphoto = [RTUtil isEmpty:[replyDictionary objectForKey:@"praiseuserphoto"]]?nil:[replyDictionary objectForKey:@"praiseuserphoto"];
                            
                            praise.trendphoto = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendphoto"]]?nil:[replyDictionary objectForKey:@"trendphoto"];
                            praise.trendaddress = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendaddress"]]?@"":[replyDictionary objectForKey:@"trendaddress"];
                            praise.trendcommentnumber = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendcomments"]]?@"0":[replyDictionary objectForKey:@"username"];
                            praise.trendcreatetime = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendcreated_time"]]?@"":[replyDictionary objectForKey:@"trendcreated_time"];
                            praise.trendlabel = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendlabel"]]?@"":[replyDictionary objectForKey:@"trendlabel"];
                            praise.trendlike = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendlike"]]?@"":[replyDictionary objectForKey:@"trendlike"];
                            praise.trendlocat = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendlocat"]]?@"":[replyDictionary objectForKey:@"trendlocat"];
                            praise.trendsex = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendsex"]]?@"":[replyDictionary objectForKey:@"trendsex"];
                            praise.trendtitle = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendtitle"]]?@"":[replyDictionary objectForKey:@"trendtitle"];
                            praise.trenduserid = [RTUtil isEmpty:[replyDictionary objectForKey:@"trenduserid"]]?@"":[replyDictionary objectForKey:@"trenduserid"];
                            praise.trendusertype = [RTUtil isEmpty:[replyDictionary objectForKey:@"trendusertype"]]?@"":[replyDictionary objectForKey:@"trendusertype"];
                            praise.trenduserhead = [RTUtil isEmpty:[replyDictionary objectForKey:@"userheadportrait"]]?@"":[replyDictionary objectForKey:@"userheadportrait"];
                            
                            [praiseArray addObject:praise];
                        }
                    }
                    [userinfo.praiseSet addObjectsFromArray:praiseArray];
                    
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    
                }
                    
                    
                }
                @catch (NSException *exception) {
                    
                }
            }else{
                //错误信息
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getAllMessageListSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    if ([RTUtil isEmpty: userinfo.userid]){
        return;
    }
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_MESSAGE_ALL];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                //存储数据
                @try {
                    if (![RTUtil isEmpty:[response objectForKey:@"chat"]]) {
                        NSArray *dataArray = [response objectForKey:@"chat"];
                        userData.notReadChatNumber= [NSNumber numberWithInt:0];
                        if (![RTUtil isEmpty:dataArray]){
                            for (NSDictionary *chatDictionary in dataArray) {
                                if ([RTUtil isEmpty:[chatDictionary objectForKey:@"chatuserid"]]) {
                                    continue;
                                }
                                NSString *chatuserid = [chatDictionary objectForKey:@"chatuserid"];
                                Chat *chat = [Chat MR_findFirstByAttribute:@"chatuserid" withValue:chatuserid];
                                if (chat == nil) {
                                    chat = [Chat MR_createEntity];
                                    [userinfo.chatSet addObject:chat];
                                }
                                chat.chatuserid = chatuserid;
                                chat.chatlastcontent = [RTUtil isEmpty:[chatDictionary objectForKey:@"chatlastcontent"]]?@"":[chatDictionary objectForKey:@"chatlastcontent"];
                                chat.chatlasttime = [RTUtil isEmpty:[chatDictionary objectForKey:@"chatlasttime"]]?@"":[chatDictionary objectForKey:@"chatlasttime"];
                                chat.chatusernickname = [RTUtil isEmpty:[chatDictionary objectForKey:@"chatusernickname"]]?@"":[chatDictionary objectForKey:@"chatusernickname"];
                                chat.chatuserphoto = [RTUtil isEmpty:[chatDictionary objectForKey:@"chatuserphoto"]]?@"":[chatDictionary objectForKey:@"chatuserphoto"];
                                
                                for (ChatList *chatlistRemove in chat.chatlistSet){
                                    [chatlistRemove MR_deleteEntity];
                                }
                                [chat.chatlistSet removeAllObjects];
                                
                                userData.notReadChatNumber= [NSNumber numberWithInt:[userData.notReadChatNumber intValue]+[[chatDictionary objectForKey:@"count"] intValue]];
                                
                                if (![RTUtil isEmpty:[chatDictionary objectForKey:@"chatlist"]]) {
                                    for (NSDictionary *listDictionary in [chatDictionary objectForKey:@"chatlist"]) {
                                        ChatList *list = [ChatList MR_createEntity];
                                        list.chatcontent = [RTUtil isEmpty:[listDictionary objectForKey:@"chatcontent"]]?@"":[listDictionary objectForKey:@"chatcontent"];
                                        list.chatisread = [RTUtil isEmpty:[listDictionary objectForKey:@"chatisread"]]?@"1":[listDictionary objectForKey:@"chatisread"];
                                        list.chattime = [RTUtil isEmpty:[listDictionary objectForKey:@"chattime"]]?nil:[listDictionary objectForKey:@"chattime"];
                                        list.chattype = [RTUtil isEmpty:[listDictionary objectForKey:@"chattype"]]?@"1":[listDictionary objectForKey:@"chattype"];
                                        list.chatid = [RTUtil isEmpty:[listDictionary objectForKey:@"id"]]?@"":[listDictionary objectForKey:@"id"];
                                        [chat.chatlistSet addObject:list];
                                    }
                                }
                            }
                        }
                        
                        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                        
                    }
                    if (![RTUtil isEmpty:[response objectForKey:@"reply"]]) {
                        userData.replyNumber = [NSNumber numberWithInt:[[response objectForKey:@"reply"] intValue]];
                    }
                    if (![RTUtil isEmpty:[response objectForKey:@"favorite"]]) {
                        userData.favoriteNumber = [NSNumber numberWithInt:[[response objectForKey:@"favorite"] intValue]];
                    }
                    if (![RTUtil isEmpty:[response objectForKey:@"ActivityRemind"]]) {
                        userData.activityRemindNumber = [NSNumber numberWithInt:[[response objectForKey:@"ActivityRemind"] intValue]];
                    }
                    
                    
                }
                @catch (NSException *exception) {
                    
                }
            }else{
                //错误信息
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getChatList:(Chat*)chat Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:chat.chatuserid forKey:@"friendid"];
    
    if (chat.chatlist.count == 0 || [RTUtil isEmpty:chat.chatlist]) {
        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[chat.chatlist allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"chattime" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        ChatList *chatList = [array lastObject];
        [parameter setObject:chatList.chattime forKey:@"time"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_MESSAGE_CHATLIST];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                
                @try {
                    
                    if (![RTUtil isEmpty:[response objectForKey:@"data"]]) {
                        NSMutableArray *array = [[NSMutableArray alloc]init];
                        for (NSDictionary *temp in [response objectForKey:@"data"]) {
                            ChatList *chatlist = [ChatList MR_createEntity];
                            chatlist.chatcontent = [RTUtil isEmpty:[temp objectForKey:@"chatcontent"]]?@"":[temp objectForKey:@"chatcontent"];
                            chatlist.chatid = [RTUtil isEmpty:[temp objectForKey:@"id"]]?@"":[temp objectForKey:@"id"];
                            chatlist.chattime = [RTUtil isEmpty:[temp objectForKey:@"chattime"]]?@"":[temp objectForKey:@"chattime"];
                            chatlist.chatisread = [RTUtil isEmpty:[temp objectForKey:@"chatisread"]]?@"":[temp objectForKey:@"chatisread"];
                            chatlist.chattype = [RTUtil isEmpty:[temp objectForKey:@"chattype"]]?@"1":[temp objectForKey:@"chattype"];
                            if ([chatlist.chattype intValue]==2) {
                                chatlist.chatisread = @"2";
                            }
                            [array addObject:chatlist];
                        }
                        [chat.chatlistSet addObjectsFromArray:array];
                        
                        NSMutableArray *arrayChat = [[NSMutableArray alloc]initWithArray:[chat.chatlist allObjects]];
                        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"chattime" ascending:YES];
                        [arrayChat sortUsingDescriptors:[NSArray arrayWithObject:sort]];
                        ChatList *chatList = [arrayChat lastObject];
                        chat.chatlasttime = chatList.chattime;
                        chat.chatlastcontent = chatList.chatcontent;
                        
                        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    }
                }
                @catch (NSException *exception) {
                    
                }
            }else{
                //错误信息
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getFreshChatList:(Chat*)chat Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:chat.chatuserid forKey:@"friendid"];
    [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_MESSAGE_CHATLIST];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                @try {
                    
                    if (![RTUtil isEmpty:[response objectForKey:@"data"]]) {
                    NSMutableArray *array = [[NSMutableArray alloc]init];
                    for (NSDictionary *temp in [response objectForKey:@"data"]) {
//                        if ([[temp objectForKey:@"chatisread"] intValue] == 1 && [[temp objectForKey:@"chattype"] intValue] == 1 ) {
//                        }
                        if (![RTUtil isEmpty:[temp objectForKey:@"id"]]) {
                            NSArray *arrayList = [chat.chatlist allObjects];
                            NSPredicate *preTemplate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"chatid=='%@'",[temp objectForKey:@"id"]]];
                            NSMutableArray *arrayHas = [NSMutableArray arrayWithArray:[arrayList filteredArrayUsingPredicate:preTemplate]];
                            if (arrayHas.count == 0 || arrayHas == nil) {
                                
                                ChatList *chatlist = [ChatList MR_createEntity];
                                chatlist.chatcontent = [RTUtil isEmpty:[temp objectForKey:@"chatcontent"]]?@"":[temp objectForKey:@"chatcontent"];
                                chatlist.chatid = [RTUtil isEmpty:[temp objectForKey:@"id"]]?@"":[temp objectForKey:@"id"];
                                chatlist.chattime = [RTUtil isEmpty:[temp objectForKey:@"chattime"]]?@"":[temp objectForKey:@"chattime"];
                                chatlist.chatisread = [RTUtil isEmpty:[temp objectForKey:@"chatisread"]]?@"":[temp objectForKey:@"chatisread"];
                                chatlist.chattype = [RTUtil isEmpty:[temp objectForKey:@"chattype"]]?@"1":[temp objectForKey:@"chattype"];
                                [array addObject:chatlist];
                            }
                        }
                    }
                    [chat.chatlistSet addObjectsFromArray:array];
                    
                    NSMutableArray *arrayChat = [[NSMutableArray alloc]initWithArray:[chat.chatlist allObjects]];
                    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"chattime" ascending:YES];
                    [arrayChat sortUsingDescriptors:[NSArray arrayWithObject:sort]];
                    ChatList *chatList = [arrayChat lastObject];
                    chat.chatlasttime = chatList.chattime;
                    chat.chatlastcontent = chatList.chatcontent;
                    
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                }
                    
                }
                @catch (NSException *exception) {
                    
                }
                
            }else{
                //错误信息
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)sendChatList:(ChatList*)chatlist Chat:(Chat*)chat Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:chat.chatuserid forKey:@"friendid"];
    [parameter setObject:chatlist.chatcontent forKey:@"chatcontent"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_MESSAGE_SENDCHAT];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                
                @try {
                    
                    if (![RTUtil isEmpty:[response objectForKey:@"data"]]) {
                        NSDictionary *dictionary = [response objectForKey:@"data"];
                        chatlist.chattime = [dictionary objectForKey:@"chatlasttime"];
                        chatlist.chatid = [dictionary objectForKey:@"id"];
                    }
                    [chat.chatlistSet addObject:chatlist];
                    chat.chatlastcontent = chatlist.chatcontent;
                    chat.chatlasttime = chatlist.chattime;
                    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    
                }
                @catch (NSException *exception) {
                    
                }
            }else{
                //错误信息
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)chatReadList:(Chat*)chat Success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    @try {
        
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    [parameter setObject:chat.chatuserid forKey:@"friendid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_MESSAGE_CHATREAD];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                
                for (ChatList *chatlist in chat.chatlist) {
                    chatlist.chatisread = @"2";
                }
                
                [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                
            }else{
                //错误信息
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

+ (void)getRemindListSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:userinfo.userid forKey:@"userid"];
    [parameter setObject:userinfo.usertoken forKey:@"usertoken"];
    if (userinfo.remindSet.count == 0 || [RTUtil isEmpty:userinfo.remind]) {
        [parameter setObject:[CustomDate getDateString:[NSDate date]] forKey:@"time"];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[userinfo.remind allObjects]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"remindtime" ascending:NO];
        [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        Remind *remind = [array lastObject];
        [parameter setObject:remind.remindtime forKey:@"time"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_MESSAGE_REMIND];
    NSLog(@"url %@",url);
    [RTNetWork post:url params:parameter success:^(NSDictionary *response){
        if (success) {
            //返回controller，然后在UI线程上进行更新
            //解析返回的数据
            if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
                
                @try {
                    if (![RTUtil isEmpty:[response objectForKey:@"data"]]) {
                        
                        NSMutableArray *array = [[NSMutableArray alloc]init];
                        for (NSDictionary *temp in [response objectForKey:@"data"]) {
                            Remind *remind = [Remind MR_createEntity];
                            remind.remindcontent = [RTUtil isEmpty:[temp objectForKey:@"remindcontent"]]?@"":[temp objectForKey:@"remindcontent"];
                            remind.remindid = [RTUtil isEmpty:[temp objectForKey:@"remindid"]]?@"":[temp objectForKey:@"remindid"];
                            remind.remindisread = @"2";
                            remind.remindsomeid = [RTUtil isEmpty:[temp objectForKey:@"remindsomeid"]]?@"":[temp objectForKey:@"remindsomeid"];
                            remind.remindsometitle = [RTUtil isEmpty:[temp objectForKey:@"remindsometitle"]]?nil:[temp objectForKey:@"remindsometitle"];
                            remind.remindtime = [RTUtil isEmpty:[temp objectForKey:@"remindtime"]]?@"":[temp objectForKey:@"remindtime"];
                            remind.remindtype = [RTUtil isEmpty:[temp objectForKey:@"remindtype"]]?@"":[temp objectForKey:@"remindtype"];
                            remind.reminduserid = [RTUtil isEmpty:[temp objectForKey:@"reminduserid"]]?nil:[temp objectForKey:@"reminduserid"];
                            remind.remindusernickname = [RTUtil isEmpty:[temp objectForKey:@"remindusernickname"]]?nil:[temp objectForKey:@"remindusernickname"];
                            [array addObject:remind];
                        }
                        [userinfo.remindSet addObjectsFromArray:array];
                        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                    }
                }
                @catch (NSException *exception) {
                    
                }
                
            }else{
                //错误信息
            }
            success(response);
        }
    }failure:^(NSError *error){
        if (failure) {
            failure(error);
        }
    }];

}
@end
