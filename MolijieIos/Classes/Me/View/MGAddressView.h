//
//  MGAddressView.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/20.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressNoOperateCellFrame.h"
#import "MGBorderButton.h"

@interface MGAddressView : MGBorderButton
@property(nonatomic,strong)AddressNoOperateCellFrame* addressFrame;
@property(nonatomic,assign)CGFloat viewHeight;
@property(nonatomic,weak)UILabel* nameLabel;
@property(nonatomic,weak)UILabel* phoneLabel;
@property(nonatomic,weak)UILabel* addressLabel;

@end
