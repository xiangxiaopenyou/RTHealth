//
//  RTFriendDetailInfoViewController.m
//  RTHealth
//
//  Created by cheng on 14/12/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTFriendDetailInfoViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"


@interface RTFriendDetailInfoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *titleData;
    UITableView *tableview;
    UIImageView *imageView;
}

@end

@implementation RTFriendDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    titleLabel.text = @"TA的信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = TITLE_COLOR;
    [self.view addSubview:titleLabel];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, NAVIGATIONBAR_HEIGHT+10, SCREEN_WIDTH-20, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-20)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.layer.borderWidth=1.0;
    tableview.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    tableview.layer.cornerRadius = 5;
    tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
            [imageView setOnlineImage:[RTUtil urlPhoto:self.friendInfo.friendphoto]];
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
        }break;
        case 1:{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 170, 4, 140, 40)];
            label.text = self.friendInfo.friendnickname;
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:label];
        }break;
        case 2:{
            UIImageView *seximageview = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width - 60, 13, 19, 23)];
            if ([self.friendInfo.friendsex integerValue]==1) {
                seximageview.image = [UIImage imageNamed:@"sex_boy_image.png"];
            }else{
                seximageview.image = [UIImage imageNamed:@"sex_girl_image.png"];
            }
            [cell.contentView addSubview:seximageview];
        }break;
        case 3:{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 170, 4, 140, 40)];
            label.text = self.friendInfo.friendbirthday;
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:label];
        }break;
        case 4:{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 170, 4, 140, 40)];
            label.text = self.friendInfo.friendheight;
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:label];
        }break;
        case 5:{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 170, 4, 140, 40)];
            label.text = self.friendInfo.friendweight;
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:label];
        }break;
        case 6:{
            if (![RTUtil isEmpty:self.friendInfo.friendfavoritesports]) {
                
                NSArray *favorite = [self.friendInfo.friendfavoritesports componentsSeparatedByString:@":"];
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
            CGSize framesize = [self.friendInfo.friendintroduce sizeWithFont:VERDANA_FONT_14
                                                   constrainedToSize:CGSizeMake(210.0, MAXFLOAT)
                                                       lineBreakMode:NSLineBreakByCharWrapping];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 240, 16, 210, framesize.height)];
            label.text = self.friendInfo.friendintroduce;
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
- (void)clickbtn:(UIButton*)btn
{
    MJPhoto *photo = [[MJPhoto alloc]init];
    [photo setUrl:[NSURL URLWithString:[RTUtil urlPhoto:self.friendInfo.friendphoto]]];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7){
        CGSize framesize = [self.friendInfo.friendintroduce sizeWithFont:VERDANA_FONT_14
                                               constrainedToSize:CGSizeMake(210.0, MAXFLOAT)
                                                   lineBreakMode:NSLineBreakByCharWrapping];
        if (framesize.height <18){
            return 49;
        }
        return 32+framesize.height;
        
    }
    return 49;
}

@end
