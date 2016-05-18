//
//  OrderLocalFrame.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/18.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "OrderLocalFrame.h"



@implementation OrderLocalFrame

-(void)setData:(OrderLocal *)order goods:(Goods *)goods{
    _goods = goods;
    _order = order;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat margin = 7;
    CGFloat iconWidth = 100;
    UIImage* checkedImg = [UIImage imageNamed:@"checkbox_checked"];
    _iconF = CGRectMake(margin*2+checkedImg.size.width, margin, iconWidth, iconWidth);
    
    _btnCheckF = CGRectMake(margin, margin+(iconWidth-checkedImg.size.height)/2, checkedImg.size.width, checkedImg.size.height);
    CGFloat price = [goods getPriceBySkuIndex:order.skuIndex];
    CGSize priceLabelSize = [[NSString priceString:price] sizeWithFont:labelFont];
    _priceLabelF = CGRectMake(screenWidth-margin-priceLabelSize.width, margin, priceLabelSize.width, priceLabelSize.height);
    CGSize nameLabelSize = [goods.Title sizeWithFont:labelFont];
    _nameLabelF = CGRectMake(CGRectGetMaxX(_iconF)+margin, margin, nameLabelSize.width, nameLabelSize.height);
    CGFloat amountViewHeight = 30;
    _amountViewF = CGRectMake(_nameLabelF.origin.x, iconWidth-amountViewHeight+margin, (screenWidth-margin*5-iconWidth)*0.55, amountViewHeight);
    NSString* units = [_goods titleValusBySkuIndex:order.skuIndex];
    CGSize unitLabelSize = [units sizeWithFont:labelFont];
    _unitLabelF = CGRectMake(_nameLabelF.origin.x, (iconWidth-nameLabelSize.height)/2, unitLabelSize.width, unitLabelSize.height);
    
    CGSize allPriceLabelSize = [[NSString priceString:price*order.amount] sizeWithFont:labelFont];
    _allPriceLabelF = CGRectMake(screenWidth-margin-allPriceLabelSize.width, (iconWidth-nameLabelSize.height)/2, allPriceLabelSize.width, allPriceLabelSize.height);
    
    UIImage* deleteImg = [UIImage imageNamed:@"ico_delete"];
    _btnDeleteF = CGRectMake(screenWidth-margin-deleteImg.size.width, margin+iconWidth-deleteImg.size.height, deleteImg.size.width, deleteImg.size.height);
    
    _cellHeight = iconWidth+margin*2;
}
@end
