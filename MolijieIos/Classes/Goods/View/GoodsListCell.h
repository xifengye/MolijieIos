//
//  GoodsListCell.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/15.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"

#define labelHeight 20

@interface GoodsListCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel* priceLabel;
@property(nonatomic,strong)Goods* goods;
@end
