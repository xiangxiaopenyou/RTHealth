//
//  RTWebModelViewController.h
//  RTHealth
//
//  Created by cheng on 15/1/6.
//  Copyright (c) 2015年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface RTWebModelViewController : UIViewController<UIWebViewDelegate, UIScrollViewDelegate, EGORefreshTableHeaderDelegate>{
    //下拉视图
    EGORefreshTableHeaderView * _refreshHeaderView;
    //刷新标识，是否正在刷新过程中
    BOOL _reloading;
    
    UIWebView *webView_;
    UIActivityIndicatorView *indicatorView;
}

- (void)refreshPage;
@end
