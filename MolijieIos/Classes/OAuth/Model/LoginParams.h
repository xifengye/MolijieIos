//
//  LoginParams.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/13.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginParams : NSObject
@property(nonatomic,copy)NSString* username;

@property(nonatomic,copy)NSString* password;

@property(nonatomic,assign)BOOL autoLogin;

-(instancetype) initWithDictionary:(NSDictionary*)dictionary;
+(instancetype) accountWithDictionary:(NSDictionary*)dictionary;
@end
