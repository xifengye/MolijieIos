//
//  CompositeSKUValue.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/15.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "CompositeSKUValue.h"

@implementation CompositeSKUValue


-(BOOL)isEqual:(id)object{
    if (![object isKindOfClass:[CompositeSKUValue class]]) {
        return NO;
    }
    CompositeSKUValue* other = object;
    return [self.Value isEqual:other.Value];
}
@end
