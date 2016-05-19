//
//  SettlementController.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MGSettlementBottomView.h"

@interface SettlementController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MGSettlementBottomViewDelegate>{
    NSMutableArray* settlementItemFrames;
}

@property(nonatomic,weak)UITableView* tableView;
@property(nonatomic,weak)MGSettlementBottomView* bottomView;


-(void)initItemFrames:(NSArray*)array;
@end
