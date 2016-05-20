//
//  MGAmountView.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/17.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "MGAmountView.h"


@implementation MGAmountView

-(instancetype)init{
    self = [super init];
    if(self){
        _amount = 1;
        MGBorderButton* btnMinus = [[MGBorderButton alloc]init];
        [btnMinus setTitle:@"-" forState:UIControlStateNormal];
        [btnMinus setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btnMinus setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btnMinus setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [self addSubview:btnMinus];
        buttonMinus = btnMinus;
        [btnMinus addTarget:self action:@selector(onMinus) forControlEvents:UIControlEventTouchUpInside];
        
        MGBorderButton* amountLabel = [[MGBorderButton alloc]init];
        label = amountLabel;
        [label setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:amountLabel];
        label.backgroundColor = [UIColor grayColor];
        
        MGBorderButton* btnPlus = [[MGBorderButton alloc]init];
        [btnPlus setTitle:@"+" forState:UIControlStateNormal];
        [btnPlus setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btnPlus setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btnPlus setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [self addSubview:btnPlus];
        buttonPlus = btnPlus;
        [btnPlus addTarget:self action:@selector(onPlus) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;

}

-(void)setAmount:(NSUInteger)amount{
    _amount = amount;
    [label setTitle:[NSString stringWithFormat:@"%ld",amount] forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    CGFloat buttonWidth = frame.size.width*0.28;
    buttonMinus.frame = CGRectMake(0, 0, buttonWidth,frame.size.height);
    label.frame = CGRectMake(buttonWidth+frame.size.width*0.02, 0, frame.size.width*0.4, frame.size.height);
    buttonPlus.frame = CGRectMake(frame.size.width-buttonWidth, 0, buttonWidth,frame.size.height);
}

-(void)onMinus{
    self.amount = self.amount-1;
     buttonMinus.enabled = _amount>1;
    if([self.delegate respondsToSelector:@selector(didChangeValueForKey:)]){
        [self.delegate didAmountValueChange:self];
    }
    
}

-(void)onPlus{
    self.amount = self.amount+1;
    buttonMinus.enabled = _amount>1;
    if([self.delegate respondsToSelector:@selector(didChangeValueForKey:)]){
        [self.delegate didAmountValueChange:self];
    }
}
@end
