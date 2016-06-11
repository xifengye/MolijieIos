//
//  ViewController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/4.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MainController.h"
#import "ArticleController.h"
#import "HomeController.h"
#import "CartController.h"
#import "MGNavigationController.h"
#import "MeController.h"
#import "MGTabBar.h"
#import "AppDataTool.h"
#import "SandBoxTool.h"
#import "AppDataMemory.h"
#import "DataBaseManager.h"
#import "NetData.h"


@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onLocalOrderChange:) name:local_order_change object:nil];
    [self initCustomTabBar];
    [self initViews];
    [self initData];
    
}

-(void)initData{
    [self requestData];
    [self updateBadge];
}


-(void)requestData{
    NSArray* types = @[[NetData dataWithType:LoadOrder param:nil],[NetData dataWithType:LoadConsignments param:nil]];
    [[NetDataRequest requestWithTypes:^{
        NSLog(@"Main requestNetData finish");
    } requestType:types]start];
}


-(void)updateBadge{
    [self updateCartBadge];
}

-(void)updateCartBadge{
    NSUInteger orderCount = [DataBaseManager instance].allOrder.count;
    NSString* cartBadge = nil;
    if(orderCount>0){
        cartBadge =  [NSString stringWithFormat:@"%ld",orderCount];
    }
    MGTabBarButton *cartTabBar = self.customTabBar.tabButtons[1];
    [cartTabBar setBadgeValue:cartBadge];

}

- (void) onLocalOrderChange:(NSNotification*) notification{
   [self updateCartBadge];
}


//View 被显示之时调用
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (UIView* childView in self.tabBar.subviews) {
        if([childView isKindOfClass:[UIControl class]]){
            [childView removeFromSuperview];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initViews{
    HomeController* homeController = [[HomeController alloc] init];
    ArticleController* articleController = [[ArticleController alloc] init];
    CartController* cartController = [[CartController alloc] init];
    cartController.isInTab = YES;
    MeController* meController = [[MeController alloc] init];
    
    [self addTabController:homeController tabTitle:@"首页" tabImage:@"main_home_unselected" tableSelectImage:@"main_home_selected"];
    [self addTabController:cartController tabTitle:@"购物车" tabImage:@"main_cart_unselected" tableSelectImage:@"main_cart_selected"];
    [self addTabController:articleController tabTitle:@"周刊" tabImage:@"main_article_unselected" tableSelectImage:@"main_article_selected"];
    [self addTabController:meController tabTitle:@"我" tabImage:@"main_me_unselected" tableSelectImage:@"main_me_selected"];

}

-(void)initCustomTabBar{
    MGTabBar* customTabBar = [[MGTabBar alloc] initWithFrame:self.tabBar.bounds];
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    self.customTabBar.delegate = self;
}


-(void)addTabController:(UIViewController*)tabViewController tabTitle:(NSString*)title tabImage:(NSString*)imageName tableSelectImage:(NSString*)selectImageName{
    tabViewController.title = title;
    tabViewController.tabBarItem.badgeValue = @"XX";
    //controller.title = title 等效于controller.tabBarItem.title = title;controller.nagivationItem.title = title;
    UIImage* image = [UIImage imageNamed:imageName];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabViewController.tabBarItem.image = image;
    UIImage* selectImage = [UIImage imageNamed:selectImageName];
    [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabViewController.tabBarItem.selectedImage = selectImage;
    MGNavigationController* navigationController = [[MGNavigationController alloc] initWithRootViewController:tabViewController];
    [self addChildViewController:navigationController];
    [self.customTabBar addTabItem:tabViewController.tabBarItem];

}

- (void)tabBar:(MGTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
    self.selectedIndex = to;
}

-(void)tabBarDidClickedPlusButton:(MGTabBar *)tabBar{
   
}

@end
