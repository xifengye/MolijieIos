//
//  UICustomTabBar.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTabBarButton.h"
@class MGTabBar;

@protocol UICustomTabBarDelegate <NSObject>

@optional
-(void)tabBar:(MGTabBar*)tabBar didSelectedButtonFrom:(int)from to:(int)to;
@end

@interface MGTabBar : UIView
-(void)addTabItem:(UITabBarItem*)item;
@property (nonatomic,strong)NSMutableArray* tabButtons;
@property (nonatomic,weak) MGTabBarButton* selectBtn;
@property (nonatomic,weak) id<UICustomTabBarDelegate> delegate;
@end
