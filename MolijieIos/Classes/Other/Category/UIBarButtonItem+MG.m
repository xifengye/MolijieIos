//
//  UIBarButtonItem+MG.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/10.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "UIBarButtonItem+MG.h"

@implementation UIBarButtonItem (MG)
+(UIBarButtonItem*) itemWithButton:(NSString*)imageName highImage:(NSString*)highImageName target:(id)target action:(SEL)action{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlEventTouchUpInside];
    button.bounds = (CGRect){CGPointZero,button.currentImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
