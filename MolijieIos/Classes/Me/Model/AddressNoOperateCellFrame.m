//
//  AddressNoOperateCellFrame.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/20.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "AddressNoOperateCellFrame.h"
#import "Config.h"

@implementation AddressNoOperateCellFrame

-(void)setRecipient:(Recipient *)recipient{
    _recipient = recipient;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGSize labelSize = [@"叶" sizeWithFont:labelFont];
    _nameLabelF = CGRectMake(margin*2, margin*2, screenWidth/2-margin*3, labelSize.height);
    _phoneLabelF = CGRectMake(CGRectGetMaxX(_nameLabelF)+margin*3, margin*2, _nameLabelF.size.width, labelSize.height);
    CGSize addressSize = [recipient.Address sizeWithFont:labelFont constrainedToSize:CGSizeMake(screenWidth-margin*2, MAXFLOAT)];
    _addressLabelF = CGRectMake(margin*2, CGRectGetMaxY(_nameLabelF)+margin, screenWidth-margin*4, addressSize.height);
    _cellHeight = CGRectGetMaxY(_addressLabelF)+margin;
    
}





@end
