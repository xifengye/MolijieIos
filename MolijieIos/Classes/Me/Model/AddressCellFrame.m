//
//  AddressCellFrame.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/20.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "AddressCellFrame.h"
#import <UIKit/UIKit.h>


@implementation AddressCellFrame

-(void)setRecipient:(Recipient *)recipient{
    [super setRecipient:recipient];
    _lineViewF = CGRectMake(margin*2,self.cellHeight ,self.addressLabelF.size.width , 0.5f);
     UIImage* checkedImg = [UIImage imageNamed:@"checkbox_checked"];
    _btnDefaultF =CGRectMake(margin*2,CGRectGetMaxY(_lineViewF)+margin, checkedImg.size.width, checkedImg.size.height);
    _defaultLabelF = CGRectMake(margin*2+checkedImg.size.width,  _btnDefaultF.origin.y+(checkedImg.size.height-self.nameLabelF.size.height)/2, 200, self.nameLabelF.size.height);
     CGSize deleteImageSize = [UIImage imageNamed:@"ico_delete"].size;
    _btnDeleteF = CGRectMake(_lineViewF.size.width-deleteImageSize.width-margin,_btnDefaultF.origin.y+(checkedImg.size.height-deleteImageSize.height)/2, deleteImageSize.width, deleteImageSize.height);
    [self setCellHeight:CGRectGetMaxY(_btnDefaultF)+margin*2];
}

@end
