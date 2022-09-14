//
//  AppDelegate.m
//  Example
//
//  Created by tako on 2022/9/14.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ViewController *viewController = [[ViewController alloc] init];
    _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [_window makeKeyAndVisible];
    _window.backgroundColor = [UIColor blackColor];
    
    return YES;
}


@end
