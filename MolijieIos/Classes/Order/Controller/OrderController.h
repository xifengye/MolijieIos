//
//  OrderController.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/28.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSlideView.h"
#import "YLSlideConfig.h"
#import "YLSlideCell.h"
#import "YGPCache.h"
#import "OrderCell.h"

@interface OrderController : UIViewController<YLSlideViewDelegate,UITableViewDataSource,UITableViewDelegate,OrderCellDelegate>
@end
