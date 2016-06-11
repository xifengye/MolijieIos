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
#import "Config.h"

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
    [btnCheck addTarget:self action:@selector(onCheckChange) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnCheck];
    
    UIImageView* iconView = [[UIImageView alloc]init];
    self.iconView = iconView;
    [self addSubview:iconView];
    
    UILabel* nameLabel = [[UILabel alloc]init];
    self.nameLabel = nameLabel;
    self.nameLabel.font = mljLabelFont;
    [self addSubview:nameLabel];
    
    UILabel* priceLabel = [[UILabel alloc]init];
    self.priceLabel = priceLabel;
    self.priceLabel.font = mljLabelFont;
    [self addSubview:priceLabel];
    
    UILabel* allPriceLabel = [[UILabel alloc]init];
    self.allPriceLabel = allPriceLabel;
    self.allPriceLabel.font = mljLabelFont;
    self.allPriceLabel.textColor = [UIColor orangeColor];
    [self addSubview:allPriceLabel];
    
    UILabel* unitLabel = [[UILabel alloc]init];
    self.unitLabel = unitLabel;
    self.unitLabel.font = mljLabelFont;
    [self addSubview:unitLabel];
    
    MGAmountView* amountView = [[MGAmountView alloc]init];
    self.amountView = amountView;
    self.amountView.delegate = self;
    [self addSubview:amountView];
    
    UIButton* btnDelete = [[UIButton alloc]init];
    [btnDelete setImage:[UIImage imageNamed:@"ico_delete"] forState:UIControlStateNormal];
    self.btnDelete = btnDelete;
    [self addSubview:btnDelete];
    [btnDelete addTarget:self action:@selector(onDelete) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor blackColor];
    self.lineView = lineView;
    [self addSubview:lineView];

}

-(void)setCartItemFrame:(CartItemFrame *)cartItemFrame{
    _cartItemFrame = cartItemFrame;
    self.btnCheck.frame = cartItemFrame.btnCheckF;
    self.btnDelete.frame = cartItemFrame.btnDeleteF;
    self.nameLabel.frame = cartItemFrame.nameLabelF;
    self.priceLabel.frame = cartItemFrame.priceLabelF;
    self.allPriceLabel.frame = cartItemFrame.allPriceLabelF;
    self.iconView.frame = cartItemFrame.iconF;
    self.amountView.frame = cartItemFrame.amountViewF;
    self.unitLabel.frame = cartItemFrame.unitLabelF;
    self.lineView.frame = CGRectMake(0, cartItemFrame.cellHeight, [UIScreen mainScreen].bounds.size.width, 0.5f);
    
    self.nameLabel.text = cartItemFrame.goods.Title;
    
    NSString* url = [AppDataTool imageUrlFor:UseForGoodSource withImgid:cartItemFrame.goods.MainResources[0]];
    [self.iconView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_pic"]];
    self.priceLabel.text = [NSString priceString:[cartItemFrame.goods getPriceBySkuIndex:cartItemFrame.order.skuIndex]];
    self.unitLabel.text = [cartItemFrame.goods titleValusBySkuIndex:cartItemFrame.order.skuIndex];
    self.btnCheck.selected = [cartItemFrame.order isCheck];
    self.allPriceLabel.text = [NSString priceString:[cartItemFrame.goods getPriceBySkuIndex:cartItemFrame.order.skuIndex]*cartItemFrame.order.amount];
    self.amountView.amount = cartItemFrame.order.amount;
    [self amountChange];
}

#pragma mark AmountView delegate

-(void)didAmountValueChange:(MGAmountView *)view{
    _cartItemFrame.order.amount = view.amount;
    [self amountChange];
    if([self.delegate respondsToSelector:@selector(didGoodsAmountChange:)]){
        [self.delegate didGoodsAmountChange:self];
    }
}

-(void)amountChange{
    self.allPriceLabel.text = [NSString stringWithFormat:@"小计: %@",[NSString priceString:[_cartItemFrame.goods getPriceBySkuIndex:_cartItemFrame.order.skuIndex]*_cartItemFrame.order.amount]];
}


-(void)onCheckChange{
    self.btnCheck.selected = !self.btnCheck.selected;
    [_cartItemFrame.order setCheck: self.btnCheck.selected];
    if([self.delegate respondsToSelector:@selector(didGoodsCheckChange:)]){
        [self.delegate didGoodsCheckChange:self];
    }
}

-(void)onDelete{
    if([self.delegate respondsToSelector:@selector(didGoodsRemoved:)]){
        [self.delegate didGoodsRemoved:self];
    }

}
@end
