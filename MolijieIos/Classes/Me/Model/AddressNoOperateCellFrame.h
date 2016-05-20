//
//  AddressNoOperateCellFrame.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/20.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Recipient.h"

#define  margin  7.0

@interface AddressNoOperateCellFrame : NSObject

@property(nonatomic,strong)Recipient* recipient;
@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,assign,readonly)CGRect nameLabelF;
@property(nonatomic,assign,readonly)CGRect phoneLabelF;
@property(nonatomic,assign,readonly)CGRect addressLabelF;


@end
