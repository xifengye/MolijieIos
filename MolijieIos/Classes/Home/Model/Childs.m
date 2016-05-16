//
//  Childs.m
//  MolijieIos
//
//  Created by yexifeng on 15/12/17.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "Childs.h"
#import "MJExtension.h"

@implementation Childs

-(void)setChilds:(id)chs{
    if([chs isKindOfClass:[NSDictionary class]]){
        _Childs = [NSArray arrayWithObject:[Childs objectWithKeyValues:chs]];
    }else if([chs isKindOfClass:[NSArray class]]){
        _Childs = [Childs objectArrayWithKeyValuesArray:chs];
    }
}

@end
