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
    
    [self setupTabbarAppearance];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    UIViewController *homeVC = [self homeViewController];
    
    [tabBarController addChildViewController:homeVC];
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UIViewController *)homeViewController {
    MHHomeViewController *homeVC = [[MHHomeViewController alloc] initWithNibName:nil bundle:nil];
    homeVC.tabBarItem.image = [[UIImage imageNamed:@"icon_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_profile_selected"];
    homeVC.tabBarItem.title = [NSLocalizedString(@"Dashboard", nil) uppercaseString];
    
    return homeVC;
}

- (void)setupTabbarAppearance {
    UITabBar *appearance = [UITabBar appearance];
    [appearance setBarTintColor:UIColorFromRGB(0x68b7ef)];
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
