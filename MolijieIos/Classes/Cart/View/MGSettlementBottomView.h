//
//  MGSettlementBottomView.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGSettlementBottomView;
@protocol MGSettlementBottomViewDelegate <NSObject>

@optional
-(void)bottomViewDidCommit:(MGSettlementBottomView*)view;

@end

@interface MGSettlementBottomView : UIView



@property(nonatomic,weak)UIButton* btnCommit;
@property(nonatomic,weak)UILabel* priceLabel;
@property(nonatomic,weak)UILabel* freightLabel;

@property(nonatomic,weak)id<MGSettlementBottomViewDelegate>delegate;
@end
