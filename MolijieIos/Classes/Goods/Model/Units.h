//
//  Units.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/15.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "CompositeSKUValue.h"

@interface Units : NSObject
@property(nonatomic,strong)NSArray<CompositeSKUValue*>* compositeSKUValues;
@property(nonatomic,assign)NSUInteger number;
@end
