//
//  Goods.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/14.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "Goods.h"


@implementation Goods

-(void)setUnits:(id)units{
    if([units isKindOfClass:[NSDictionary class]]){
        _Units = [NSArray arrayWithObject:[Units objectWithKeyValues:units]];
    }else if([units isKindOfClass:[NSArray class]]){
        _Units = [Units objectArrayWithKeyValuesArray:units];
    }
}

-(NSDictionary*)getSkuByGroup{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    for(Units* unit in _Units){
        for(CompositeSKUValue* csv in unit.CompositeSKUValue){
            if(csv.Titile==nil || csv.Titile.length<=0){
                continue;
            }
            if(![dict.allKeys containsObject:csv.Titile]){
                NSMutableArray* arr = [NSMutableArray arrayWithObject:csv];
                [dict setObject:arr forKey:csv.Titile];
            }else{
                NSMutableArray* arr = dict[csv.Titile];
                if(![arr containsObject:csv]){
                    [arr addObject:csv];
                }
            }
        }
    }
    
    return dict;
}


-(BOOL)makePair:(CompositeSKUValue *)value other:(CompositeSKUValue *)other{
    for(Units* unit in _Units){
        BOOL oneExist = false;
        BOOL twoExist = false;
        for(CompositeSKUValue* csv in unit.CompositeSKUValue){
            if([csv.Value isEqualToString:value.Value]){
                oneExist = true;
            }
            if([csv.Value isEqualToString:other.Value]){
                twoExist = true;
            }
        }
        if(oneExist && twoExist){
            return true;
        }
    }
    return false;
}


-(NSUInteger)findUnitIndex:(NSArray *)skus{
    
    for(Units* unit in _Units){
        if(skus.count!=unit.CompositeSKUValue.count){
            continue;
        }
        BOOL find = true;
        for(CompositeSKUValue* csv in unit.CompositeSKUValue){
            BOOL findOne = false;
            for(CompositeSKUValue* c in skus){
                if([csv.Value isEqualToString:c.Value]){
                    findOne = true;
                }
            }
            find = findOne;
        }
        if(find){
            return unit.Number;
        }
    }
    return NSUIntegerMax;
}

-(NSArray *)getPrices{
    NSMutableArray* prices = [NSMutableArray array];
    CGFloat max=0;
    CGFloat min= MAXFLOAT;
    for (int i = 0; i < _Units.count; i++) {
        Units* u = _Units[i];
        CompositeSKUValue* c = u.CompositeSKUValue[0];
        if(c.Price>max){
            max = c.Price;
        }
        if(min>c.Price){
            min = c.Price;
        }
    }
    [prices addObject:[NSNumber numberWithFloat:min]];
    if(max-min>0.0001){
        [prices addObject:[NSNumber numberWithFloat:max]];
    }
    return prices;
}

-(CGFloat)getPrice{
    NSNumber* price = [self getPrices][0];
    return price.floatValue;
}


-(NSArray *)unitTitles{
    NSMutableArray* titles = [NSMutableArray array];
    for(Units* unit in _Units){
        for(CompositeSKUValue* csv in unit.CompositeSKUValue){
            if(![titles containsObject:csv.Value]){
                [titles addObject:csv.Value];
            }
        }
    }
    return titles;
}

-(NSString *)titleValusBySkuIndex:(NSUInteger)skuIndex{
    NSMutableString* titles = [NSMutableString string];
    for(Units* unit in _Units){
        if(unit.Number == skuIndex){
            for(CompositeSKUValue* csv in unit.CompositeSKUValue){
                [titles appendFormat:@"%@ ",csv.Value];
            }
            return titles;
        }
    }
    return @"";
}

-(CGFloat)getPriceBySkuIndex:(NSUInteger)skuIndex{
    for(Units* unit in _Units){
        if(unit.Number == skuIndex){
            CompositeSKUValue* c = unit.CompositeSKUValue[0];
            if(c){
                return c.Price;
            }
        }
    }
    return 0.0f;
}

@end
