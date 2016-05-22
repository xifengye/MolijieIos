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
#import "MGAddressView.h"

@interface SettlementController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MGSettlementBottomViewDelegate>{
    NSMutableArray* settlementItemFrames;
    AddressNoOperateCellFrame* addressNoOperateCellFrame;
    Recipient* recipient;
    
}

@property(nonatomic,weak)UITableView* tableView;
@property(nonatomic,weak)MGSettlementBottomView* bottomView;


-(void)initItemFrames:(NSArray*)array;
@end
