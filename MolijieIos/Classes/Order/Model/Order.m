//
//  Order.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/25.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "Order.h"
#import "MJExtension.h"
#import "Items.h"

@implementation Order

-(void)setItems:(id)is{
    if([is isKindOfClass:[NSDictionary class]]){
        _Items = [NSArray arrayWithObject:[Items objectWithKeyValues:is]];
    }else if([is isKindOfClass:[NSArray class]]){
        _Items = [Items objectArrayWithKeyValuesArray:is];
    }
}


-(NSString*)getOrderProgressText{
    switch(self.OrderProgress){
        case WaitForConfirm:
            return @"客户未确认";
        case WaitForProcess:
            return @"待处理";
        case Processing:
            return @"处理中";
        case Cancelled:
            return @"已取消";
        case Succeed:
            return @"交易成功";
        default:
            return @"未知状态";
    }
    
}

-(BOOL)canViewLogistics{
    return self.OrderProgress == Succeed || self.OrderProgress == Processing;
}

-(NSArray *)canDoArray{
    NSArray* clientSupportCanDoList = @[@"Cancel",@"ConfirmOrder",@"DeliverBack",@"ConfirmReceipt",@"Pay"];
    
    NSArray* cdl = [_CanDoList componentsSeparatedByString:@","];
    NSMutableArray* canDoArray = [NSMutableArray array];
    for(NSString* canDo in cdl){
        if([clientSupportCanDoList containsObject:canDo]){
            [canDoArray addObject:canDo];
        }
    }
    if([self canViewLogistics]){
        [canDoArray addObject:@"ViewLogistics"];
    }
    return canDoArray;
}

@end
