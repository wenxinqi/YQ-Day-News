//
//  AppDelegate.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/19.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "AppDelegate.h"
#import "YQTabBarController.h"
#import "YQStartViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
//    获取缓存的版本号
    NSString *versionCacha = [[NSUserDefaults standardUserDefaults] objectForKey:@"VersionCache"];
//    获取当前版本号
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    if (![versionCacha isEqualToString:currentVersion]) {
        YQStartViewController *startVc = [[YQStartViewController alloc] init];
        startVc.url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"qidong" ofType:@"mp4"]];
       
        [self.window makeKeyAndVisible];
        [UIApplication sharedApplication].keyWindow.rootViewController = startVc;
    
//        同步沙盒中的版本号
       [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"VersionCache"];
    }else{
        YQTabBarController *tabBarVc = [[YQTabBarController alloc] init];
        tabBarVc.tabBar.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha: 1];
        
        //    self.window.rootViewController = tabBarVc;
        
        [self.window makeKeyAndVisible];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    }
    
    
     
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
