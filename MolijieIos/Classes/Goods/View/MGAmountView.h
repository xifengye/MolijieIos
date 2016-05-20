//
//  MGAmountView.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/17.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGBorderButton.h"
@class MGAmountView;

@protocol MGAmountViewDelegate <NSObject>

@optional
-(void)didAmountValueChange:(MGAmountView*)view;

@end
@interface MGAmountView : UIButton{
    MGBorderButton* buttonMinus;
    MGBorderButton* buttonPlus;
    MGBorderButton* label;
}
@property(nonatomic,assign)NSUInteger amount;
@property(nonatomic,weak)id<MGAmountViewDelegate>delegate;
@end
