//
//  OrderLocalFrame.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/18.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"
#import "OrderLocal.h"
#import <UIKit/UIKit.h>
#import "NSString+MG.h"

@interface CartItemFrame : NSObject
@property(nonatomic,strong)Goods* goods;
@property(nonatomic,assign)OrderLocal* order;
@property(nonatomic,assign)CGFloat cellHeight;

-(void)setData:(OrderLocal*)order goods:(Goods*)goods;

@property(nonatomic,assign,readonly)CGRect btnCheckF;
@property(nonatomic,assign,readonly)CGRect iconF;
@property(nonatomic,assign,readonly)CGRect nameLabelF;
@property(nonatomic,assign,readonly)CGRect priceLabelF;
@property(nonatomic,assign,readonly)CGRect unitLabelF;
@property(nonatomic,assign,readonly)CGRect allPriceLabelF;
@property(nonatomic,assign,readonly)CGRect amountViewF;
@property(nonatomic,assign,readonly)CGRect btnDeleteF;
@end
