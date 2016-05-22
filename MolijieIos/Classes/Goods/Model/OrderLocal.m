//
//  Order.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/17.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "OrderLocal.h"

@implementation OrderLocal

-(instancetype)init{
    self = [super init];
    if(self){
        checked = true;
    }
    return self;
}

-(BOOL)isMe:(OrderLocal *)other{
    if(other==nil){
        return false;
    }
    return [_cataId isEqualToString:other.cataId] && [_objectId isEqualToString:other.objectId] && _skuIndex==other.skuIndex;
}

-(void)setCheck:(BOOL)check{
    checked = check;
}

-(BOOL)isCheck{
    return checked;
}

-(NSString*)toJsonString{
    return [NSString stringWithFormat:@"{\"SupplierID\":\"%@\",\"GoodID\":\"%@\",\"SKU_UnitNumber\":%ld,\"Amount\":%ld}",@"",_objectId,_skuIndex,_amount];
}

@end
