//
//  UICustomTabBar.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGTabBar.h"


@interface MGTabBar()



@end

@implementation MGTabBar

-(NSMutableArray*)tabButtons{
    if(_tabButtons==nil){
        _tabButtons=[NSMutableArray array];
    }
    return _tabButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:102/255.0 green:0 blue:0 alpha:1];
    }
    
    return self;
}

-(void)addTabItem:(UITabBarItem *)item{
    MGTabBarButton* btn = [[MGTabBarButton alloc] init];
    [btn setItem:item];
    [btn addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self.tabButtons addObject:btn];
    if(self.tabButtons.count==1){
        [self onButtonClicked:btn];
    }
    
}


-(void)onButtonClicked:(MGTabBarButton*)button{
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]){
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectBtn.tag to:button.tag];
    }
    self.selectBtn.selected = NO;
    button.selected = YES;
    self.selectBtn = button;
}

-(void)layoutSubviews{
    CGFloat width = self.frame.size.width/self.subviews.count;
    CGFloat height = self.frame.size.height;
    CGFloat y = 0;
    for (UIView* childView in self.tabButtons) {
        int index = [self.tabButtons indexOfObject:childView];
        CGFloat x = width * index;
        childView.tag = index;
        childView.frame = CGRectMake(x, y, width, height);
    }
}

@end
