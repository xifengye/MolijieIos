//
//  CartCell.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/17.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGAmountView.h"
#import "OrderLocalFrame.h"

@interface CartCell : UITableViewCell
+(instancetype) cellWithTableView:(UITableView*)tableView;
@property(nonatomic,weak)UIButton* btnCheck;
@property(nonatomic,weak)UIImageView* iconView;
@property(nonatomic,weak)UILabel* nameLabel;
@property(nonatomic,weak)UILabel* priceLabel;
@property(nonatomic,weak)UILabel* allPriceLabel;
@property(nonatomic,weak)UIButton* btnDelete;
@property(nonatomic,weak)UILabel* unitLabel;
@property(nonatomic,weak)MGAmountView* amountView;
@property(nonatomic,strong)OrderLocalFrame* orderFrame;
@property(nonatomic,weak)UIView* lineView;


@end
