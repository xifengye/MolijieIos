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

-(void)setRecipient:(id)Recipient{
    NSDictionary*d  = Recipient;
    _Recipient = [Recipient objectWithKeyValues:d];
}

-(void)setItems:(id)is{
    if([is isKindOfClass:[NSDictionary class]]){
        _Items = [NSArray arrayWithObject:[Items objectWithKeyValues:is]];
    }else if([is isKindOfClass:[NSArray class]]){
        _Items = [Items objectArrayWithKeyValuesArray:is];
    }
}
@end
