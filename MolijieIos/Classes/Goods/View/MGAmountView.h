//
//  MGAmountView.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/17.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGAmountView : UIView{
    UIButton* buttonMinus;
    UIButton* buttonPlus;
    UILabel* label;
}
@property(nonatomic,assign)NSUInteger amount;
@end
