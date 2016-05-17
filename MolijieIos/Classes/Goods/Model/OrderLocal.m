//
//  Order.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/17.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "OrderLocal.h"

@implementation OrderLocal

-(BOOL)isMe:(OrderLocal *)other{
    if(other==nil){
        return false;
    }
    return [_cataId isEqualToString:other.cataId] && [_objectId isEqualToString:other.objectId] && _skuIndex==other.skuIndex;
}
@end
