//
//  Order.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/25.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipient.h"
#import <UIKit/UIKit.h>

@interface Order : NSObject

@property(nonatomic,strong)NSArray* Items;
@property(nonatomic,strong)Recipient* Recipient;

@property(nonatomic,copy)NSString* Created;
@property(nonatomic,copy)NSString* CreatedText;
@property(nonatomic,assign)int Freight;
@property(nonatomic,assign)CGFloat TotalPrice;
@property(nonatomic,copy)NSString* CustomerID;
@property(nonatomic,assign)CGFloat SavedPrice;
@property(nonatomic,copy)NSString* SN;
@property(nonatomic,copy)NSString* PayState;
@property(nonatomic,copy)NSString* SupplierCode;
@property(nonatomic,copy)NSString* CanDoList;
@property(nonatomic,assign)int OrderProgress;
@property(nonatomic,copy)NSString* Payment;

@end
