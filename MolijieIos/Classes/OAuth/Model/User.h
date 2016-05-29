//
//  User.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/27.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"

@interface User : NSObject

@property(nonatomic,copy)NSString* Mobile;
@property(nonatomic,copy)NSString* password;
@property(nonatomic,copy)NSString* mProfile;
@property(nonatomic,copy)NSString* UserName;
@property(nonatomic,copy)NSString* Mail;
@property(nonatomic,copy)NSString* BirthDate;
@property(nonatomic,copy)NSString* NickName;
@property(nonatomic,copy)NSString* Gender;
@property(nonatomic,assign)BOOL autoLogin;
@property(nonatomic,strong)Token* userToken;

-(void)update:(User*)other;

@end
