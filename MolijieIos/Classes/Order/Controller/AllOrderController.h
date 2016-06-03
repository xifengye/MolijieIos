//
//  AllOrderController.h
//  MolijieIos
//
//  Created by yexifeng on 16/6/2.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllOrderController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView* tableView;
@end
