//
//  ShowBigViewController.m
//  testKeywordDemo
//
//  Created by mei on 14-8-18.
//  Copyright (c) 2014年 Bluewave. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "ShowBigViewController.h"
@interface ShowBigViewController (){
    UIPageControl *pageControl;
}

@end

@implementation ShowBigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //设置导航栏的rightButton
    rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 61, 32);
    //[rightbtn setBackgroundImage:[UIImage imageNamed:@"complete.png"] forState:UIControlStateNormal];
    [rightbtn setTitle:[NSString stringWithFormat:@"完成(%lu)",(unsigned long)self.arrayOK.count] forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    rightbtn .titleLabel.font = [UIFont systemFontOfSize:14];
    [rightbtn addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    
    self.navigationItem.title = @"预览";
    
    [self layOut];
    
}

-(void)layOut{
    
    //arrayOK里存放选中的图片

 
    _scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
   // _btnOK = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 70,  30, 61, 32)];
    
    _scrollerview.pagingEnabled = YES;
    _scrollerview.bounces = NO;
    _scrollerview.showsHorizontalScrollIndicator = NO;
    //显示选中的图片的大图
    _scrollerview.backgroundColor = [UIColor whiteColor];
    _scrollerview.delegate = self;
    //NSLog(@"self.arrayOK.count is %d",self.arrayOK.count);
 
    for (int i=0; i<[self.arrayOK count]; i++) {
       ALAsset *asset=self.arrayOK[i];
        
        UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(i*_scrollerview.frame.size.width, 0, _scrollerview.frame.size.width, _scrollerview.frame.size.height)];
                   imgview.contentMode=UIViewContentModeScaleAspectFill;
                    imgview.clipsToBounds=YES;
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [imgview setImage:tempImg];
        [_scrollerview addSubview:imgview];
    }
    
    _scrollerview.contentSize = CGSizeMake((self.arrayOK.count) * (self.view.frame.size.width),0);
    [self.view addSubview:_scrollerview];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 40)];
    pageControl.numberOfPages = self.arrayOK.count;
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
    
}
-(void)complete:(UIButton *)sender{
    //NSLog(@"完成了,跳到主发布页面");
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageControl.currentPage = floor(scrollView.contentOffset.x/scrollView.frame.size.width);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
