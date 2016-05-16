//
//  UIBadgeView.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/6.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGBadgeView.h"
#import "UIImage+MG.h"

@implementation MGBadgeView


- (MGBadgeView*)init
{
    self = [super init];
    if (self) {
        [self setBackgroundImage:[UIImage imageWithStretchable:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self setUserInteractionEnabled:false];

    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = [badgeValue copy];
    if(badgeValue){
        CGFloat sizeWithFont = [badgeValue sizeWithFont:self.titleLabel.font].width;
        CGFloat textWidth = self.currentBackgroundImage.size.width>sizeWithFont+10?self.currentBackgroundImage.size.width:sizeWithFont+10;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        CGRect frame = self.frame;
        frame.size.width = textWidth;
        frame.size.height=  self.currentBackgroundImage.size.height;
        self.frame = frame;
//        NSLog(@"%@,%@",badgeValue,NSStringFromCGRect(self.frame));
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }

}

@end
