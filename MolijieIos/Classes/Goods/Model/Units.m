//
//  Units.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/15.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "Units.h"


@implementation Units



-(void)setCompositeSKUValue:(id)compositeSKUValues{
    if([compositeSKUValues isKindOfClass:[NSDictionary class]]){
        _CompositeSKUValue = [NSArray arrayWithObject:[CompositeSKUValue objectWithKeyValues:compositeSKUValues]];
    }else if([compositeSKUValues isKindOfClass:[NSArray class]]){
        _CompositeSKUValue = [CompositeSKUValue objectArrayWithKeyValuesArray:compositeSKUValues];
    }

}

@end
