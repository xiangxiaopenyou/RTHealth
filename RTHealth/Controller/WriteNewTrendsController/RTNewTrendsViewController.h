//
//  RTNewTrendsViewController.h
//  RTHealth
//
//  Created by 项小盆友 on 14/10/28.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYQAssetPickerController.h"
#import "MessagePhotoMenuItem.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface RTNewTrendsViewController : UIViewController<UIActionSheetDelegate>{
    UIActionSheet *photoActionSheet;
}

@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIImageView *topImageView;
//@property (strong, nonatomic) IBOutlet UILabel *submitLabel;

@property (strong, nonatomic) UILabel *trendClassifyLabel;
@property (strong, nonatomic) UIImageView *projectTypeImageView;
@property (strong, nonatomic) UILabel *positionLabel;
@property (strong, nonatomic) UIImageView *positionImage;
@property (strong, nonatomic) UIButton *choosePositionButton;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIView *synView;
@property (strong, nonatomic) UIImageView *weiboSynImage;
@property (strong, nonatomic) UIImageView *qqZoneSynImage;
@property (strong, nonatomic) UIImageView *weixinSynImage;
@property (strong, nonatomic) UIView *toolView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;

// (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *photoMenuItems;
@property (nonatomic, strong) NSMutableArray *itemArray;

@property (nonatomic, strong) UserInfo *userinfo;



- (IBAction)backButton:(id)sender;
- (IBAction)submitButtonClick:(id)sender;

@end
