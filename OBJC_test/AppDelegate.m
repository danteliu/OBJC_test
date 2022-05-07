//
//  AppDelegate.m
//  OBJC_test
//
//  Created by liu dante on 2021/7/27.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HBDNavigationController.h"
#import "UIViewController+HBD.h"
#import "HBDNavigationBar.h"
#import "HomeVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:[[HomeVC alloc] init]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
