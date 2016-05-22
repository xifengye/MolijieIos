//
//  MGAddressView.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/20.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "MGAddressView.h"
#import "Config.h"
#import "UIImage+MG.h"

@implementation MGAddressView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        UILabel* nameLabel = [[UILabel alloc]init];
        self.nameLabel = nameLabel;
        self.nameLabel.font = labelFont;
        [self addSubview:nameLabel];
        
        UILabel* phoneLabel = [[UILabel alloc]init];
        self.phoneLabel = phoneLabel;
        self.phoneLabel.font = labelFont;
        [self addSubview:phoneLabel];
        
        UILabel* addressLabel = [[UILabel alloc]init];
        self.addressLabel = addressLabel;
        self.addressLabel.font = labelFont;
        [self addSubview:addressLabel];
        
        UIImage* allowImg = [UIImage imageNamed:@"btn_back_pressed"];
        UIImageView* allowView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-20-allowImg.size.width,(frame.size.height-allowImg.size.height)/2 , allowImg.size.width, allowImg.size.height)];
        [allowView setImage:allowImg];
        [self addSubview:allowView];
        
    }
    
    return self;
}


-(void)setAddressFrame:(AddressNoOperateCellFrame *)addressFrame{
    _addressFrame = addressFrame;
    _nameLabel.frame = addressFrame.nameLabelF;
    _phoneLabel.frame = addressFrame.phoneLabelF;
    _addressLabel.frame = addressFrame.addressLabelF;

    _nameLabel.text = addressFrame.recipient.RealName;
    _phoneLabel.text = addressFrame.recipient.Mobile;
    _addressLabel.text = [addressFrame.recipient getSimpleAddress];

}

@end
