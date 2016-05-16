//
//  NSDate+MG.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/18.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "NSDate+MG.h"

@implementation NSDate (MG)
-(BOOL)isToday{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents* nowComp = [calendar components:unit fromDate:[NSDate date]];
    
    NSDateComponents* selfComp = [calendar components:unit fromDate:self];
    
    return nowComp.year==selfComp.year && nowComp.month==selfComp.month && nowComp.day==selfComp.day;
}

-(BOOL)isThisYear{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents* nowComp = [calendar components:unit fromDate:[NSDate date]];
    
    NSDateComponents* selfComp = [calendar components:unit fromDate:self];
    
    return nowComp.year==selfComp.year;
}

-(BOOL)isYestoday{
    if([self isToday]){
        return false;
    }
    NSTimeInterval interval = ABS([self timeIntervalSinceNow]);
    if(interval>3600*48){
        return false;
    }
    return true;
}

/**
 today <1M return 刚刚
 today <1H return XM之前
 today >1H return XH之前
 
 yestoday  return 昨天  HH:mm
 
 >yestoday return MM-dd
 
 去年  return yyyy-MM-dd HH:mm
 
 **/
-(NSString *)timeFormatWithSina{
    NSTimeInterval interval = ABS([self timeIntervalSinceNow]);
    if(interval<60){
        return @"刚刚";
    }else if(interval<3600){
        return [NSString stringWithFormat:@"%d 分钟之前",(int)(interval/60)];
    }
    NSDateFormatter* format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm";
    if([self isThisYear]){//今年
        if([self isToday]){//今天
            if(interval<3600*5){//五个小时之内
                return [NSString stringWithFormat:@"%d 小时之前",(int)(interval/3600)];
            }else{
                format.dateFormat = @"HH:mm";
            }
        }else if([self isYestoday]){//昨天
            format.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"昨天 %@",[format stringFromDate:self]];
        }else{
            format.dateFormat = @"MM-dd HH:mm";
        }
    }
    return  [format stringFromDate:self];
}
@end
