//
//  RTAppDelegate.h
//  RTHealth
//
//  Created by cheng on 14-10-15.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AsyncImageDownloader.h"


@interface RTAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,WeiboSDKDelegate,TencentSessionDelegate,CLLocationManagerDelegate,MKMapViewDelegate,AsyncImageDownloaderDelegate>{
    TencentOAuth* _tencentOAuth;
    NSMutableArray* _permissions;
    CLLocationManager *locationManager;
    NSTimer *timer;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) UINavigationController *rootNavigationController;
@property (nonatomic,retain) NSString *updateUrl;


- (void)sharedQQFriendTitle:(NSString*)title description:(NSString*)description url:(NSString*)urlString Photo:(NSString*)photoUrl;
- (void)sharedQZoneTitle:(NSString*)title description:(NSString*)description url:(NSString*)urlString Photo:(NSString*)photoUrl;

- (void) sendLinkContentTimeLine:(NSString*)title Description:(NSString*)description Url:(NSString*)urlString Photo:(NSString*)photoUrl;
- (void) sendLinkContent:(NSString*)title Description:(NSString*)description Url:(NSString*)urlString Photo:(NSString*)photoUrl;

- (void)sharedWeiboTimeLine:(NSString*)content Photo:(UIImage*)photo;
- (void)sharedWeiboTimeLine:(NSString*)content Description:(NSString*)description objectID:(NSString*)objectid url:(NSString*)utlString;
- (void)sharedWeiboTimeLine:(NSString*)content Description:(NSString*)description objectID:(NSString*)objectid url:(NSString*)utlString photo:(NSData*)data;
@end
