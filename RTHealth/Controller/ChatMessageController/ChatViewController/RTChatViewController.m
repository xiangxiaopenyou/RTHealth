//
//  RTChatViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/12.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTChatViewController.h"
#import "JSMessagesViewController.h"
#import "AAPullToRefresh.h"
#import "RTMessageRequest.h"

@interface RTChatViewController ()<JSMessagesViewDelegate, JSMessagesViewDataSource,UITableViewDataSource>{
    UserInfo *userinfo;
    NSMutableArray *dataArray;
    Chat *chat;
    NSTimer *timer;
}

@end

@implementation RTChatViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    NSPredicate *preTemplate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"chatuserid=='%@'",self.friendID]];
    NSMutableArray *arrayNotRead = [NSMutableArray arrayWithArray:[[userinfo.chatSet allObjects] filteredArrayUsingPredicate:preTemplate]];
    if (arrayNotRead.count > 0){
        chat = [arrayNotRead objectAtIndex:0];
    }else{
        chat = [Chat MR_createEntity];
        chat.chatuserid = self.friendInfo.friendid;
        chat.chatusernickname = self.friendInfo.friendnickname;
        chat.chatuserphoto = self.friendInfo.friendphoto;
        [userinfo.chatSet addObject:chat];
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    }
//    chat = [Chat MR_findFirstByAttribute:@"chatuserid" withValue:self.friendID];
//    if (chat == nil) {
//        chat = [Chat MR_createEntity];
//        chat.chatuserid = self.friendInfo.friendid;
//        chat.chatusernickname = self.friendInfo.friendnickname;
//        chat.chatuserphoto = self.friendInfo.friendphoto;
//        [userinfo.chatSet addObject:chat];
//        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
//    }
    
    dataArray = [[NSMutableArray alloc]initWithArray:[chat.chatlist allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"chattime" ascending:YES];
    [dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    
    UIImageView *navigation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 20, 40, 40)];
    [button setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"消息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];

    
    self.title = @"ChatMessage";
    self.delegate = self;
    self.dataSource = self;
    
    AAPullToRefresh *tv = [self.tableView addPullToRefreshPosition:AAPullToRefreshPositionTop actionHandler:^(AAPullToRefresh *v){
        NSLog(@"fire from top");
        [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
        [v stopIndicatorAnimation];
    }];
    tv.imageIcon = [UIImage imageNamed:@"launchpad"];
    tv.borderColor = [UIColor whiteColor];
    
    if ([RTUtil isEmpty:chat.chatuserid]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self scrollToBottomAnimated:NO];
    //请求把未读置为已读
    [RTMessageRequest chatReadList:chat Success:^(id response){
        
        
    } failure:^(NSError *error){
        
    }];
    
    for (ChatList *list in chat.chatlist) {
        list.chatisread = @"2";
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerSchedule) userInfo:nil repeats:YES];
    [timer fire];
}
- (void)viewWillDisappear:(BOOL)animated{
    [timer invalidate];
}

- (void)timerSchedule{
    [RTMessageRequest getFreshChatList:chat Success:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            
            dataArray = [[NSMutableArray alloc]initWithArray:[chat.chatlist allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"chattime" ascending:YES];
            [dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
//            [self.tableView reloadData];
            
//            [self finishSend];
            if (self.tableView.contentOffset.y + (self.tableView.frame.size.height) >= self.tableView.contentSize.height-10) {
                [self.tableView reloadData];
                [self scrollToBottomAnimated:YES];
            }else{
                [self.tableView reloadData];
            }
        }else{
            //错误信息
        }
    }failure:^(NSError *error){
    }];

}

- (void)reloadTableView{
    
    [RTMessageRequest getChatList:chat Success:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            
            dataArray = [[NSMutableArray alloc]initWithArray:[chat.chatlist allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"chattime" ascending:YES];
            [dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
            [self.tableView reloadData];
            if (![RTUtil isEmpty:[response objectForKey:@"count"]]) {
                int row = [[response objectForKey:@"count"] intValue];
                @try {
                    
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
            }
        }else{
            //错误信息
        }
    }failure:^(NSError *error){
    }];
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

#pragma mark - Messages view delegate

- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    ChatList *chatTemp = [ChatList MR_createEntity];
    chatTemp.chatcontent = text;
    chatTemp.chattime = [CustomDate getDateString:[NSDate date]];
    [dataArray addObject:chatTemp];
    [chat.chatlistSet addObject:chatTemp];
    [[NSManagedObjectContext MR_defaultContext]MR_saveOnlySelfAndWait];
    [RTMessageRequest sendChatList:chatTemp Chat:chat Success:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            dataArray = [[NSMutableArray alloc]initWithArray:[chat.chatlist allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"chattime" ascending:YES];
            [dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
            
        }else{
            //错误信息
        }
    } failure:^(NSError *error){
    }];
    
    [self finishSend];
}

- (void)cameraPressed:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatList *temp = [dataArray objectAtIndex:indexPath.row];
    if ([temp.chattype integerValue]==1) {
        return JSBubbleMessageTypeIncoming;
    }else{
        return JSBubbleMessageTypeOutgoing;
    }
}

- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JSBubbleMessageStyleFlat;
}

- (JSBubbleMediaType)messageMediaTypeForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JSBubbleMediaTypeText;
}

- (UIButton *)sendButton
{
    return [UIButton defaultSendButton];
}

- (JSMessagesViewTimestampPolicy)timestampPolicy
{
    return JSMessagesViewTimestampPolicyEveryThree;
//    return JSMessagesViewTimestampPolicyAll;
}

- (JSMessagesViewAvatarPolicy)avatarPolicy
{
    return JSMessagesViewAvatarPolicyBoth;
}

- (JSAvatarStyle)avatarStyle
{
    return JSAvatarStyleCircle;
}

- (JSInputBarStyle)inputBarStyle
{
    return JSInputBarStyleFlat;
}

#pragma mark - Messages view data source
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatList *temp = [dataArray objectAtIndex:indexPath.row];
    return temp.chatcontent;
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatList *temp = [dataArray objectAtIndex:indexPath.row];
    return [CustomDate getDateTimeHHMMSS:temp.chattime];
}

- (UIImage *)avatarImageForIncomingMessage
{
    ImageCacheQueue *cacheQueue = [ImageCacheQueue sharedCache];
    UIImage *image = [cacheQueue tryToHitImageWithKey:[RTUtil urlZoomPhoto:chat.chatuserphoto]];
    if (image !=nil) {
        return image;
    }else{
        return [UIImage imageNamed:@"demo-avatar-jobs"];
    }
}

- (UIImage *)avatarImageForOutgoingMessage
{
    ImageCacheQueue *cacheQueue = [ImageCacheQueue sharedCache];
    UIImage *image = [cacheQueue tryToHitImageWithKey:[RTUtil urlZoomPhoto:userinfo.userphoto]];
    if (image !=nil) {
        return image;
    }else{
        return [UIImage imageNamed:@"demo-avatar-jobs"];
    }
}

- (id)dataForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
}

@end
