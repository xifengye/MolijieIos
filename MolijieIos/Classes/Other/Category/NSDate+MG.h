//
//  NSDate+MG.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/18.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MG)
-(BOOL) isToday;
-(BOOL) isYestoday;
-(BOOL) isThisYear;
-(NSString*)timeFormatWithSina;
@end
