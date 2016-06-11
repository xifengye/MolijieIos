//
//  MGHomeController.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTitleButton.h"
#import "BaseViewController.h"
#import "CycleScrollView.h"

@interface HomeController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)CycleScrollView* scorllView;
@end
