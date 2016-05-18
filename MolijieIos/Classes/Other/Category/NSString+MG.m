//
//  NSString+MG.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/18.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "NSString+MG.h"

@implementation NSString (MG)
+(NSString *)priceString:(float)price{
    return [NSString stringWithFormat:@"¥%.1lf",price];
}

+(NSString *)pricesStr:(float)min price2:(float)max{
    return [NSString stringWithFormat:@"¥%.1lf ~ %.1lf",min,max];
}

+(NSString *)pricesString:(NSArray *)price{
    if(price==nil || price.count<=0){
        return @"";
    }
    NSNumber* min = price[0];
    
    if(price.count>1){
        NSNumber* max = price[1];
        return [self pricesStr:min.floatValue price2:max.floatValue];
    }
    return [self priceString:min.floatValue];
}
@end
