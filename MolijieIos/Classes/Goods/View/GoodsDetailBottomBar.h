//
//  GoodsDetailBottomBar.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/15.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGBadgeView.h"
@class GoodsDetailBottomBar;

@protocol UICustomTabBarDelegate <NSObject>

@optional
-(void)bottomBarDidClickedCar:(GoodsDetailBottomBar*)bottomBar;
-(void)bottomBarDidClickedFavourite:(GoodsDetailBottomBar*)bottomBar forStatus:(BOOL)status;
-(void)bottomBarDidClickedAdd:(GoodsDetailBottomBar*)bottomBar;
@end

@interface GoodsDetailBottomBar : UIView
@property(nonatomic,strong)UIButton* btnCar;
@property(nonatomic,strong)UIButton* btnFavourite;
@property(nonatomic,strong)UIButton* btnAdd;
@property(nonatomic,strong)MGBadgeView* badgeView;
@property (nonatomic,weak) id<UICustomTabBarDelegate> delegate;

@end
