//
//  AppDelegate.m
//  MMISample
//
//  Created by mac on 23/04/15.
//  Copyright (c) 2015 mapmyindia. All rights reserved.
//

#import "AppDelegate.h"
#import "SlideNavigationController.h"
#import "LeftMenuViewController.h"
#import "MapViewController.h"
#import <MapmyIndiaAPIKit/MapmyIndiaAPIKit.h>

#define kMapAPIKEY @""
#define kMapSDKKey @""
#define kAtlastClientId @""
#define kAtlastClientSecret @""
#define kAtlastGrantType @"client_credentials"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [LicenceManager sharedInstance].restAPIKey=kMapAPIKEY;
    
    [LicenceManager sharedInstance].mapSDKKey=kMapSDKKey;
    
    MapmyIndiaAccountManager.restAPIKey = [LicenceManager sharedInstance].restAPIKey;
    MapmyIndiaAccountManager.mapSDKKey = [LicenceManager sharedInstance].mapSDKKey;
    MapmyIndiaAccountManager.atlasClientId = kAtlastClientId;
    MapmyIndiaAccountManager.atlasClientSecret = kAtlastClientSecret;
    MapmyIndiaAccountManager.atlasGrantType = kAtlastGrantType;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    MapViewController* mapVC = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    LeftMenuViewController *leftMenu = [[LeftMenuViewController alloc]initWithNibName:@"LeftMenuViewController"   bundle:nil];
    SlideNavigationController* controller=[[SlideNavigationController alloc]initWithRootViewController:mapVC];
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [controller.navigationBar setHidden:YES];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
