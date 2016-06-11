//
//  Goods.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/14.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Units.h"
#import "Favourite.h"

@interface Goods : NSObject{
    Favourite* _favourite;
}
@property(nonatomic,copy)NSString* Title;
@property(nonatomic,copy)NSString* CataID;
@property(nonatomic,assign)BOOL NeedLogistics;//是否物流
@property(nonatomic,strong)NSArray* Units;
@property(nonatomic,strong)NSArray<NSString*>* MainResources;//商品主图
@property(nonatomic,copy)NSString* Contants;//商品描述
@property(nonatomic,copy)NSString* ObjectID;
@property(nonatomic,copy)NSString* SupplierID;//供应商ID


-(NSDictionary*)getSkuByGroup;

-(BOOL)makePair:(CompositeSKUValue*)value other:(CompositeSKUValue*)other;//配对
//根据选择的sku找出对应units 的skuIndex
-(NSUInteger)findUnitIndex:(NSArray*)skus;

-(NSArray*)getPrices;
-(CGFloat)getPrice;
-(NSArray*)unitTitles;
-(NSString*)titleValusBySkuIndex:(NSUInteger)skuIndex;

-(CGFloat)getPriceBySkuIndex:(NSUInteger)skuIndex;

-(Favourite*)favourite;
@end
