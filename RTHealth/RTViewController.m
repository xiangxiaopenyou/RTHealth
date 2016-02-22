//
//  RTViewController.m
//  RTHealth
//
//  Created by cheng on 14/10/24.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RTViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"


#define BIG_IMG_WIDTH  200.0
#define BIG_IMG_HEIGHT 200.0
@interface RTViewController ()
{
    UIView *background;
}

@end

@implementation RTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loadingView = [[RTLoadingViewController alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)amplificationWithImage:(UIImageView *)image
{
    MJPhoto *photo = [[MJPhoto alloc]init];
    photo.image = image.image;
    photo.srcImageView = image;
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    browser.photos = [[NSMutableArray alloc]initWithObjects:photo, nil];
    browser.currentPhotoIndex = 0;
    [browser show];
}
//    //创建灰色透明背景，使其背后内容不可操作
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    background = bgView;
//    [bgView setBackgroundColor:[UIColor colorWithRed:0.3
//                                               green:0.3
//                                                blue:0.3
//                                               alpha:0.7]];
//    [self.view.superview addSubview:bgView];
//   
//    
//    //创建显示图像视图
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((320-image.size.width)/2, (SCREEN_HEIGHT-image.size.height)/2, image.size.width, image.size.height)];
//    [imgView setImage:image];
//    [bgView addSubview:imgView];
//    [self shakeToShow:imgView];//放大过程中的动画
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(narrow)];
//    [bgView addGestureRecognizer:tap];
//    //动画效果
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:1];
//    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//    [UIView setAnimationDelegate:bgView];
//    // 动画完毕后调用animationFinished
//    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
//    [UIView commitAnimations];
//}
//-(void)narrow
//{
//    [UIView animateWithDuration:0.2 animations:^(){
//        background.alpha = 0.0f;
//    }completion:^(BOOL finished){
//        [background removeFromSuperview];
//    }];
//}
//
////放大过程中出现的缓慢动画
//
//- (void) shakeToShow:(UIView*)aView{
//    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.3;
//    
//    NSMutableArray *values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    [aView.layer addAnimation:animation forKey:nil];
//}

@end
