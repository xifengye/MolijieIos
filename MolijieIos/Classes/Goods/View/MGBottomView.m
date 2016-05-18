//
//  MGBottomView.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/18.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "MGBottomView.h"
#import "UIImage+MG.h"

@implementation MGBottomView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor= [UIColor whiteColor];
        CGFloat btnSettlementWidth = 100;
        UIButton* btnSettlement = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-btnSettlementWidth, 0, btnSettlementWidth, frame.size.height)];
        [btnSettlement setBackgroundImage:[UIImage createImageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        [btnSettlement setBackgroundImage:[UIImage createImageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
        self.btnSettlement = btnSettlement;
        [self addSubview:btnSettlement];
        [btnSettlement setTitle:@"去结算" forState:UIControlStateNormal];
        [btnSettlement setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage* checkedImg = [UIImage imageNamed:@"checkbox_checked"];
        UIButton * btnCheckAll = [[UIButton alloc]initWithFrame:CGRectMake(10, (frame.size.height-checkedImg.size.height)/2, checkedImg.size.width , checkedImg.size.height)];
        [btnCheckAll setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
        [btnCheckAll setImage:checkedImg forState:UIControlStateSelected];
        [btnCheckAll setSelected:true];
        self.btnCheckAll = btnCheckAll;
        [self addSubview:btnCheckAll];
        
        UILabel* priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(checkedImg.size.width+10, 0, frame.size.width-checkedImg.size.width-10-btnSettlementWidth-10, frame.size.height)];
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
@end
