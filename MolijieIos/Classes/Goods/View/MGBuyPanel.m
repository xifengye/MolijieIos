//
//  MGBuyPanel.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/16.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "MGBuyPanel.h"
#import "UIImage+MG.h"
#import "Units.h"

@implementation MGBuyPanel

-(instancetype)initWithFrame:(CGRect)frame andGoods:(Goods*)goods{
    self = [super initWithFrame:frame];
    if(self){
        _goods = goods;
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.95f];
        CGFloat margin = 10;
        CGFloat closeBtnWidth = 50.0f;
        UIButton* btnClose = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-closeBtnWidth-margin, margin, closeBtnWidth, closeBtnWidth)];
        [btnClose setImage:[UIImage imageNamed:@"btn_close_on"] forState:UIControlStateNormal];
        [btnClose setImage:[UIImage imageNamed:@"btn_close_off"] forState:UIControlStateHighlighted];
        self.btnClose = btnClose;
        [btnClose addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btnClose];
        
        CGFloat iconViewWidth = 80;
        UIImageView* iconView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, iconViewWidth, iconViewWidth)];
        [iconView setImage:[UIImage imageNamed:@"default_pic"]];
        self.icon= iconView;
        [self addSubview:iconView];
        
        UIFont* font = [UIFont systemFontOfSize:15];
        CGFloat labelWidth = frame.size.width-iconViewWidth-margin*3;
        CGFloat labelHeight = [@"100" sizeWithFont:font].height;
        UILabel* priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+margin, margin, labelWidth , labelHeight)];
        [priceLabel setFont:font];
        priceLabel.text = @"444.40";
        self.priceLabel = priceLabel;
        [self addSubview:priceLabel];
        
        UILabel* remineLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+margin, margin*2+labelHeight, labelWidth , labelHeight)];
        [remineLabel setFont:font];
        remineLabel.text = @"库存42件";
        self.remineLabel = remineLabel;
        [self addSubview:remineLabel];

        UILabel* unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+margin, margin*3+labelHeight*2, labelWidth , labelHeight)];
        [unitLabel setFont:font];
        self.unitLabel = unitLabel;
        unitLabel.text = @"[瓶]";
        [self addSubview:unitLabel];

        CGFloat btnOkWidth = 100;
        UIButton* btnOk = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width-btnOkWidth)/2, frame.size.height-barHeight, btnOkWidth, barHeight)];
        [btnOk setTitle:@"确定" forState:UIControlStateNormal];
        [btnOk setBackgroundImage:[UIImage createImageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        [btnOk setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
        [btnOk addTarget:self action:@selector(onOk) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btnOk];
        self.btnOk = btnOk;
    
        [self initSkuVies];
        
    }
    return self;
}

-(void)initSkuVies{
    for(Units* unit in _goods.Units){
        for(CompositeSKUValue* csv in unit.compositeSKUValues){
            
        }
    }
}

-(void)onClose{
    if([self.delegate respondsToSelector:@selector(didBuyPanelCancel:)]){
        [self.delegate didBuyPanelCancel:self];
    }
}

-(void)onOk{
    if([self.delegate respondsToSelector:@selector(didBuyPanelOk:selectSkuIndex:)]){
        [self.delegate didBuyPanelOk:self selectSkuIndex:selectSkuIndex];
    }
}


@end
