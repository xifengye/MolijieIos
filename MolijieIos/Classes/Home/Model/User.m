//
//  User.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/17.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "User.h"

@implementation User

//+(instancetype)userWithDict:(NSDictionary*)dict{
//    return [[self alloc]initWithDict:dict];
//}
//-(instancetype)initWithDict:(NSDictionary*)dict{
//    if(self = [super init]){
//        self.name = dict[@"name"];
//        self.profile_image_url = dict[@"profile_image_url"];
//        self.ID = dict[@"id"];
//    }
//    return self;
//}

-(void)setGender:(NSString *)gender{
    if([@"m" isEqualToString:gender]){
        _gender = @"男";
    }else if([@"f" isEqualToString:gender]){
        _gender  = @"女";
    }
    else if([@"n" isEqualToString:gender]){
        _gender  = @"未知";
    }
}

@end
