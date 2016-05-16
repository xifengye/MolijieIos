//
//  NetData.m
//  MolijieIos
//
//  Created by yexifeng on 15/12/17.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "NetData.h"


@implementation NetData
+(instancetype)dataWithType:(NetDataType)type param:(id)param{
    return [[self alloc]initWithType:type param:param];
}

-(instancetype)initWithType:(NetDataType)type param:(id)param{
    self = [super init];
    if (self) {
        _type = type;
        _param = param;
    }
    return self;
}


@end
