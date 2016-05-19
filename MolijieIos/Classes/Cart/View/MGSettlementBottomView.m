//
//  MGSettlementBottomView.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "MGSettlementBottomView.h"
#import "UIImage+MG.h"

@implementation MGSettlementBottomView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor= [UIColor whiteColor];
        CGFloat btnCommitWidth = 100;
        CGFloat labelWidth = frame.size.width-100-10;
        UIButton* btnCommit = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-btnCommitWidth, 0, btnCommitWidth, frame.size.height)];
        [btnCommit setBackgroundImage:[UIImage createImageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        [btnCommit setBackgroundImage:[UIImage createImageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
        [btnCommit setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
        self.btnCommit = btnCommit;
        [self addSubview:btnCommit];
        [btnCommit setTitle:@"提交订单" forState:UIControlStateNormal];
        [btnCommit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnCommit addTarget:self action:@selector(goCommit) forControlEvents:UIControlEventTouchUpInside];
        
        UIFont* font = [UIFont systemFontOfSize:14];
        CGSize labelSize = [@"共计" sizeWithFont:font];
        UILabel* freightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelWidth, labelSize.height)];
        [freightLabel setTextColor:[UIColor blackColor]];
        self.freightLabel = freightLabel;
        freightLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:freightLabel];
        
        UILabel* priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-labelSize.height-3, labelWidth, labelSize.height)];
        [priceLabel setTextColor:[UIColor orangeColor]];
        self.priceLabel = priceLabel;
        priceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:priceLabel];
        
        UIView* lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
        
        
    }
    return self;
}


-(void)goCommit{
    if([self.delegate respondsToSelector:@selector(bottomViewDidCommit:)]){
        [self.delegate bottomViewDidCommit:self];
    }
    
}
@end
