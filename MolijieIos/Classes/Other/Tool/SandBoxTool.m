//
//  SendBoxTool.m
//  MolijieIos
//
//  Created by yexifeng on 15/12/3.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "SandBoxTool.h"
#import "AppDataMemory.h"

#define appTokenFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"appToken.data"]

#define userTokenFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userToken.data"]

#define userFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.data"]

@implementation SandBoxTool

+(void)saveAppToken:(Token *)token{
    if(token!=nil){
        [AppDataMemory instance].appToken = token;
        NSDate* now = [NSDate date];
        token.expireDate = [now dateByAddingTimeInterval:token.Expire];
        [NSKeyedArchiver archiveRootObject:token toFile:appTokenFile];
    }
}

+(Token *)appToken{
    NSDate* now = [NSDate date];
    Token* token = [NSKeyedUnarchiver unarchiveObjectWithFile:appTokenFile];
    if([now compare:token.expireDate] == NSOrderedAscending){
        [AppDataMemory instance].appToken = token;
        return token;
    }else{
        return nil;
    }
}

+(void)saveUserToken:(Token *)token{
    if(token!=nil){
        [AppDataMemory instance].user.userToken = token;
        NSDate* now = [NSDate date];
        token.expireDate = [now dateByAddingTimeInterval:token.Expire];
        [NSKeyedArchiver archiveRootObject:token toFile:userTokenFile];
    }
}

+(Token *)userToken{
    NSDate* now = [NSDate date];
    Token* token = [NSKeyedUnarchiver unarchiveObjectWithFile:userTokenFile];
    if([now compare:token.expireDate] == NSOrderedAscending){
        User* user = [SandBoxTool user];
        [[AppDataMemory instance].user update:user];
        [AppDataMemory instance].user.userToken = token;
        return token;
    }else{
        return nil;
    }
}

+(void)saveUser:(User *)user{
    if(user!=nil){
        [NSKeyedArchiver archiveRootObject:user toFile:userFile];
    }
}


+(User *)user{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:userFile];
}

@end
