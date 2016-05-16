//
//  CompositeSKUValue.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/15.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompositeSKUValue : NSObject
@property(nonatomic,copy)NSString* Value;
@property(nonatomic,assign)NSUInteger Amount;
@property(nonatomic,copy)NSString* SKUID;
@property(nonatomic,strong)NSArray<NSString*>* Resources;
@property(nonatomic,assign)float Price;
@property(nonatomic,copy)NSString* Titile;
@end
