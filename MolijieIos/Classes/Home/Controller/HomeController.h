//
//  MGHomeController.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTitleButton.h"
#import "BaseTableViewController.h"
#import "CycleScrollView.h"
#import "BaseViewController.h"

@interface HomeController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)CycleScrollView* scorllView;
@end
