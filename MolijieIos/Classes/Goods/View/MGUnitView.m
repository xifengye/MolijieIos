//
//  MGUnitView.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/16.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "MGUnitView.h"
#import "UIImage+MG.h"

@implementation MGUnitView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundImage:[UIImage imageWithStretchable:@"block_normal"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithStretchable:@"block_selected"] forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageWithStretchable:@"block_un_enable"] forState:UIControlStateDisabled];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

-(void)setSkuValue:(CompositeSKUValue *)skuValue{
    _skuValue = skuValue;
    [self setTitle:skuValue.Titile forState:UIControlStateNormal];
}

@end
