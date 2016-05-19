//
//  MGTitleButton.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/12.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGTitleButton.h"
#import "UIImage+MG.h"

@implementation MGTitleButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        isUpArrow = false;
        [self setBackgroundImage:[UIImage imageWithStretchable:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        self.adjustsImageWhenHighlighted = false;
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(turnArrow:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    CGSize titleSize = [title sizeWithFont:self.font];
    CGFloat titleViewHeight = MAX(titleSize.height, self.currentImage.size.height);
    self.frame = CGRectMake(0, 0,titleSize.width+self.currentImage.size.width+10, titleViewHeight);
    [self invalidateIntrinsicContentSize];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width-self.currentImage.size.width, contentRect.size.height);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(contentRect.size.width-self.currentImage.size.width,0,self.currentImage.size.width,contentRect.size.height);
}

-(void)turnArrow:(UIButton*)button{
    isUpArrow = !isUpArrow;
    [self setImage:[UIImage imageNamed:isUpArrow?@"navigationbar_arrow_up":@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    if(self.delegate){
        [self.delegate didDicrectChange:isUpArrow];
    }
    
}
@end
