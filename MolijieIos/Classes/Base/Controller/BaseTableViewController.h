//
//  BaseTableViewController.h
//  MolijieIos
//
//  Created by yexifeng on 15/12/4.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController
-(BOOL) hiddenNavigationBar;
-(UIScrollView*)adjustContentInsetView;
@end
