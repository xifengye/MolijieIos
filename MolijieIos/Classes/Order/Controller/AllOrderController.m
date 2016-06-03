//
//  AllOrderController.m
//  MolijieIos
//
//  Created by yexifeng on 16/6/2.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "AllOrderController.h"
#import "OrderViewController.h"

@implementation AllOrderController
-(void)viewDidLoad{
    UITableView* tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self.parentViewController;
    tableView.dataSource = self.parentViewController;
}

-(void)viewWillAppear:(BOOL)animated{
    OrderViewController* controller = (OrderViewController*)self.parentViewController;
    controller.currentTab = TAB_ALL;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

@end
