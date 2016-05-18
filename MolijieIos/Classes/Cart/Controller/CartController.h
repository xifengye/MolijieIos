//
//  MGMessageViewController.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface CartController : BaseTableViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray* orderLocalFrames;
}

@property(nonatomic,assign)BOOL navigationBarHidden;
@end
