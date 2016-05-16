//
//  MGAccount.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/16.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 var CodeType:String = "";
 var Expire:Int64 = 0;
 var Value:String = "";
 var ExpireDate:NSDate?;
*/

@interface Token : NSObject<NSCoding>
@property(nonatomic,copy,readonly)NSString* token;
@property(nonatomic,copy)NSString* CodeType;
@property(nonatomic,assign)long long Expire;
@property(nonatomic,copy)NSString* Value;
@property(nonatomic,strong)NSDate* expireDate;

-(instancetype) initWithDictionary:(NSDictionary*)dictionary;
+(instancetype) accountWithDictionary:(NSDictionary*)dictionary;
@end
