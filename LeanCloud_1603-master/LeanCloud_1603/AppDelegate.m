//
//  AppDelegate.m
//  LeanCloud_1603
//
//  Created by Chaosky on 16/9/7.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "AppDelegate.h"
// 导入LeanCloud头文件
#import <AVOSCloud/AVOSCloud.h>
// 崩溃报告
#import <AVOSCloudCrashReporting.h>

// 导入友盟头文件
#import <UMSocial.h>
// 新浪微博SSO授权
#import <UMSocialSinaSSOHandler.h>

#import "SkinStyle.h"

#import "TuicoolUser.h"
#import "SNSAccount.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 注册子类
    [TuicoolUser registerSubclass];
    [SNSAccount registerSubclass];
    
    // 开启崩溃报告
    [AVOSCloudCrashReporting enable];
    
    // 设置LeanCloud App ID
    [AVOSCloud setApplicationId:@"jk3NogXhPVlshqNq9nnDRsHG-gzGzoHsz" clientKey:@"NbpvCo529w9IKcdfsX6i2mDS"];
    // 跟踪应用分析
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // 设置友盟App Key
    [UMSocialData setAppKey:@"57d01c2ee0f55aa3130007a9"];
    // 新浪微博设置
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3793592596" secret:@"ce0f4df358944785341408bb59fa766e" RedirectURL:@"http://chaosky.me"];
    
    [SkinStyle configSkinStyle];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
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
