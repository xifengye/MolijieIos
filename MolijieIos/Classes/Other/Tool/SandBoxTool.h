//
//  SendBoxTool.h
//  MolijieIos
//
//  Created by yexifeng on 15/12/3.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"
#import "LoginParams.h"

@interface SandBoxTool : NSObject

+(Token*)appToken;
+(void)saveAppToken:(Token*)token;

+(Token*)userToken;
+(void)saveUserToken:(Token*)token;


+(void)saveLoginParams:(LoginParams*)loginParams;
+(LoginParams*)loginParams;
@end
