//
//  OrderFrame.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/29.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
#define timeFont [UIFont systemFontOfSize:13]
#define normalFont [UIFont systemFontOfSize:15]
#define statusFont [UIFont boldSystemFontOfSize:15]

@interface OrderFrame : NSObject
@property(nonatomic,strong)Order* order;
@property(nonatomic,assign)float cellHeight;

@property(nonatomic,assign)CGRect smF;
@property(nonatomic,assign)CGRect timeF;
@property(nonatomic,assign)CGRect statusF;
@property(nonatomic,assign)CGRect itemsF;
@property(nonatomic,assign)CGRect descF;
@property(nonatomic,assign)CGRect btnsF;

@end
