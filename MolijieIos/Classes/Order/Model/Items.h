//
//  Items.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/25.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Items : NSObject
@property(nonatomic,assign)int Amount;
@property(nonatomic,assign)int SKU_UnitNumber;
@property(nonatomic,copy)NSString* GoodID;
@property(nonatomic,copy)NSString* SKUTitle;
@property(nonatomic,assign)CGFloat SKUPrice;
@property(nonatomic,copy)NSString* GoodTitle;
@property(nonatomic,copy)NSString* SupplierID;
@end
