//
//  MGMessageViewController.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MGBottomView.h"

@interface CartController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray* orderLocalFrames;
}
@property(nonatomic,weak)UITableView* tableView;
@property(nonatomic,weak)MGBottomView* bottomView;
@property(nonatomic,assign)BOOL navigationBarHidden;
@end
