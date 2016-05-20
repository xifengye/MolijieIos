//
//  SettlementCell.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "SettlementCell.h"
#import "UIImageView+WebCache.h"
#import "AppDataTool.h"
#import "Config.h"

@implementation SettlementCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"HomeCell";
    SettlementCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[SettlementCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    UILabel* amountView = [[UILabel alloc]init];
    self.amountView = amountView;
    self.amountView.font = labelFont;
    [self addSubview:amountView];
    
    
    UIView* lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor blackColor];
    self.lineView = lineView;
    [self addSubview:lineView];
    
}

-(void)setSettlementItemFrame:(SettlementItemFrame *)settlementItemFrame{
    _settlementItemFrame = settlementItemFrame;
    self.nameLabel.frame = settlementItemFrame.nameLabelF;
    self.priceLabel.frame = settlementItemFrame.priceLabelF;
    self.allPriceLabel.frame = settlementItemFrame.allPriceLabelF;
    self.iconView.frame = settlementItemFrame.iconF;
    self.amountView.frame = settlementItemFrame.amountViewF;
    self.unitLabel.frame = settlementItemFrame.unitLabelF;
    self.lineView.frame = CGRectMake(0, settlementItemFrame.cellHeight, [UIScreen mainScreen].bounds.size.width, 0.5f);
    
    self.nameLabel.text = settlementItemFrame.goods.Title;
    
    NSString* url = [AppDataTool imageUrlFor:UseForGoodSource withImgid:settlementItemFrame.goods.MainResources[0]];
    [self.iconView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_pic"]];
    self.priceLabel.text = [NSString priceString:[settlementItemFrame.goods getPriceBySkuIndex:settlementItemFrame.order.skuIndex]];
    self.unitLabel.text = [settlementItemFrame.goods titleValusBySkuIndex:settlementItemFrame.order.skuIndex];
    self.allPriceLabel.text = [NSString stringWithFormat:@"小计: %@",[NSString priceString:[_settlementItemFrame.goods getPriceBySkuIndex:_settlementItemFrame.order.skuIndex]*_settlementItemFrame.order.amount]];
    self.amountView.text = [NSString stringWithFormat:@"X %ld",settlementItemFrame.order.amount];
}

@end
