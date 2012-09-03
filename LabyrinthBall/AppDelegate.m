//
//  AppDelegate.m
//  LabyrinthBall
//
//  Created by Rose CW on 9/3/12.
//  Copyright (c) 2012 Rose and Liam. All rights reserved.
//

#import "AppDelegate.h"
#import "LabyrinthViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    LabyrinthViewController* lvc = [LabyrinthViewController new];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = lvc;

    [self.window makeKeyAndVisible];
    return YES;
}



@end
