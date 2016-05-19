//
//  GoodsDetailBottomBar.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/15.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "GoodsDetailBottomBar.h"
#import "UIImage+MG.h"

@implementation GoodsDetailBottomBar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        CGFloat marginTop = 7;
        CGFloat marginLeft = 10;
        CGFloat imgWidth = frame.size.height-marginTop*2;
        
        UIImage* carImg = [UIImage imageNamed:@"cart_off"];
        UIButton* btnCar = [[UIButton alloc]initWithFrame:CGRectMake(marginLeft, marginTop, imgWidth, imgWidth)];
        [btnCar setImage:[UIImage imageNamed:@"cart_on"] forState:UIControlStateSelected];
        [btnCar setImage:carImg forState:UIControlStateNormal];
        [btnCar addTarget:self action:@selector(onCar) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnCar];
        self.btnCar = btnCar;
        
        MGBadgeView* badgeView = [[MGBadgeView alloc]init];
        badgeView.frame = CGRectMake(imgWidth, 0, 20, 20);
        [self addSubview:badgeView];
        self.badgeView = badgeView;
        [badgeView setBadgeValue:nil];
        
        UIImage* favouriteImg = [UIImage imageNamed:@"favorit_off"];
        UIButton* btnFavourite = [[UIButton alloc]initWithFrame:CGRectMake(imgWidth+marginLeft*3, marginTop, imgWidth, imgWidth)];
        [btnFavourite setImage:favouriteImg forState:UIControlStateNormal];
        [btnFavourite setImage:[UIImage imageNamed:@"favorit_on"] forState:UIControlStateSelected];
        [btnFavourite addTarget:self action:@selector(onFavourite) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnFavourite];
        self.btnFavourite = btnFavourite;
        
        
        UIFont* addFont = [UIFont systemFontOfSize:15];
        NSString* title = @"加入购物车";
        CGSize titleSize=  [title sizeWithFont:addFont];
        CGFloat addWidth = titleSize.width+10;
        CGRect addFrame = CGRectMake(frame.size.width-addWidth, 0, addWidth, frame.size.height);
        UIButton* btnAdd = [[UIButton alloc]initWithFrame:addFrame];
        [btnAdd setFont:addFont];
        [btnAdd setBackgroundImage:[UIImage createImageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        [btnAdd addTarget:self action:@selector(onAdd) forControlEvents:UIControlEventTouchUpInside];
        [btnAdd setTitle:title forState:UIControlStateNormal];
        [self addSubview:btnAdd];
        self.btnAdd = btnAdd;
        
        
        UIView* lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
    }
    return self;
}

-(void)onCar{
    
    if([self.delegate respondsToSelector:@selector(bottomBarDidClickedCar:)]){
        [self.delegate bottomBarDidClickedCar:self];
    }
}

-(void)onFavourite{
    self.btnFavourite.selected = !self.btnFavourite.selected;
    if([self.delegate respondsToSelector:@selector(bottomBarDidClickedFavourite:forStatus:)]){
        [self.delegate bottomBarDidClickedFavourite:self forStatus:self.btnFavourite.isSelected];
    }
}

-(void)onAdd{
    if([self.delegate respondsToSelector:@selector(bottomBarDidClickedAdd:)]){
        [self.delegate bottomBarDidClickedAdd:self];
    }
}

@end
