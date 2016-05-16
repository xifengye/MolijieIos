//
//  NSQueue.m
//  MolijieIos
//
//  Created by yexifeng on 15/12/17.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSQueue.h"
@implementation NSQueue
@synthesize count;
- (id)init
{
    if( self=[super init] )
    {
        m_array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)enqueue:(id)anObject
{
    [m_array addObject:anObject];
}
- (id)dequeue
{
    id obj = nil;
    if(m_array.count > 0)
    {
        obj = [m_array objectAtIndex:0];
        [m_array removeObjectAtIndex:0];
    }
    return obj;
}
- (void)clear
{
    [m_array removeAllObjects];
}
- (int) count{
    return [m_array count];
}
@end
