//
//  User.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/27.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "User.h"

@implementation User
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.Mobile = [aDecoder decodeObjectForKey:@"Mobile"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.mProfile = [aDecoder decodeObjectForKey:@"mProfile"];
        self.UserName = [aDecoder decodeObjectForKey:@"UserName"];
        self.Mail = [aDecoder decodeObjectForKey:@"Mail"];
        self.BirthDate = [aDecoder decodeObjectForKey:@"BirthDate"];
        self.NickName = [aDecoder decodeObjectForKey:@"NickName"];
        self.Gender = [aDecoder decodeObjectForKey:@"Gender"];
        self.autoLogin = [aDecoder decodeBoolForKey:@"autoLogin"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.Mobile forKey:@"Mobile"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.mProfile forKey:@"mProfile"];
    [aCoder encodeObject:self.UserName forKey:@"UserName"];
    [aCoder encodeObject:self.Mail forKey:@"Mail"];
    [aCoder encodeObject:self.BirthDate forKey:@"BirthDate"];
    [aCoder encodeObject:self.NickName forKey:@"NickName"];
    [aCoder encodeObject:self.Gender forKey:@"Gender"];
    [aCoder encodeBool:self.autoLogin forKey:@"autoLogin"];
}

-(void)update:(User *)other{
    if(other){
        self.Mobile = other.Mobile;
        self.password = other.password;
        self.mProfile = other.mProfile;
        self.UserName = other.UserName;
        self.Mail = other.Mail;
        self.BirthDate = other.BirthDate;
        self.NickName = other.NickName;
        self.Gender = other.Gender;
        self.autoLogin = other.autoLogin;
    }
}
@end
