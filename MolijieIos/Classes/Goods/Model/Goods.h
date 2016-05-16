//
//  Goods.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/14.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Units.h"

@interface Goods : NSObject
@property(nonatomic,copy)NSString* Title;
@property(nonatomic,copy)NSString* CataID;
@property(nonatomic,assign)BOOL NeedLogistics;//是否物流
@property(nonatomic,strong)NSArray<Units*>* Units;
@property(nonatomic,strong)NSArray<NSString*>* MainResources;//商品主图
@property(nonatomic,copy)NSString* Contants;//商品描述
@property(nonatomic,copy)NSString* ObjectID;
@property(nonatomic,copy)NSString* SupplierID;//供应商ID
@end
