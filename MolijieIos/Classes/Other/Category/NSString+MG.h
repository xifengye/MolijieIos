//
//  NSString+MG.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/18.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MG)

+(NSString *)priceString:(float)price;
+(NSString*)pricesString:(NSArray*)price;

@end
