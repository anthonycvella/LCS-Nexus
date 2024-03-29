//
//  AppDelegate.m
//  LCS Nexus
//
//  Created by Vella, Anthony on 7/8/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Customize Status Bar Colors
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Customize UINavigationBar Colors
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:31.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:1]];

    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:20.0f]}];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:196.0/255.0 green:146.0/255.0 blue:70.0/255.0 alpha:1]];
    
    // Customize UITabBar Colors
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:196.0/255.0 green:146.0/255.0 blue:70.0/255.0 alpha:1]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:1]];
    
    return YES;
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
