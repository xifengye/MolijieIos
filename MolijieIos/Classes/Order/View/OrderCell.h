//
//  OrderCell.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/29.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrderFrame.h"
@class OrderCell;

@protocol OrderCellDelegate <NSObject>

@optional
-(void)onOrderOperate:(NSInteger)btnTag order:(Order*)order;

@end

@interface OrderCell : UITableViewCell

@property(nonatomic,strong)OrderFrame* orderFrame;

@property(nonatomic,weak)UILabel* smLabel;
@property(nonatomic,weak)UILabel* timeLabel;
@property(nonatomic,weak)UILabel* statusLabel;
@property(nonatomic,weak)UILabel* descLabel;
@property(nonatomic,weak)UIView* items;
@property(nonatomic,weak)UIView* btns;

@property(nonatomic,weak)id<OrderCellDelegate> delegate;
@end
