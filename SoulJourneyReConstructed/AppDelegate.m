//
//  AppDelegate.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/14.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "AppDelegate.h"
#import "BmobSDK/Bmob.h"
#import "MyTabBarController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    MyTabBarController *mainController = [[MyTabBarController alloc] init];
    self.window.rootViewController = mainController;
    [self.window makeKeyAndVisible];
    
    //Bmob's Appkey
    [Bmob registerWithAppKey:@"373b2e4632978a8c2a7b3214a1f1ca34"];
    
    //Gaode Map's key
    [AMapServices sharedServices].apiKey = @"1da96ae4f1cf565b8798ba942323efe3";
    
    NSLog(@"AppDelegate/<didFinishLaunchingWithOptions> DONE...");
    
    //MARK: - 全局使用
    
    //MARK: - NSUserDefualts的key
    ///当前用户名
    self.UD_CurrentUserName = @"UD_CurrentUserName";
    ///当前的登录状态
    self.UD_LoginStatus = @"UD_LoginStatus";
    ///用户头像
    self.UD_UserImageUrl = @"UD_UserImageUrl";
    
    
    //MARK: -数据接口
    ///首页的头视图
    self.URL_Header = @"http://q.chanyouji.com/api/v1/adverts.json";
    ///首页
    self.URL_HomePage = @"http://q.chanyouji.com/api/v2/destinations.json";
    ///首页列表  area=china  area为参数名，值有china，asia，europe
    self.URL_HomeList = @"http://q.chanyouji.com/api/v2/destinations/list.json";
    ///足迹列表  page:页数  per:每一页的个数
    self.URL_TrackList = @"http://q.chanyouji.com/api/v1/timelines.json";
    ///首页详情 需拼接id.json
    self.URL_HomePageDetail = @"http://q.chanyouji.com/api/v3/destinations/";
    ///根据定位推荐附近景点 lat=30.66459165966441    lng=104.03882239208
    self.URL_NearList = @"http://q.chanyouji.com/api/v2/destinations/nearby.json";
    ///某个范围内的 area=china   asia 亚洲  europe欧洲
    self.URL_AreaList = @"http://q.chanyouji.com/api/v2/destinations/list.json";
    

    
    
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
