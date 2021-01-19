//
//  AppDelegate.m
//  TestRuntime
//
//  Created by Arthur on 2020/4/21.
//  Copyright © 2020 coderqi. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MainViewController * main = [[MainViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:main];
    
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}




@end
