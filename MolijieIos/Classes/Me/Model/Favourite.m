//
//  Favourite.m
//  MolijieIos
//
//  Created by yexifeng on 16/6/11.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "Favourite.h"

@implementation Favourite

-(BOOL)isEqual:(id)object{
    if(![object isKindOfClass:[Favourite class] ]){
        return false;
    }
    Favourite* other = object;
    return [other.CataID isEqualToString:self.CataID] && [other.ObjectID isEqualToString:self.ObjectID];
}
@end
