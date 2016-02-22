//
//  RTTabbarViewController.m
//  RTHealth
//
//  Created by cheng on 14-10-15.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTTabbarViewController.h"
#import "RTTabbarItem.h"
#import "RTNewTrendsViewController.h"
#import "RTTrendsViewController.h"
#import "RTDiscoverViewController.h"
#import "RTPersonalTableViewController.h"
#import "RTMoreViewController.h"

@interface RTTabbarViewController ()

@end

@implementation RTTabbarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        curItemType = 6;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // init 5 view controllers
    RTPersonalTableViewController *homeController = [[RTPersonalTableViewController alloc] init];
    RTTrendsViewController *trendsController = [[RTTrendsViewController alloc]init];
    RTDiscoverViewController *discoverController = [[RTDiscoverViewController alloc]init];
    RTMoreViewController * settingController = [[RTMoreViewController alloc]init];
    
    //    tempController.tabBarDelegate = self;
    // ...add more
    
    
    tabBarItems = [NSArray arrayWithObjects:
                    [NSDictionary dictionaryWithObjectsAndKeys:@"personalselected.png",@"TabBarImages",@"personalunselected.png",@"TabBarImages1", @"个人",@"TabBarTitle",homeController, @"viewController", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"topicselected.png",@"TabBarImages",@"topicunselected.png",@"TabBarImages1", @"话题",@"TabBarTitle", trendsController, @"viewController", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"discoverselected.png",@"TabBarImages",@"discoverunselected.png",@"TabBarImages1", @"发现",@"TabBarTitle", discoverController, @"viewController", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"moreselected.png",@"TabBarImages",@"moreunselected.png",@"TabBarImages1", @"更多",@"TabBarTitle", settingController, @"viewController", nil],
                    nil];
    
    // Use the TabBarGradient image to figure out the tab bar's height (22x2=44)
//    UIImage* tabBarGradient = [UIImage imageNamed:@"tabmenubackground.png"];
    
    // Create a custom tab bar passing in the number of items, the size of each item and setting ourself as the delegate
    tabBar = [[RTTabbarItem alloc] initWithItemCount:tabBarItems.count
                                            itemSize:CGSizeMake(self.view.frame.size.width/(tabBarItems.count+1),TABBAR_HEIGHT)
                                                 tag:0
                                            delegate:self];
    // Place the tab bar at the bottom of our view
    tabBar.frame = CGRectMake(0,
                              SCREEN_HEIGHT-TABBAR_HEIGHT,
                              self.view.frame.size.width,
                              TABBAR_HEIGHT);
    [self.view addSubview:tabBar];
    // Select the first tab
    [tabBar selectItemAtIndex:0];
    [self touchDownAtItemAtIndex:0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:VIEWSHOULDLOAD object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */
#pragma mark JHTabBarDelegate

- (NSString*)titleFor:(RTTabbarItem*)tabBar atIndex:(NSUInteger)itemIndex
{
    NSDictionary* data = [tabBarItems objectAtIndex:itemIndex];
    return [data objectForKey:@"TabBarTitle"];
}

- (UIImage*)imageFor:(RTTabbarItem*)tabBar atIndex:(NSUInteger)itemIndex
{
    // Get the right data
    NSDictionary* data = [tabBarItems objectAtIndex:itemIndex];
    return [UIImage imageNamed:[data objectForKey:@"TabBarImages1"]];
    // Return the image for this tab bar item
    //    UIGraphicsBeginImageContext(CGSizeMake(16, 16));
    //    [[UIImage imageNamed:[data objectForKey:@"TabBarImages"]] drawInRect:CGRectMake(0,0, 16, 16)];
    //    UIImage *modify = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return modify;
}
- (UIImage*)imageforSelected:(RTTabbarItem*)tabBar atIndex:(NSUInteger)itemIndex
{
    // Get the right data
    NSDictionary* data = [tabBarItems objectAtIndex:itemIndex];
    return [UIImage imageNamed:[data objectForKey:@"TabBarImages"]];
    // Return the image for this tab bar item
    //    UIGraphicsBeginImageContext(CGSizeMake(16, 16));
    //    [[UIImage imageNamed:[data objectForKey:@"TabBarImages"]] drawInRect:CGRectMake(0,0, 16, 16)];
    //    UIImage *modify = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return modify;
}
- (UIImage*)imageForLighted:(RTTabbarItem*)tabBar atIndex:(NSUInteger)itemIndex
{
    // Get the right data
    NSDictionary* data = [tabBarItems objectAtIndex:itemIndex];
    return [UIImage imageNamed:[data objectForKey:@"TabBarImages1"]];
    // Return the image for this tab bar item
    //    UIGraphicsBeginImageContext(CGSizeMake(16, 16));
    //    [[UIImage imageNamed:[data objectForKey:@"TabBarImages"]] drawInRect:CGRectMake(0,0, 16, 16)];
    //    UIImage *modify = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return modify;
}

- (UIImage*)backgroundImage
{
    // The tab bar's width is the same as our width
    CGFloat width = self.view.frame.size.width;
    // Get the image that will form the top of the background
    //    UIImage* topImage = [UIImage imageNamed:@"tabbarbackground.png"];
    //    UIImage* topImage = [UIImage imageNamed:@"footer_80.png"];
    UIImage* topImage = [UIImage imageNamed:@"tabmenubackground.png"];
    // Create a new image context
    //  UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, topImage.size.height*2), NO, 0.0);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, topImage.size.height), NO, 0.0);
    
    // Create a stretchable image for the top of the background and draw it
    UIImage* stretchedTopImage = [topImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [stretchedTopImage drawInRect:CGRectMake(0, 0, width, topImage.size.height)];
    
    // Draw a solid black color for the bottom of the background
    [[UIColor whiteColor] set];
    //  CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, topImage.size.height, width, topImage.size.height));
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 55, width, 55));
    
    // Generate a new image
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

// This is the blue background shown for selected tab bar items
- (UIImage*)selectedItemBackgroundImage
{
    //  return [UIImage imageNamed:@"TabBarItemSelectedBackground.png"];
    return nil;
}

// This is the glow image shown at the bottom of a tab bar to indicate there are new items
- (UIImage*)glowImage
{
    //  UIImage* tabBarGlow = [UIImage imageNamed:@"TabBarGlow.png"];
    //
    //  // Create a new image using the TabBarGlow image but offset 4 pixels down
    //  UIGraphicsBeginImageContextWithOptions(CGSizeMake(tabBarGlow.size.width, tabBarGlow.size.height-4.0), NO, 0.0);
    //
    //  // Draw the image
    //  [tabBarGlow drawAtPoint:CGPointZero];
    //
    //  // Generate a new image
    //  UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    //  UIGraphicsEndImageContext();
    //
    //  return resultImage;
    return nil;
}

// This is the embossed-like image shown around a selected tab bar item
- (UIImage*)selectedItemImage
{
    // Use the TabBarGradient image to figure out the tab bar's height (22x2=44)
    UIImage* tabBarGradient = [UIImage imageNamed:@"itemChosen.png"];
    //  CGSize tabBarItemSize = CGSizeMake(self.view.frame.size.width/tabBarItems.count, tabBarGradient.size.height*2);
    //  UIGraphicsBeginImageContextWithOptions(tabBarItemSize, NO, 0.0);
    //
    //  // Create a stretchable image using the TabBarSelection image but offset 4 pixels down
    //  [[[UIImage imageNamed:@"TabBarSelection.png"] stretchableImageWithLeftCapWidth:4.0 topCapHeight:0] drawInRect:CGRectMake(0, 4.0, tabBarItemSize.width, tabBarItemSize.height-4.0)];
    //
    //  // Generate a new image
    //  UIImage* selectedItemImage = UIGraphicsGetImageFromCurrentImageContext();
    //  UIGraphicsEndImageContext();
    //
    //  return selectedItemImage;
    return tabBarGradient;
}

- (UIImage*)tabBarArrowImage
{
    //  return [UIImage imageNamed:@"TabBarNipple.png"];
    return nil;
}

- (void)touchDownAtMidItem
{
    NSLog(@"点击中间的button");
    RTNewTrendsViewController *newTrendsView = [[RTNewTrendsViewController alloc] init];
    [self.navigationController pushViewController:newTrendsView animated:YES];
}
- (void)touchDownAtItemAtIndex:(NSUInteger)itemIndex
{
    if(curItemType != itemIndex)
    {
        curItemType = itemIndex;
        // Remove the current view controller's view
        UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
        [currentView removeFromSuperview];
        
        // Get the right view controller
        NSDictionary* data = [tabBarItems objectAtIndex:itemIndex];
        UIViewController* viewController = [data objectForKey:@"viewController"];
        
        // Use the TabBarGradient image to figure out the tab bar's height (22x2=44)
        //UIImage* tabBarGradient = [UIImage imageNamed:@"TabBarGradientpng"];
        
        // Set the view controller's frame to account for the tab bar
        viewController.view.frame = CGRectMake(0, 0,
                                               self.view.frame.size.width,
                                               self.view.frame.size.height-50);
        
        // Se the tag so we can find it later
        viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
        
        // Add the new view controller's view
        [self.view insertSubview:viewController.view belowSubview:tabBar];
        [viewController viewWillAppear:YES];
        //    CATransition *animation = [CATransition animation];
        //    animation.delegate = self;
        //    animation.duration = 0;
        //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
        //    animation.fillMode = kCAFillModeForwards;
        //    animation.type = kCATransitionFade;
        //    animation.subtype = kCATransitionFromBottom;
        //    [self.view.layer addAnimation:animation forKey:@"animation"];
        
        // In 0.3 second glow the selected tab
        //    [NSTimer scheduledTimerWithTimeInterval:0
        //                                     target:self
        //                                   selector:@selector(addGlowTimerFireMethod:)
        //                                   userInfo:[NSNumber numberWithInteger:itemIndex]
        //                                    repeats:NO];
    }
}

- (void)addGlowTimerFireMethod:(NSTimer*)theTimer
{
    // Remove the glow from all tab bar items
    for (NSUInteger i = 0 ; i < tabBarItems.count ; i++)
    {
        [tabBar removeGlowAtIndex:i];
    }
    
    // Then add it to this tab bar item
    [tabBar glowItemAtIndex:[[theTimer userInfo] integerValue]];
}


@end
