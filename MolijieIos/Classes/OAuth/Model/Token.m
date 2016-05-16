//
//  MGAccount.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/16.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "Token.h"

@implementation Token

+(Token *)accountWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc]initWithDictionary:dictionary];
}

-(Token *)initWithDictionary:(NSDictionary *)dictionary{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.CodeType = [aDecoder decodeObjectForKey:@"CodeType"];
        self.Expire = [aDecoder decodeInt64ForKey:@"Expire"];
        self.Value = [aDecoder decodeObjectForKey:@"Value"];
        self.expireDate = [aDecoder decodeObjectForKey:@"expireDate"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.CodeType forKey:@"CodeType"];
    [aCoder encodeInt64:self.Expire forKey:@"Expire"];
    [aCoder encodeObject:self.Value forKey:@"Value"];
    [aCoder encodeObject:self.expireDate forKey:@"expireDate"];
}

-(NSString *)token{
    return [NSString stringWithFormat:@"%@.%lld.%@",self.CodeType,self.Expire,self.Value];
}
@end
