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
        UIImage* carImg = [UIImage imageNamed:@"main_article_selected"];
        UIButton* btnCar = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, carImg.size.width, frame.size.height)];
        [btnCar setImage:carImg forState:UIControlStateNormal];
        [btnCar addTarget:self action:@selector(onCar) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btnCar];
        self.btnCar = btnCar;
        
        UIImage* favouriteImg = [UIImage imageNamed:@"main_article_selected"];
        UIButton* btnFavourite = [[UIButton alloc]initWithFrame:CGRectMake(carImg.size.width+10, 0, favouriteImg.size.width, frame.size.height)];
        [btnFavourite setImage:favouriteImg forState:UIControlStateNormal];
        [btnFavourite addTarget:self action:@selector(onFavourite) forControlEvents:UIControlEventTouchDown];
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
        [btnAdd addTarget:self action:@selector(onAdd) forControlEvents:UIControlEventTouchDown];
        [btnAdd setTitle:title forState:UIControlStateNormal];
        [self addSubview:btnAdd];
        self.btnAdd = btnAdd;
        
        
    }
    return self;
}

-(void)onCar{
    if([self.delegate respondsToSelector:@selector(bottomBarDidClickedCar:)]){
        [self.delegate bottomBarDidClickedCar:self];
    }
}

-(void)onFavourite{
    if([self.delegate respondsToSelector:@selector(bottomBarDidClickedFavourite:)]){
        [self.delegate bottomBarDidClickedFavourite:self forStatus:self.btnFavourite.isSelected];
    }
}

-(void)onAdd{
    if([self.delegate respondsToSelector:@selector(bottomBarDidClickedAdd:)]){
        [self.delegate bottomBarDidClickedAdd:self];
    }
}

@end
