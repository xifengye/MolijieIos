//
//  CartCell.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/17.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "CartCell.h"
#import "UIImageView+WebCache.h"
#import "AppDataTool.h"
@implementation CartCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"HomeCell";
    CartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[CartCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        //添加内部的子控件
        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews{
    UIButton* btnCheck = [[UIButton alloc]init];
    [btnCheck setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
    [btnCheck setImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateSelected];
    self.btnCheck = btnCheck;
    [self addSubview:btnCheck];
    
    UIImageView* iconView = [[UIImageView alloc]init];
    self.iconView = iconView;
    [self addSubview:iconView];
    
    UILabel* nameLabel = [[UILabel alloc]init];
    self.nameLabel = nameLabel;
    self.nameLabel.font = labelFont;
    [self addSubview:nameLabel];
    
    UILabel* priceLabel = [[UILabel alloc]init];
    self.priceLabel = priceLabel;
    self.priceLabel.font = labelFont;
    [self addSubview:priceLabel];
    
    UILabel* allPriceLabel = [[UILabel alloc]init];
    self.allPriceLabel = allPriceLabel;
    self.allPriceLabel.font = labelFont;
    self.allPriceLabel.textColor = [UIColor orangeColor];
    [self addSubview:allPriceLabel];
    
    UILabel* unitLabel = [[UILabel alloc]init];
    self.unitLabel = unitLabel;
    self.unitLabel.font = labelFont;
    [self addSubview:unitLabel];
    
    MGAmountView* amountView = [[MGAmountView alloc]init];
    self.amountView = amountView;
    [self addSubview:amountView];
    
    UIButton* btnDelete = [[UIButton alloc]init];
    [btnDelete setImage:[UIImage imageNamed:@"ico_delete"] forState:UIControlStateNormal];
    self.btnDelete = btnDelete;
    [self addSubview:btnDelete];
}

-(void)setOrderFrame:(OrderLocalFrame *)orderFrame{
    _orderFrame = orderFrame;
    self.btnCheck.frame = orderFrame.btnCheckF;
    self.btnDelete.frame = orderFrame.btnDeleteF;
    self.nameLabel.frame = orderFrame.nameLabelF;
    self.priceLabel.frame = orderFrame.priceLabelF;
    self.allPriceLabel.frame = orderFrame.allPriceLabelF;
    self.iconView.frame = orderFrame.iconF;
    self.amountView.frame = orderFrame.amountViewF;
    self.unitLabel.frame = orderFrame.unitLabelF;
    
    self.nameLabel.text = orderFrame.goods.Title;
    
    NSString* url = [AppDataTool imageUrlFor:UseForGoodSource withImgid:orderFrame.goods.MainResources[0]];
    [self.iconView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_pic"]];
    self.priceLabel.text = [NSString priceString:[orderFrame.goods getPriceBySkuIndex:orderFrame.order.skuIndex]];
    self.allPriceLabel.text = [NSString priceString:[orderFrame.goods getPriceBySkuIndex:orderFrame.order.skuIndex]*orderFrame.order.amount];
    self.unitLabel.text = [orderFrame.goods titleValusBySkuIndex:orderFrame.order.skuIndex];
    self.btnCheck.selected = true;
    self.allPriceLabel.text = [NSString priceString:[orderFrame.goods getPriceBySkuIndex:orderFrame.order.skuIndex]*orderFrame.order.amount];
    self.amountView.amount = orderFrame.order.amount;
}
@end
