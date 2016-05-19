//
//  SettlementCell.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettlementItemFrame.h"

@interface SettlementCell : UITableViewCell

+(instancetype) cellWithTableView:(UITableView*)tableView;
@property(nonatomic,weak)UIImageView* iconView;
@property(nonatomic,weak)UILabel* nameLabel;
@property(nonatomic,weak)UILabel* priceLabel;
@property(nonatomic,weak)UILabel* allPriceLabel;
@property(nonatomic,weak)UILabel* unitLabel;
@property(nonatomic,weak)UILabel* amountView;
@property(nonatomic,strong)SettlementItemFrame* settlementItemFrame;
@property(nonatomic,weak)UIView* lineView;

@end
