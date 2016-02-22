//
//  RTActivityPositionViewController.m
//  RTHealth
//
//  Created by 项小盆友 on 14/12/17.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTActivityPositionViewController.h"

@interface RTActivityPositionViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@end

@implementation RTActivityPositionViewController{
    CLLocationManager *locationManager;
    MKMapView *_mapView;
    CLLocation *location;
    UIButton *chooseButton;
}

@synthesize addressString, positionX, positionY;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *navigation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    navigation.image = [UIImage imageNamed:@"navigationbarbackground.png"];
    [self.view addSubview:navigation];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.text = @"活动地点";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BOLDFONT_17;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseButton.frame = CGRectMake(SCREEN_WIDTH - 50, 30, 50, 30);
    [chooseButton  setTitle:@"选择" forState:UIControlStateNormal];
    [chooseButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    chooseButton.titleLabel.font = SMALLFONT_14;
    [chooseButton addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
    chooseButton.enabled = NO;
    [self.view addSubview:chooseButton];
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f){
            [locationManager requestAlwaysAuthorization];
        }
        locationManager.delegate = self;
        locationManager.distanceFilter = 1000.0;
        [locationManager startUpdatingLocation];
    }
    else{
        NSLog(@"请开启定位效果");
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeStandard;
    CLLocationCoordinate2D coor2d = [[locations objectAtIndex:0] coordinate];
    //MKCoordinateSpan spn = MKCoordinateSpanMake(1, 1);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coor2d, 1000, 1000);
    [_mapView setRegion:region animated:NO];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressMap:)];
    [_mapView addGestureRecognizer:tap];
    [self.view addSubview:_mapView];
}

- (void)pressMap:(UIGestureRecognizer*)gesture{
    NSLog(@"xiang");
    //坐标转换
    CGPoint touchPoint = [gesture locationInView:_mapView];
    
    CLLocationCoordinate2D touchMapCoordinate = [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    positionX = touchMapCoordinate.latitude;
    positionY = touchMapCoordinate.longitude;
    CLLocation *locat = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    //NSLog(@"%f %f", touchMapCoordinate.latitude, touchMapCoordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locat completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks objectAtIndex:0];
        addressString = mark.name;
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate = touchMapCoordinate;
        pointAnnotation.title = addressString;
        [_mapView removeAnnotations:_mapView.annotations];
        [_mapView addAnnotation:pointAnnotation];
        chooseButton.enabled = YES;
        [chooseButton setTitleColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
    }];
}

#pragma mark - MKMapView Delegate
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
    
//    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
//    MKPinAnnotationView* customPinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
//    if (!customPinView) {
//        customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
//        
//        customPinView.pinColor = MKPinAnnotationColorRed;//设置大头针的颜色
//        customPinView.animatesDrop = YES;
//        customPinView.canShowCallout = YES;
//
//    }
//    else{
//        customPinView.annotation = annotation;
//    }
//    return customPinView;
//}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseClick{
    if ([RTUtil isEmpty:addressString]) {
        UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:@"提示" message:@"你选择的地点好像连地图都不知道唉~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        [self.delegate clickChooseButton];
        [self.navigationController popViewControllerAnimated:YES];
    }
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

@end
