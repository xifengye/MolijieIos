//
//  ViewController.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/4.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTabBar.h"

@interface MainController : UITabBarController<UICustomTabBarDelegate>
@property(nonatomic,weak) MGTabBar* customTabBar;
@end

