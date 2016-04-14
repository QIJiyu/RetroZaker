//
//  AppDelegate.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerAppDelegate.h"
#import "ZakerTabBarController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "WXApiManager.h"

@interface ZakerAppDelegate ()

@end

@implementation ZakerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [self fingerprintIdentification];
    
    ZakerTabBarController *tabBarController = [[ZakerTabBarController alloc] init];
    _window.rootViewController = tabBarController;
    
    [_window makeKeyAndVisible];
    
    //向微信注册
    [WXApi registerApp:@"wxc20f5b913bddf9c7" withDescription:@"demo 2.0"];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
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
    [self fingerprintIdentification];
}

- (void)fingerprintIdentification {
    LAContext *authenticationContext = [[LAContext alloc] init];
    NSError *error = nil;
    BOOL isTouchIdAvailable = [authenticationContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (isTouchIdAvailable) {
        ZAKER_Log("Touch ID可以使用");
        [authenticationContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"放上你的小手手" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                ZAKER_Log(@"通过指纹验证");
            }else {
                ZAKER_Log(@"没有通过指纹验证 error.domain %@", error.domain);
                /*
                 1. 连续三次指纹识别错误的运行结果：
                 Error Domain=com.apple.LocalAuthentication Code=-1 "Aplication retry limit exceeded." UserInfo=0x1740797c0 {NSLocalizedDescription=Aplication retry limit exceeded.}
                 2. Touch ID功能被锁定，下一次需要输入系统密码时的运行结果：
                 Error Domain=com.apple.LocalAuthentication Code=-1 "Biometry is locked out." UserInfo=0x17407dc00 {NSLocalizedDescription=Biometry is locked out.}
                 3. 用户在Touch ID对话框中点击了取消按钮：
                 Error Domain=com.apple.LocalAuthentication Code=-2 "Canceled by user." UserInfo=0x17006c780 {NSLocalizedDescription=Canceled by user.}
                 4. 在Touch ID对话框显示过程中，背系统取消，例如按下电源键：
                 Error Domain=com.apple.LocalAuthentication Code=-4 "UI canceled by system." UserInfo=0x170065900 {NSLocalizedDescription=UI canceled by system.}
                 5. 用户在Touch ID对话框中点击输入密码按钮：
                 Error Domain=com.apple.LocalAuthentication Code=-3 "Fallback authentication mechanism selected." UserInfo=0x17407e040 {NSLocalizedDescription=Fallback authentication mechanism selected.}
                 */
            }
        }];
    }else {
        ZAKER_Log(@"Touch ID不可用");
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
