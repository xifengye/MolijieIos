//
//  SettlementItemFrame.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartItemFrame.h"

@interface SettlementItemFrame : NSObject
@property(nonatomic,strong)Goods* goods;
@property(nonatomic,assign)OrderLocal* order;
@property(nonatomic,assign)CGFloat cellHeight;

-(void)setData:(OrderLocal*)order goods:(Goods*)goods;

@property(nonatomic,assign,readonly)CGRect iconF;
@property(nonatomic,assign,readonly)CGRect nameLabelF;
@property(nonatomic,assign,readonly)CGRect priceLabelF;
@property(nonatomic,assign,readonly)CGRect unitLabelF;
@property(nonatomic,assign,readonly)CGRect allPriceLabelF;
@property(nonatomic,assign,readonly)CGRect amountViewF;
@end
