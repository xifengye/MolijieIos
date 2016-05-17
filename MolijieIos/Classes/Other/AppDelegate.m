//
//  AppDelegate.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/4.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "NewFeatureController.h"
#import "LoginController.h"
#import "Token.h"
#import "SandBoxTool.h"
#import "AppDataTool.h"
#import "AppDataMemory.h"
#import "Library/SDWebImage/SDWebImageManager.h"
#import "DataBaseManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [DataBaseManager instance];
    if([SandBoxTool appToken]==nil){
        [self toLoginController];
    }else{
        [self onAppToken];
    }

    
  NSLog(@"application didFinish over");
    
    return YES;
}

-(void)onAppToken{
    NSLog(@"onAppToken=%@",[AppDataMemory instance].appToken.token);
    Token* userToken = [SandBoxTool userToken];
    if(userToken){//用户已登录
        BOOL isFirstOpenNewVersion = [NewFeatureController isFirstOpenNewVersion];
        if(isFirstOpenNewVersion){
            self.window.rootViewController = [[NewFeatureController alloc] init];
        }else{
            self.window.rootViewController = [[MainController alloc] init];
        }
    }else{//用户未登录
        [self toLoginController];
    }

}

-(void)toLoginController{
    UIViewController* loginController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginController"];
    self.window.rootViewController = loginController;
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

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
