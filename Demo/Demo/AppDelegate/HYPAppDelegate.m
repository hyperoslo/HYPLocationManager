//
//  HYPAppDelegate.m
//  Demo
//
//  Created by Elvis Nunez on 3/17/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "HYPAppDelegate.h"
#import "HYPRootViewController.h"

@implementation HYPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    HYPRootViewController *mainController = [[HYPRootViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end