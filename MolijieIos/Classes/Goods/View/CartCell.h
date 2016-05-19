//
//  CartCell.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/17.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGAmountView.h"
#import "CartItemFrame.h"
@class CartCell;
@protocol CartCellDelegate <NSObject>

@optional
-(void)didGoodsAmountChange:(CartCell*)cell;
-(void)didGoodsCheckChange:(CartCell*)cell;
-(void)didGoodsRemoved:(CartCell*)cell;

@end

@interface CartCell : UITableViewCell<MGAmountViewDelegate>
+(instancetype) cellWithTableView:(UITableView*)tableView;
@property(nonatomic,weak)UIButton* btnCheck;
@property(nonatomic,weak)UIImageView* iconView;
@property(nonatomic,weak)UILabel* nameLabel;
@property(nonatomic,weak)UILabel* priceLabel;
@property(nonatomic,weak)UILabel* allPriceLabel;
@property(nonatomic,weak)UIButton* btnDelete;
@property(nonatomic,weak)UILabel* unitLabel;
@property(nonatomic,weak)MGAmountView* amountView;
@property(nonatomic,strong)CartItemFrame* cartItemFrame;
@property(nonatomic,weak)UIView* lineView;

@property(nonatomic,weak)id<CartCellDelegate> delegate;


@end
