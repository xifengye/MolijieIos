//
//  MGMessageViewController.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MGCartBottomView.h"
#import "CartCell.h"

@interface CartController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CartCellDelegate,MGCartBottomViewDelegate>{
    NSMutableArray* cartItemFrames;
}
@property(nonatomic,weak)UITableView* tableView;
@property(nonatomic,weak)MGCartBottomView* bottomView;
@property(nonatomic,assign)BOOL navigationBarHidden;
@end
