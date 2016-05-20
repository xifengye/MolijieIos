//
//  MGBorderButton.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/20.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "MGBorderButton.h"

@implementation MGBorderButton
- (void)drawRect:(CGRect)rect{
    //创建路径并获取句柄
    CGMutablePathRef path = CGPathCreateMutable();
    //指定矩形
    CGRect rectangle = CGRectMake(rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    //将矩形添加到路径中
    CGPathAddRect(path,NULL,rectangle);
    //获取上下文
    CGContextRef currentContext =
    UIGraphicsGetCurrentContext();
    //将路径添加到上下文
    CGContextAddPath(currentContext, path);
    //设置矩形填充色
    [[UIColor whiteColor] setFill];
    //矩形边框颜色
    [[UIColor grayColor] setStroke];
    //边框宽度
    CGContextSetLineWidth(currentContext,1.0f);
    //绘制
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    CGPathRelease(path);
}

@end
