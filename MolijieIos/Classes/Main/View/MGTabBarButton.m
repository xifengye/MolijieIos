//
//  UICustomTabBarButton.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/6.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGTabBarButton.h"
#import "MGBadgeView.h"
#define UICustomTabBarButtonRatio 0.6

@interface MGTabBarButton()
@property(nonatomic,strong)UITabBarItem* item;
@property(nonatomic,weak)MGBadgeView* badgeView;
@end

@implementation MGTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor colorWithRed:252/255.0 green:253/255.0 blue:254/255.0 alpha:1] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:252/255.0 green:79/255.0 blue:0 alpha:1] forState:UIControlStateSelected];
        
        MGBadgeView* badgeView = [[MGBadgeView alloc] init];
        badgeView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.badgeView = badgeView;
        [self addSubview:badgeView];

    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height*UICustomTabBarButtonRatio, contentRect.size.width, contentRect.size.height*(1-UICustomTabBarButtonRatio));
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*UICustomTabBarButtonRatio);
}

-(void)setItem:(UITabBarItem *)item{
    _item = item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    [self setBadgeValue:item.badgeValue];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self setBadgeValue:[change objectForKey:@"new"]];
}

-(void)setBadgeValue:(NSString*)badgeValue{
    _badgeView.badgeValue = badgeValue;
    CGRect frame = _badgeView.frame;
    frame.origin.x = self.frame.size.width - _badgeView.frame.size.width - 8;
    frame.origin.y = 5;
    _badgeView.frame = frame;
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"badgeValue"];
}

@end


