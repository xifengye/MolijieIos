//
//  MGBuyPanel.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/16.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGUnitView.h"
#import "Goods.h"
@class MGBuyPanel;
#define barHeight    44

@protocol UIBuyPanelDelegate <NSObject>

@optional
-(void)didBuyPanelOk:(MGBuyPanel*)panel selectSkuIndex:(NSUInteger)skuIndex;
-(void)didBuyPanelCancel:(MGBuyPanel*)panel;
@end

@interface MGBuyPanel : UIView
{
    NSUInteger selectSkuIndex;
}
-(instancetype)initWithFrame:(CGRect)frame andGoods:(Goods*)goods;
@property(nonatomic,strong)UIButton* btnClose;
@property(nonatomic,strong)UILabel* priceLabel;
@property(nonatomic,strong)UILabel* remineLabel;
@property(nonatomic,strong)UILabel* unitLabel;
@property(nonatomic,strong)UIImageView* icon;
@property(nonatomic,strong)NSDictionary* unitViews;
@property(nonatomic,strong)UIButton* btnOk;

@property(nonatomic,weak)id<UIBuyPanelDelegate> delegate;

@property(nonatomic,strong)Goods* goods;

@end
