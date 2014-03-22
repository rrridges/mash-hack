//
//  MHAppDelegate.m
//  MashHack
//
//  Created by Matt Bridges on 3/22/14.
//  Copyright (c) 2014 Intrepid. All rights reserved.
//

#import "MHAppDelegate.h"
#import "MHTurbulenceMeter.h"
#import "MHHomeViewController.h"
#import "MHFlightViewController.h"
#import "MHFlightSearchViewController.h"
#import "MHMapViewController.h"
#import "MHTipsViewController.h"

@interface MHAppDelegate ()

@property (strong, nonatomic) MHTurbulenceMeter *meter;

@end

@implementation MHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.meter = [[MHTurbulenceMeter alloc] init];
    [self.meter start];
		
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self setupNavBarAppearance];
    [self setupTabbarAppearance];
    [self setupTabBarItemAppearance];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    [tabBarController addChildViewController:[self flightViewController]];
    [tabBarController addChildViewController:[self locationViewController]];
    [tabBarController addChildViewController:[self homeViewController]];
    [tabBarController addChildViewController:[self soundsViewController]];
    [tabBarController addChildViewController:[self tipsViewController]];
    
    [tabBarController setSelectedIndex:2];
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UIViewController *)homeViewController {
    MHHomeViewController *homeVC = [[MHHomeViewController alloc] initWithNibName:nil bundle:nil];
    homeVC.tabBarItem.image = [[UIImage imageNamed:@"tab_dashboard"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_dashboard_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.title = [NSLocalizedString(@"Dashboard", nil) uppercaseString];
    
    return homeVC;
}

- (UIViewController *)flightViewController {
    MHFlightSearchViewController *flightVC = [[MHFlightSearchViewController alloc] init];
    flightVC.tabBarItem.image = [[UIImage imageNamed:@"tab_plane"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    flightVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_plane_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    flightVC.tabBarItem.title = [NSLocalizedString(@"Flight", nil) uppercaseString];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:flightVC];
    
    return navController;
}

- (UIViewController *)locationViewController {
    UIViewController *locationVC = [[MHMapViewController alloc] init];
    locationVC.tabBarItem.image = [[UIImage imageNamed:@"tab_location"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    locationVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_location_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    locationVC.tabBarItem.title = [NSLocalizedString(@"Location", nil) uppercaseString];
    
    return locationVC;
}

- (UIViewController *)soundsViewController {
    UIViewController *soundsVC = [[UIViewController alloc] init];
    soundsVC.tabBarItem.image = [[UIImage imageNamed:@"tab_sounds"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    soundsVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_sounds_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    soundsVC.tabBarItem.title = [NSLocalizedString(@"Sounds", nil) uppercaseString];
    
    return soundsVC;
}

- (UIViewController *)tipsViewController {
    UIViewController *tipsVC = [[MHTipsViewController alloc] init];
    tipsVC.tabBarItem.image = [[UIImage imageNamed:@"tab_tip"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tipsVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_tip_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tipsVC.tabBarItem.title = [NSLocalizedString(@"Tips", nil) uppercaseString];

    return tipsVC;
}

- (void)setupNavBarAppearance {
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    [appearance setBarTintColor:UIColorFromRGB(0x2b60a4)];
}

- (void)setupTabbarAppearance {
    UITabBar *appearance = [UITabBar appearance];
    [appearance setBarTintColor:UIColorFromRGB(0x68b7ef)];
}

- (void)setupTabBarItemAppearance {
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"ProximaNovaCond-Regular" size:9],
                                         NSForegroundColorAttributeName: UIColorFromRGB(0xFFFFFF)} forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"ProximaNovaCond-Regular" size:9],
                                         NSForegroundColorAttributeName: UIColorFromRGB(0x000000)} forState:UIControlStateSelected];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
