//
//  AppDataMemory.m
//  MolijieIos
//
//  Created by yexifeng on 15/12/4.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "AppDataMemory.h"

@implementation AppDataMemory
static AppDataMemory*shareInstance = nil;
+(instancetype)instance{
    if(shareInstance==nil){
        shareInstance = [[self alloc]init];
        shareInstance.user = [[User alloc]init];
        shareInstance.orderDict = [NSMutableDictionary dictionary];
    }
    return shareInstance;
}


-(Childs*)findChildsContainChild:(NSArray<Childs*>*)chs cataId:(NSString*)cataId{
    if(chs==nil || chs.count<=0){
        return  nil;
    }
    for(Childs* child in chs){
        Childs* c = [self findChildContainChild:child cataId:cataId];
        if(c!=nil){
            return c;
        }
    }
    return nil;
}

-(Childs*)findChildContainChild:(Childs*)ch cataId:(NSString*)cataId{
    if(cataId==nil || cataId.length<=0){
        return nil;
    }
    if(ch!=nil){
        if([cataId isEqualToString: ch.ObjectID]){
            return ch;
        }else{
            return [self findChildsContainChild:ch.Childs cataId:cataId];
        }
    }
    return nil;
}


-(Childs*)getChilds:(NSString*)cataId{
    return [self findChildsContainChild:self.childs cataId:cataId];
}

-(Recipient *)defaultRecipient{
    for(Recipient* r in _recipients){
        if(r.AsDefault){
            return r;
        }
    }
    return nil;
}

-(void)addOrder:(Order *)order{
    if(![self.orderDict.allKeys containsObject:order.SN]){
        [self.orderDict setObject:order forKey:order.SN];
    }
}

-(void)addOrders:(NSArray *)orders{
    for(Order* order in orders){
        [self addOrder:order];
    }
}

@end
