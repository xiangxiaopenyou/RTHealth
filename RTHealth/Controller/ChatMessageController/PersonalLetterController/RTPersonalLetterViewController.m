//
//  RTPersonalLetterViewController.m
//  RTHealth
//
//  Created by cheng on 14/11/7.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTPersonalLetterViewController.h"
#import "RTPersonalLetterTableViewCell.h"
#import "RTChatMessageTableViewCell.h"
#import "RTReplyViewController.h"
#import "RTPariseViewController.h"
#import "RTChatViewController.h"
#import "RTActivityRemindViewController.h"
#import "RTMessageSystemViewController.h"

@interface RTPersonalLetterViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UserInfo *userinfo;
    RTUserInfo *userData;
}

@end

@implementation RTPersonalLetterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAllMessage:) name:GETALLMESSAGE object:nil];
    
    userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    
    self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.chat allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"chatlasttime" ascending:NO];
    [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];

    
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
    
    self.tableview.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
}


- (void)refreshTable{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    userinfo = userData.userData;
    for (Reply *removeReply in userinfo.reply) {
        [removeReply MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    [RTMessageRequest getAllMessageListSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray removeAllObjects];
            self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.chat allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"chatlasttime" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
            
            [self doneLoadingTableViewData];
        }
    }failure:^(NSError *error){
        [self doneLoadingTableViewData];
    }];
}
- (void)loadMoreData{
    [RTMessageRequest getAllMessageListSuccess:^(id response){
        if ([[response objectForKey:@"state"]integerValue] == URL_NORMAL) {
            [self.dataArray removeAllObjects];
            self.dataArray = [[NSMutableArray alloc]initWithArray:[userinfo.chat allObjects]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"chatlasttime" ascending:NO];
            [self.dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        }
        [self doneLoadingTableViewData];
    }failure:^(NSError *error){
        [self doneLoadingTableViewData];
    }];
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getAllMessage:(NSNotification*)notification{
    NSLog(@"123");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableview reloadData];
}

#pragma mark - UITableView Delegate DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuserIndentifier = @"Cell";
    if (indexPath.row == 0) {
        
        RTChatMessageTableViewCell *chatCell = [[RTChatMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier];
        chatCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        chatCell.imageview.image = [UIImage imageNamed:@"replyimage.png"];
        chatCell.label.text = @"回复我的";
        
        if (userData.replyNumber && userData.replyNumber.intValue > 0) {
            chatCell.labelnotread.text = [NSString stringWithFormat:@"%@",userData.replyNumber];
            chatCell.labelnotread.hidden = NO;
        }else{
            chatCell.labelnotread.hidden = YES;
        }
        
        
        return chatCell;
    }else if(indexPath.row == 1){
        RTChatMessageTableViewCell *chatCell = [[RTChatMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier];
        chatCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        chatCell.imageview.image = [UIImage imageNamed:@"praiseimage.png"];
        chatCell.label.text = @"喜欢";
        
        if (userData.favoriteNumber && userData.favoriteNumber.intValue > 0) {
            chatCell.labelnotread.text = [NSString stringWithFormat:@"%@",userData.favoriteNumber];
            chatCell.labelnotread.hidden = NO;
        }else{
            chatCell.labelnotread.hidden = YES;
        }
        return chatCell;
        
    }else if (indexPath.row == 2){
        RTChatMessageTableViewCell *chatCell = [[RTChatMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier];
        chatCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        chatCell.imageview.image = [UIImage imageNamed:@"systemimage.png"];
        chatCell.label.text = @"系统";
        
        NSPredicate *preTemplate = [NSPredicate predicateWithFormat:@"systemmessageisread=='1'"];
        NSMutableArray *arrayNotRead = [NSMutableArray arrayWithArray:[[userinfo.systemmessage allObjects] filteredArrayUsingPredicate:preTemplate]];
        if (arrayNotRead.count ) {
            chatCell.labelnotread.text = [NSString stringWithFormat:@"%lu",(unsigned long)arrayNotRead.count];
            chatCell.labelnotread.hidden = NO;
        }else{
            chatCell.labelnotread.hidden = YES;
        }
        
        return chatCell;
    
    }else if (indexPath.row == 3){
        RTChatMessageTableViewCell *chatCell = [[RTChatMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier];
        chatCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        chatCell.imageview.image = [UIImage imageNamed:@"remindimage.png"];
        chatCell.label.text = @"活动提醒";
        
        if (userData.activityRemindNumber && userData.activityRemindNumber.intValue > 0) {
            chatCell.labelnotread.text = [NSString stringWithFormat:@"%@",userData.activityRemindNumber];
            chatCell.labelnotread.hidden = NO;
        }else{
            chatCell.labelnotread.hidden = YES;
        }
        
        return chatCell;
        
    }else{
        Chat *chat = [self.dataArray objectAtIndex:indexPath.row-4];
        RTPersonalLetterTableViewCell *cell = [[RTPersonalLetterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier data:chat];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    userData = [RTUserInfo getInstance];
    if (indexPath.row == 0) {
        userData.replyNumber = [NSNumber numberWithInt:0];
        RTReplyViewController *reply = [[RTReplyViewController alloc]init];
        [self.navigationController pushViewController:reply animated:YES];
    }else if (indexPath.row == 1){
        userData.favoriteNumber = [NSNumber numberWithInt:0];
        RTPariseViewController *priase = [[RTPariseViewController alloc]init];
        [self.navigationController pushViewController:priase animated:YES];
    }else if (indexPath.row == 2){
        userData.systemNumber = [NSNumber numberWithInt:0];
        RTMessageSystemViewController *message = [[RTMessageSystemViewController alloc]init];
        message.url = [NSString stringWithFormat:@"%@%@",URL_BASE,URL_MESSAGE_SYSTEM];
        message.title = @"系统";
        [self.navigationController pushViewController:message animated:YES];
    }else if (indexPath.row == 3){
        userData.activityRemindNumber = [NSNumber numberWithInt:0];
        RTActivityRemindViewController *activityRemind = [[RTActivityRemindViewController alloc]init];
        [self.navigationController pushViewController:activityRemind animated:YES];
    }else{
        Chat *chat = [self.dataArray objectAtIndex:indexPath.row-4];
        RTChatViewController *chatController = [[RTChatViewController alloc]init];
        chatController.friendID = chat.chatuserid;
        [self.navigationController pushViewController:chatController animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count+4;
}
//要求委托方的编辑风格在表视图的一个特定的位置。
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
    if (indexPath.row >3) {
        result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
    }
    return result;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{//设置是否显示一个可编辑视图的视图控制器。
    [super setEditing:editing animated:animated];
    [self.tableview setEditing:editing animated:animated];//切换接收者的进入和退出编辑模式。
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        
        Chat *chat = [self.dataArray objectAtIndex:indexPath.row-4];
        [userinfo.chatSet removeObject:chat];
        for (ChatList *chatlist in chat.chatlist) {
            [chatlist MR_deleteEntity];
        }[chat MR_deleteEntity];
        [self.dataArray removeObjectAtIndex:indexPath.row-4];
        [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
    }
}


@end
