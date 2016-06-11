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
    
    CGSize labelSize = [@"叶" sizeWithFont:mljLabelFont];
    _nameLabelF = CGRectMake(_margin*2, _margin*2, screenWidth/2-_margin*3, labelSize.height);
    _phoneLabelF = CGRectMake(CGRectGetMaxX(_nameLabelF)+_margin*3, _margin*2, _nameLabelF.size.width, labelSize.height);
    CGSize addressSize = [recipient.Address sizeWithFont:mljLabelFont constrainedToSize:CGSizeMake(screenWidth-_margin*2, MAXFLOAT)];
    _addressLabelF = CGRectMake(_margin*2, CGRectGetMaxY(_nameLabelF)+_margin, screenWidth-_margin*4, addressSize.height);
    _cellHeight = CGRectGetMaxY(_addressLabelF)+_margin;
    
}





@end
