//
//  BaseTableViewController.m
//  MolijieIos
//
//  Created by yexifeng on 15/12/4.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController
-(void)viewDidLoad{
    [self.navigationController setNavigationBarHidden:self.hiddenNavigationBar];
}

-(BOOL)hiddenNavigationBar{
    return true;
}
@end
