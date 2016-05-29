//
//  OrderItemView.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/29.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "OrderItemView.h"
#import "OrderFrame.h"


@implementation OrderItemView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        CGFloat margin = 7;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        UIImageView* iconView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, order_item_height-margin*2, order_item_height-margin*2)];
        self.iconView = iconView;
        self.iconView.image = [UIImage imageNamed:@"default_pic"];
        [self addSubview:iconView];
        float priceLabelWidth = 100;
        UILabel* nameLabel  =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+margin, 0, width-order_item_height-margin*3-priceLabelWidth, order_item_height/2)];
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        self.nameLabel.font = normalFont;
        
        UILabel* unitLabel  =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+margin, order_item_height/2, CGRectGetWidth(nameLabel.frame), order_item_height/2)];
        self.unitLabel = unitLabel;
        [self addSubview:unitLabel];
        self.unitLabel.font = normalFont;
        
        UILabel* priceLabel  =[[UILabel alloc]initWithFrame:CGRectMake(width-priceLabelWidth-margin, 0, priceLabelWidth, order_item_height/2)];
        self.priceLabel = priceLabel;
        [self addSubview:priceLabel];
        self.priceLabel.font = normalFont;
        self.priceLabel.textAlignment = NSTextAlignmentRight;

        UILabel* amountLabel  =[[UILabel alloc]initWithFrame:CGRectMake(width-priceLabelWidth-margin, order_item_height/2, priceLabelWidth, order_item_height/2)];
        self.amountLabel = amountLabel;
        [self addSubview:amountLabel];
        self.amountLabel.font = normalFont;
        self.amountLabel.textAlignment = NSTextAlignmentRight;
        
        
    }
    return self;
}

-(void)setItem:(Items *)item{
    _item = item;
    self.nameLabel.text = item.GoodTitle;
    self.unitLabel.text = [NSString stringWithFormat:@"包装规格:%@",item.SKUTitle];
    self.priceLabel.text = [NSString priceString:item.SKUPrice];
    self.amountLabel.text = [NSString stringWithFormat:@"X%d",item.Amount];
}
@end
