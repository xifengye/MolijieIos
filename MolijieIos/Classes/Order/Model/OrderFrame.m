//
//  OrderFrame.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/29.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "OrderFrame.h"
#import "OrderItemView.h"

@implementation OrderFrame
-(void)setOrder:(Order *)order{
    _order = order;
    float width = [UIScreen mainScreen].bounds.size.width;
    float margin = 5;
    float statusHeight = 35;
    CGSize statusSize = [[order getOrderProgressText] sizeWithFont:statusFont];
    self.statusF = CGRectMake(width-margin-statusSize.width, 0, statusSize.width, statusHeight);
    
    self.smF = CGRectMake(margin, 0, (width-statusSize.width-margin*2)/2, statusHeight);
    self.timeF = CGRectMake(CGRectGetMaxX(_smF), 0, CGRectGetWidth(_smF), statusHeight);
    self.itemsF = CGRectMake(0, statusHeight, width, order_item_height*order.Items.count);
    self.descF = CGRectMake(0, CGRectGetMaxY(_itemsF), width-margin, statusHeight);
    self.btnsF = CGRectMake(0, CGRectGetMaxY(_descF), width, 44);
    self.cellHeight = CGRectGetMaxY(_btnsF);
}
@end
