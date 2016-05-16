//
//  GoodsListController.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/14.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"

@interface GoodsListController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)NSArray<Goods*>* goodsList;
@property(nonatomic,assign)NSUInteger pageNo;
@property(nonatomic,assign)NSString* cataId;
@property(nonatomic,assign)NSString* title;

@end
