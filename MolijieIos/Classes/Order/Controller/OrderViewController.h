//
//  OrderViewController.h
//  MolijieIos
//
//  Created by yexifeng on 16/6/2.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "OrderCell.h"
typedef enum : NSUInteger {
    TAB_WAIT_SEND,
    TAB_WAIT_RECEIVE,
    TAB_WAIT_CONFIRM,
    TAB_ALL
} Tabs;

@interface OrderViewController : BaseViewController<OrderCellDelegate>
@property(nonatomic,assign)Tabs currentTab;
@property(nonatomic,assign)Tabs defaultTab;
@end
