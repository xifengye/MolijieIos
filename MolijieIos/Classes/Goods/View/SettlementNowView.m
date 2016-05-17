//
//  SettlementNowView.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/17.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "SettlementNowView.h"

@implementation SettlementNowView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        UIFont* font = [UIFont systemFontOfSize:14];
        self.backgroundColor = [UIColor grayColor];
        CGFloat labelWidth = frame.size.width/2-10;
        UILabel* tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, labelWidth, frame.size.height)];
        tipLabel.font = font;
        tipLabel.text = @"加入购物车成功";
        tipLabel.textColor = [UIColor redColor];
        [self addSubview:tipLabel];
        
        UILabel* settlementNowLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelWidth+10,0, labelWidth-10, frame.size.height)];
        settlementNowLabel.font = font;
        settlementNowLabel.textAlignment = NSTextAlignmentRight;
        settlementNowLabel.textColor = [UIColor whiteColor];
        settlementNowLabel.text = @"立即结算";
//        [self addSubview:settlementNowLabel];
        self.font = font;
        [self setTitle:@"立即结算" forState:UIControlStateNormal];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
    }
    return self;
    
}
@end
