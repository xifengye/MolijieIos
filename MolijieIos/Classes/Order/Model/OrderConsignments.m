//
//  OrderConsignments.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/29.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "OrderConsignments.h"

@implementation OrderConsignments
-(NSString*)SendFrom{
    NSUInteger index = [self.SendFrom rangeOfString:@"@"].location;
    NSString* detail = [self.SendFrom substringToIndex:index];
    NSArray* pcd =  [[self.SendFrom substringFromIndex:(index+1)] componentsSeparatedByString:@"/"];
    NSString* province = pcd[0];
    NSString* city = pcd[1];
    NSString* district = pcd[2];
    return [NSString stringWithFormat:@"%@%@%@%@",province,city,district,detail];
}
@end
