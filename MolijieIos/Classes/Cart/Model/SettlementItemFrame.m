//
//  SettlementItemFrame.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "SettlementItemFrame.h"
#import "Config.h"

@implementation SettlementItemFrame
-(void)setData:(OrderLocal *)order goods:(Goods *)goods{
    _goods = goods;
    _order = order;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat margin = 7;
    CGFloat iconWidth = 100;
    _iconF = CGRectMake(margin, margin, iconWidth, iconWidth);
    
    CGFloat price = [goods getPriceBySkuIndex:order.skuIndex];
    CGSize priceLabelSize = [[NSString priceString:price] sizeWithFont:labelFont];
    _priceLabelF = CGRectMake(screenWidth-margin-priceLabelSize.width, margin, priceLabelSize.width, priceLabelSize.height);
    CGSize nameLabelSize = [goods.Title sizeWithFont:labelFont];
    _nameLabelF = CGRectMake(CGRectGetMaxX(_iconF)+margin, margin, nameLabelSize.width, nameLabelSize.height);
    
    CGSize amountViewSize = [[NSString stringWithFormat:@"X %ld",order.amount] sizeWithFont:labelFont];
    _amountViewF = CGRectMake(screenWidth-margin-amountViewSize.width, (iconWidth-nameLabelSize.height)/2, amountViewSize.width,amountViewSize.height);
    NSString* units = [_goods titleValusBySkuIndex:order.skuIndex];
    CGSize unitLabelSize = [units sizeWithFont:labelFont];
    _unitLabelF = CGRectMake(_nameLabelF.origin.x, (iconWidth-nameLabelSize.height)/2, unitLabelSize.width, unitLabelSize.height);
    
    CGSize allPriceLabelSize = [[NSString stringWithFormat:@"小计: %@",[NSString priceString:price*order.amount]] sizeWithFont:labelFont];
    _allPriceLabelF = CGRectMake(screenWidth-margin-allPriceLabelSize.width, iconWidth-allPriceLabelSize.height, allPriceLabelSize.width, allPriceLabelSize.height);
    
    
    _cellHeight = iconWidth+margin*2;
}
@end
