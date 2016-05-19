//
//  MGBottomView.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/18.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGCartBottomView;
@protocol MGCartBottomViewDelegate <NSObject>

@optional
-(void)bottomViewDidCheckAllChange:(MGCartBottomView*)view;
-(void)bottomViewDidGoSettlement:(MGCartBottomView*)view;

@end

@interface MGCartBottomView : UIView
@property(nonatomic,weak)UIButton* btnSettlement;
@property(nonatomic,weak)UIButton* btnCheckAll;
@property(nonatomic,weak)UILabel* priceLabel;

@property(nonatomic,weak)id<MGCartBottomViewDelegate>delegate;

@end
