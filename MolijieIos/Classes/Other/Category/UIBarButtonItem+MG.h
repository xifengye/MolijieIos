//
//  UIBarButtonItem+MG.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/10.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MG)
+(UIBarButtonItem*) itemWithButton:(NSString*)imageName highImage:(NSString*)highImageName target:(id)target action:(SEL)action;
@end
