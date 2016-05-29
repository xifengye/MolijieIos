//
//  OrderItemView.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/29.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Items.h"
#import "NSString+MG.h"

#define order_item_height   80

@interface OrderItemView : UIView

@property(nonatomic,strong)Items* item;

@property(nonatomic,weak)UIImageView* iconView;
@property(nonatomic,weak)UILabel* nameLabel;
@property(nonatomic,weak)UILabel* unitLabel;
@property(nonatomic,weak)UILabel* priceLabel;
@property(nonatomic,weak)UILabel* amountLabel;
@end
