//
//  AddressController.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray* addressCellFrameList;
    
}
@property(nonatomic,weak)UITableView* tableView;
@property(nonatomic,assign)Boolean isSelectForSettlement;//是否是结算页面跳转过来选择地址的

@end
