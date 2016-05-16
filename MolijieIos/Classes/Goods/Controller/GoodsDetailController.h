//
//  GoodsDetailController.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/15.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
#import "CycleScrollView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface GoodsDetailController : UIViewController
@property(nonatomic,strong)Goods* goods;
@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,strong)CycleScrollView* cycleScrollView;
@end
