//
//  LoginParams.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/13.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "LoginParams.h"

@implementation LoginParams

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.autoLogin = [aDecoder decodeBoolForKey:@"autoLogin"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeBool:self.autoLogin forKey:@"autoLogin"];
}

@end
