//
//  MGUINavigationController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/9.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGNavigationController.h"


@interface MGNavigationController ()

@end

@implementation MGNavigationController

+(void)initialize{
//    navigationBar 的高度是64；
    

//    [self setNavBarTheme];
    [self setNavBarButtonItemTheme];
    
}

+(void) setNavBarButtonItemTheme{
    UIBarButtonItem* item = [UIBarButtonItem appearance];
   
    [item setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [item setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary* textAttr = [NSMutableDictionary dictionary];
    textAttr[UITextAttributeTextColor] = [UIColor orangeColor];
    textAttr[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    [item setTitleTextAttributes:textAttr forState:UIControlStateNormal];

     [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateDisabled];
//    NSMutableDictionary* disableTextAttr = [NSMutableDictionary dictionary];
//    disableTextAttr[UITextAttributeTextColor] = [UIColor grayColor];
//    [item setTitleTextAttributes:disableTextAttr forState:UIControlStateDisabled];
}

+(void) setNavBarTheme{
    UINavigationBar* navBar = [UINavigationBar appearance];
        [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        NSMutableDictionary* textAttr = [NSMutableDictionary dictionary];
        textAttr[UITextAttributeTextColor] = [UIColor redColor];
        textAttr[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
        [navBar setTitleTextAttributes:textAttr];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = TRUE;
    }
    [super pushViewController:viewController animated:animated];
}



@end
